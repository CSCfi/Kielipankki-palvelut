FFMPEG Role based on  dorftv.ffmpeg
===================================

Compiles and installs ffmpeg with configurable versions and features like x265, x264, opus, fdk-aac, vpx and decklink capture.


Role Variables
--------------

```yml
---
ffmpeg_source_dir: "/usr/local/src"
ffmpeg_lib_dir: "/usr/local/lib"
ffmpeg_bin_dir: "/usr/local/bin"

# add custom compile options to ffmpeg
ffmpeg_version: "master"

# allows add additional flags to ffmpeg eg --enable-v4l2
ffmpeg_compile_options_custom:  


# enable features and configure options

ffmpeg_x265: True
ffmpeg_x265_revision: "default"

ffmpeg_rtmp: True
ffmpeg_rtmp_version: "master"

ffmpeg_x264: True
ffmpeg_x264_version: "master"

ffmpeg_fdkaac: True
ffmpeg_fdkaac_version: "master"

ffmpeg_opus: True
ffmpeg_opus_version: "master"

ffmpeg_vpx: True
ffmpeg_vpx_versoin: "master"

ffmpeg_decklink: True
ffmpeg_decklink_sdk: "/tmp/decklink/include"

ffmpeg_cleanup: True


# some default ffmpeg configure options
ffmpeg_compile_options: --enable-nonfree --enable-gpl  --extra-libs=-ldl --enable-libass --enable-libmp3lame --enable-libtheora --enable-libvorbis 

```



Example Playbook
----------------
Example playbook to compile and install ffmpeg locally.

```yml

- hosts: localhost
  become: yes
  roles:
     - { role: dorftv.ffmpeg, ffmpeg_opus: False, ffmpeg_bin_dir: "/usr/bin" }
```         
Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.         

License
-------

GPLv2
exept Black Magic SDK in files/include.

Author Information
------------------

This playbook is used to create the [dorftv/ffmpeg-core](https://hub.docker.com/r/dorftv/ffmpeg-core/) docker image.


