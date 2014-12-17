all:
	cp -f share/Makefile.gen prelude/DATS/CODEGEN/
	cp -f share/Makefile.gen prelude/DATS/SHARE/CODEGEN/
	cp -f share/Makefile.gen prelude/SATS/CODEGEN/
	cp -f share/Makefile.gen prelude/CATS/CODEGEN/
	cp -f share/Makefile.gen libats/SATS/CODEGEN/
	cp -f share/Makefile.gen libats/ML/SATS/CODEGEN/
	cp -f share/Makefile.gen libc/sys/CATS/CODEGEN/
	cp -f share/Makefile.gen libc/SATS/CODEGEN/
	cp -f share/Makefile.gen libc/CATS/CODEGEN/
	(export PATSHOME=`cygpath -u $$APPVEYOR_BUILD_FOLDER` && \
	 make -f codegen/Makefile_atslib && \
	 make -f Makefile_devl src_depend && \
	 make -f Makefile_devl)
