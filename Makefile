build :
	$(MAKE) linux
	$(MAKE) windows

clean :
	rm --force --recursive releases

linux : linux/bin linux/sbin releases/linux
	tar --create --file releases/linux/bin.tar --mode 0755 --owner root --group root --strip-components 1 --transform 's/linux/usr\/local/' linux/bin
	tar --create --file releases/linux/sbin.tar --mode 0755 --owner root --group root --strip-components 1 --transform 's/linux/usr\/local/' linux/sbin

windows : windows/aliases releases/windows
	lcab -nr windows/aliases releases/windows/aliases.cab

install :
	sudo apt-get update && sudo apt-get install -y lcab

releases/windows :
	mkdir --parent releases/windows

windows/aliases :
	mkdir --parent windows/aliases

releases/linux :
	mkdir --parent releases/linux

linux/sbin :
	mkdir --parent linux/sbin

linux/bin :
	mkdir --parent linux/bin
