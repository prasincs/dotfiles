# Special setup for Lenovo Thinkpad



## Touchpad

Tools:
apt-get install evtest

may need to find a proper value

https://wiki.ubuntu.com/DebuggingTouchpadDetection/evtest

```
cp /usr/share/X11/xorg.conf.d/70-synaptics.conf{,.backup}
cp synaptics.conf /usr/share/X11/xorg.conf.d/70-synaptics.conf
```
