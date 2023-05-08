#! /bin/bash

#Installing ffmpeg dependencies
yum -y update
yum -y install make
#Installing ffmpeg from static build
cd /usr/local/bin
mkdir ffmpeg && cd ffmpeg
wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz
tar -xf ffmpeg-release-amd64-static.tar.xz
cp -a /usr/local/bin/ffmpeg/ffmpeg-6.0-amd64-static/ . /usr/local/bin/ffmpeg/
ln -s /usr/local/bin/ffmpeg/ffmpeg /usr/bin/ffmpeg
#Installing gnu parallel
cd ~
yum install parallel -y
mkdir camera