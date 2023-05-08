#! /bin/bash
yum -y update
#Installing gnu parallel
yum install parallel -y
#Installing ffmpeg dependencies
yum -y install make
#Installing ffmpeg from static build
cd /usr/local/bin
mkdir ffmpeg && cd ffmpeg
wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz
tar -xf ffmpeg-release-amd64-static.tar.xz
cp -a /usr/local/bin/ffmpeg/ffmpeg-6.0-amd64-static/ . /usr/local/bin/ffmpeg/
ln -s /usr/local/bin/ffmpeg/ffmpeg /usr/bin/ffmpeg