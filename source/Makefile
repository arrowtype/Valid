# --------------------------------------------------------
#  Python 3 virtual environment directory
#    NOTE: This must match the path defined in the root
#          level Makefile
# --------------------------------------------------------
VENV_DIR=.venv

# --------------------------------------------------------
#  fontmake compiler executable
#    NOTE: this builds from a venv install to support
#          pinned dependency versions
# --------------------------------------------------------
FONTMAKE_EXE=../$(VENV_DIR)/bin/fontmake
TTX_EXE=../$(VENV_DIR)/bin/ttx

# --------------------------------------------------------
#  Source file path definitions
# --------------------------------------------------------
SOURCE=Valid.glyphs
UFO_SOURCE_DIR=ufo

# --------------------------------------------------------
#  Build directory path definitions
# --------------------------------------------------------
FONT_BUILD_DIR=../build/Valid
TABLES_DIR=tables

# Static paths
STATIC_BUILD_DIR=$(FONT_BUILD_DIR)/static
STATIC_TTX_DIR=$(STATIC_BUILD_DIR)/ttx

STATIC_TTX_DIR_OTF=$(STATIC_TTX_DIR)/otf
STATIC_TTX_DIR_OTF_TABLES=$(STATIC_TTX_DIR_OTF)/$(TABLES_DIR)

STATIC_TTX_DIR_TTF=$(STATIC_TTX_DIR)/ttf
STATIC_TTX_DIR_TTF_TABLES=$(STATIC_TTX_DIR_TTF)/$(TABLES_DIR)

STATIC_TTX_DIR_WOFF2=$(STATIC_TTX_DIR)/woff2
STATIC_TTX_DIR_WOFF2_TABLES=$(STATIC_TTX_DIR_WOFF2)/$(TABLES_DIR)

# Variable paths
VARIABLE_BUILD_DIR=$(FONT_BUILD_DIR)/variable
VARIABLE_TTX_DIR=$(VARIABLE_BUILD_DIR)/ttx

VARIABLE_TTX_DIR_TTF=$(VARIABLE_TTX_DIR)/ttf
VARIABLE_TTX_DIR_TTF_TABLES=$(VARIABLE_TTX_DIR_TTF)/$(TABLES)

# --------------------------------------------------------
#  UFO intermediates and designspace paths
# --------------------------------------------------------
MASTER_UFO_DIR=$(UFO_SOURCE_DIR)/master
INSTANCE_UFO_DIR=$(UFO_SOURCE_DIR)/instance

DESIGNSPACE=Valid.designspace
DESIGNSPACE_PATH=$(MASTER_UFO_DIR)/$(DESIGNSPACE)

# --------------------------------------------------------
#  TARGETS
# --------------------------------------------------------

#
# Full font family build targets
#

static: build-dirs
	# $(FONTMAKE_EXE) -g $(SOURCE) --interpolate --output otf ttf --output-dir $(STATIC_BUILD_DIR) --master-dir $(MASTER_UFO_DIR) --instance-dir $(INSTANCE_UFO_DIR)
	$(FONTMAKE_EXE) -g $(SOURCE) --output otf ttf --output-dir $(STATIC_BUILD_DIR) --master-dir $(MASTER_UFO_DIR) --instance-dir $(INSTANCE_UFO_DIR)
	
	$(TTX_EXE) -f -d $(STATIC_TTX_DIR_OTF) $(STATIC_BUILD_DIR)/*.otf
	$(TTX_EXE) -f -d $(STATIC_TTX_DIR_OTF_TABLES) -s $(STATIC_BUILD_DIR)/*.otf

	$(TTX_EXE) -f -d $(STATIC_TTX_DIR_TTF) $(STATIC_BUILD_DIR)/*.ttf
	$(TTX_EXE) -f -d $(STATIC_TTX_DIR_TTF_TABLES) -s $(STATIC_BUILD_DIR)/*.ttf

	$(TTX_EXE) -f --flavor=woff2 -d $(STATIC_BUILD_DIR) $(STATIC_TTX_DIR_TTF)/*.ttx
	$(TTX_EXE) -f -d $(STATIC_TTX_DIR_WOFF2) $(STATIC_BUILD_DIR)/*.woff2
	$(TTX_EXE) -f -d $(STATIC_TTX_DIR_WOFF2_TABLES) -s $(STATIC_BUILD_DIR)/*.woff2


vf: build-dirs
	$(FONTMAKE_EXE) -g $(SOURCE) -o variable --output-dir $(VARIABLE_BUILD_DIR) --master-dir $(MASTER_UFO_DIR) --instance-dir $(INSTANCE_UFO_DIR)

	$(TTX_EXE) -f -d $(VARIABLE_TTX_DIR_TTF) $(VARIABLE_BUILD_DIR)/*.ttf
	$(TTX_EXE) -f -d $(VARIABLE_TTX_DIR_TTF_TABLES) -s $(VARIABLE_BUILD_DIR)/*.ttf

#
#  Design space build targets
#

build-designspace: $(MASTER_UFO_DIR) $(INSTANCE_UFO_DIR)
	$(FONTMAKE_EXE) -g $(SOURCE) -o ufo --master-dir $(MASTER_UFO_DIR) --instance-dir $(INSTANCE_UFO_DIR)


#
# Utilities
#

build-dirs: $(FONT_BUILD_DIR) $(MASTER_UFO_DIR) $(INSTANCE_UFO_DIR) $(STATIC_TTX_DIR_OTF_TABLES) $(STATIC_TTX_DIR_TTF_TABLES) $(STATIC_TTX_DIR_WOFF2_TABLES) $(VARIABLE_TTX_DIR_TTF_TABLES)


$(FONT_BUILD_DIR):
	mkdir -p $(FONT_BUILD_DIR)

$(MASTER_UFO_DIR):
	mkdir -p $(MASTER_UFO_DIR)

$(INSTANCE_UFO_DIR):
	mkdir -p $(INSTANCE_UFO_DIR)

$(STATIC_TTX_DIR_OTF_TABLES):
	mkdir -p $(STATIC_TTX_DIR_OTF_TABLES)

$(STATIC_TTX_DIR_TTF_TABLES):
	mkdir -p $(STATIC_TTX_DIR_TTF_TABLES)

$(STATIC_TTX_DIR_WOFF2_TABLES):
	mkdir -p $(STATIC_TTX_DIR_WOFF2_TABLES)

$(VARIABLE_TTX_DIR_TTF_TABLES):
	mkdir -p $(VARIABLE_TTX_DIR_TTF_TABLES)

.PHONY: build-designspace static vf
