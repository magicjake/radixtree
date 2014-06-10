ACE_UNIT_FILES=AceUnit.c AceUnit.h AceUnitData.c AceUnitAnnotations.h AceUnitLogging.h FullPlainLogger.c AceUnit.jar

ACE_UNIT_PATH=/home/jacob/dev/c-prog/dogeonparser/aceunit-0.12.0/src

FIXTURE_NAME=RadixTest

DSON_FILES= RadixTree.c RadixTree.h

all: prepare compile

clean:
	rm -f $(ACE_UNIT_FILES) $(FIXTURE_NAME).h runTests

prepare: $(ACE_UNIT_FILES)

AceUnit.c: $(ACE_UNIT_PATH)/native/AceUnit.c
	cp $< $@

AceUnit.h: $(ACE_UNIT_PATH)/native/AceUnit.h
	cp $< $@

AceUnitData.c: $(ACE_UNIT_PATH)/native/AceUnitData.c
	cp $< $@

AceUnitAnnotations.h: $(ACE_UNIT_PATH)/native/AceUnitAnnotations.h
	cp $< $@

AceUnitLogging.h: $(ACE_UNIT_PATH)/native/AceUnitLogging.h
	cp $< $@

FullPlainLogger.c: $(ACE_UNIT_PATH)/native/FullPlainLogger.c
	cp $< $@

AceUnit.jar: $(ACE_UNIT_PATH)/java/AceUnit.jar
	cp $< $@

$(ACE_UNIT_PATH)/java/AceUnit.jar:
	(cd $(ACE_UNIT_PATH)/java ; ant)

compile: runTests

$(FIXTURE_NAME).h: AceUnit.jar $(FIXTURE_NAME).c
	java -jar AceUnit.jar $(FIXTURE_NAME)

runTests: $(FIXTURE_NAME).c $(FIXTURE_NAME).h $(ACE_UNIT_FILES) $(DSON_FILES)
	$(CC) -I $(ACE_UNIT_PATH)/native/ -g -o runTests *.c
