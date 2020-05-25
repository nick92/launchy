# launchy

![launchy](data/screenshot.png)

## Installing and Running 

### Dependencies 

	libgee-0.8-dev
	libgnome-menu-3-dev
 	libgtk-3-dev
 	libjson-glib-dev
 	libplank-dev
 	libsoup2.4-dev
	libunity-dev
	libwnck-3-dev
	libzeitgeist-2.0-dev (optional)
	pkg-config
	valac

### Build and install 

Just type from a command line:

	meson build --prefix=/usr
	cd build
	ninja
	sudo make install
	./src/launchy
