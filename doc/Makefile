SUBDIRS := BOOK/INT2PROGINATS BOOK/ATS2TUTORIAL 

regress cleanall:: ; \
	set -e; \
	for i in $(SUBDIRS); do \
		$(MAKE) -C $$i $@; \
	done

.PHONY: regress cleanall
