help:
	@echo "###"
	@echo "# Build targets for Nextria Variable"
	@echo "###"
	@echo
	@echo "  make build:  Builds the fonts and places them in the fonts/ directory"
	@echo "  make zip:  Zip all fonts into a zip"
	@echo

init: requirements.txt
	pip install -Ur requirements.txt
	touch init.stamp

build: build.stamp

# fontmake -m "fonts-temp/master-ufo/InterNumeric.designspace" -o variable --output-path "fonts/variable/InterNumeric[wght,RDNS].ttf" --filter DecomposeTransformedComponentsFilter --verbose DEBUG
# fontmake -m "fonts-temp/master-ufo/InterNumeric.designspace" -o variable-cff2 --output-path "fonts/variable/InterNumeric[wght,RDNS].otf"


build.stamp: init.stamp
	fontmake -g "src/Nextria-Variable.glyphspackage" -o ufo --output-dir "fonts-temp/master-ufo" --filter DecomposeTransformedComponentsFilter
	python scripts/stat.py
	fontmake -m "fonts-temp/master-ufo/NextriaVariable.designspace" -o variable --output-path "fonts-temp/variable/NextriaVariable[SRIF,slnt,wght].ttf" -f
#	fontmake -m "fonts-temp/master-ufo/NextriaVariable.designspace" -o variable-cff2 --output-path "fonts-temp/variable/NextriaSC[SRIF,slnt,wght].otf"
	mkdir fonts
	mkdir fonts/variable
	gftools fix-nonhinting "fonts-temp/variable/NextriaVariable[SRIF,slnt,wght].ttf" "fonts/variable/NextriaVariable[SRIF,slnt,wght].ttf"
	touch build.stamp

zip: build.stamp
	cp -rf fonts NextriaVariable
	zip -r NextriaVariable.zip NextriaVariable
	rm -rf NextriaVariable


# fontbakery check-adobefonts "fonts/variable/InterNumeric[wght,RDNS].ttf"

test: build.stamp
	fontbakery check-universal "fonts/variable/NextriaVariable[SRIF,slnt,wght].ttf"

test-google: build.stamp
	fontbakery check-googlefonts "fonts/variable/NextriaVariable[SRIF,slnt,wght].ttf"

clean:
	rm -rf fonts
	rm -rf fonts-temp
	rm build.stamp

update:
	pip install -Ur requirements.txt
