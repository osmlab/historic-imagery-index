ALL = imagery.geojson imagery.json imagery.xml
COMMON_SOURCES = $(shell find editor-imagery-index/sources -type f -name '*.json' | sort)
HISTORIC_SOURCES = $(shell find sources -type f -name '*.json' | sort)
SOURCES = $(COMMON_SOURCES) $(HISTORIC_SOURCES)
all: $(ALL)

check:
	@python scripts/check.py $(SOURCES)

clean:
	rm $(ALL)

imagery.xml: $(SOURCES)
	python scripts/convert_xml.py $(SOURCES)

imagery.json: $(SOURCES)
	python scripts/concat.py $(SOURCES) > imagery.json

imagery.geojson: imagery.xml
	python scripts/convert_geojson.py imagery.xml > imagery.geojson
