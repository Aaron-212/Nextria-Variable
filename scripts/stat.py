from fontTools.designspaceLib import DesignSpaceDocument, AxisLabelDescriptor, LocationLabelDescriptor

"""
    Add a STAT table to the Designspace document as a preprocessing before
    using fontmake to compile the UFOs to the final binary font.
"""

path = "fonts-temp/master-ufo/NextriaVariable.designspace"
dsfile = DesignSpaceDocument.fromfile(path)

wghtAxisLabels = [
    AxisLabelDescriptor(name="ExtraLight", userValue=200, userMinimum=200, userMaximum=250),
    AxisLabelDescriptor(name="Light", userValue=300, userMinimum=250, userMaximum=350),
    AxisLabelDescriptor(name="Regular", userValue=400, userMinimum=350, userMaximum=450, elidable=True),
    AxisLabelDescriptor(name="Medium", userValue=500, userMinimum=450, userMaximum=550),
    AxisLabelDescriptor(name="SemiBold", userValue=600, userMinimum=550, userMaximum=650),
    AxisLabelDescriptor(name="Bold", userValue=700, userMinimum=650, userMaximum=700),
]
dsfile.getAxisByTag("wght").axisLabels = wghtAxisLabels

slntAxisLabels = [
    AxisLabelDescriptor(name="Regular", userValue=0, userMinimum=-5, userMaximum=0, elidable=True),
    AxisLabelDescriptor(name="Slant", userValue=-10, userMinimum=-10, userMaximum=-5),
]
dsfile.getAxisByTag("slnt").axisLabels = slntAxisLabels

SRIFAxisLabels = [
    AxisLabelDescriptor(name="Regular", userValue=0, userMinimum=0, userMaximum=0.1, elidable=True),
    AxisLabelDescriptor(name="Flare", userValue=0.2, userMinimum=0.1, userMaximum=0.3),
    AxisLabelDescriptor(name="Serif", userValue=1, userMinimum=0.3, userMaximum=1),
]
dsfile.getAxisByTag("SRIF").axisLabels = SRIFAxisLabels

locationLabels = [
    LocationLabelDescriptor(name="Regular", userLocation=dict(Weight=400, Slant=0, Serif=0)),
]
for label in locationLabels:
    dsfile.addLocationLabel(label)


dsfile.write(path)
