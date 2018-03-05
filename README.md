# System monitor wingpanel indicator for elementary OS

Currently the indicator show CPU and RAM usage.

![Screenshot](data/images/screenshot.png)

## Building and Installation

You'll need the following dependencies:

```
libglib2.0-dev
libgranite-dev
libgtk-3-dev
libwingpanel-2.0-dev
meson
valac
```


Run `meson` to configure the build environment and then `ninja` to build

```
meson build --prefix=/usr
cd build
ninja
```

To install, use `ninja install`

```
sudo ninja install
```


### TODO:
Extend this indicator to replace [System Load Indicator](https://launchpad.net/indicator-multiload)