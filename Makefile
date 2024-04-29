.PHONY: install
install:
	install -D pi-usb-automount $(DESTDIR)$(PREFIX)/bin/pi-usb-automount
	install -Dm644 pi-usb-automount.rules $(DESTDIR)$(PREFIX)/lib/udev/rules.d/99-pi-usb-automount.rules
	install -Dm644 pi-usb-automount@.service $(DESTDIR)$(PREFIX)/lib/systemd/system/pi-usb-automount@.service
	install -d $(DESTDIR)/etc/pi-usb-automount.d
	install -Cm644 pi-usb-automount.d/* $(DESTDIR)/etc/pi-usb-automount.d/
	install -Dm644 LICENSE $(DESTDIR)/usr/share/doc/pi-usb-automount/LICENSE
	install -Dm644 README.md $(DESTDIR)/usr/share/doc/pi-usb-automount/README.md
