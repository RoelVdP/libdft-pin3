# Dependencies:
# sudo apt-get install gcc-multilib g++-multilib

CC=clang
CXX=clang++

LIBDFT_SRC			= src
LIBDFT_TOOL			= tools
LIBDFT_TEST			= tests
LIBDFT_TAG_FLAGS	?= -DLIBDFT_TAG_TYPE=libdft_tag_uint8
# LIBDFT_TAG_FLAGS	?= -DUSE_SET_TAG=1
# LIBDFT_TAG_FLAGS	?= -DUSE_U8_TAG=1
# LIBDFT_TAG_FLAGS	?= -DUSE_TREE_TAG=1


.PHONY: all
all: dftsrc tool #test

.PHONY: dftsrc mytool
dftsrc: $(LIBDFT_SRC)
	cd $< && CPPFLAGS=$(CPPFLAGS) DFTFLAGS=$(LIBDFT_TAG_FLAGS) make

tool: $(LIBDFT_TOOL)
	cd $< && TARGET=ia32 CPPFLAGS=$(CPPFLAGS) DFTFLAGS=$(LIBDFT_TAG_FLAGS) make
	# cd $< && TARGET=intel64 CPPFLAGS=$(CPPFLAGS) DFTFLAGS=$(LIBDFT_TAG_FLAGS) make

test: $(LIBDFT_TEST)
	cd $< && TARGET=ia32 CPPFLAGS=$(CPPFLAGS) DFTFLAGS=$(LIBDFT_TAG_FLAGS) make
	

.PHONY: clean
clean:
	cd $(LIBDFT_SRC) && make clean
	cd $(LIBDFT_TOOL) && make clean
	cd $(LIBDFT_TEST) && make clean
