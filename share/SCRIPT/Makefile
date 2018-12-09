######
# For calling build_release
######

ATSVER=0.0.0
BUILD_RELEASE=./build_release.sh

######

all:: both
all:: contrib

######

int: ; \
bash $(BUILD_RELEASE) $(ATSVER) intknd
gmp: ; \
bash $(BUILD_RELEASE) $(ATSVER) gmpknd

######

both:: ; \
bash $(BUILD_RELEASE) $(ATSVER) intknd
both:: ; \
bash $(BUILD_RELEASE) $(ATSVER) gmpknd

######

contrib: ; \
bash $(BUILD_RELEASE) $(ATSVER) contrib

######

###### end of [Makefile] ######
