.DEFAULT_GOAL := install

install:
	./system/install.sh
update:
	./system/update.sh
	./system/copy.sh
copy:
	./system/copy.sh
