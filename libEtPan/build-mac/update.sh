#!/bin/sh

if test ! -d libetpan.xcodeproj ; then
	exit 1;
fi

ROOTDIR=`pwd`

cd ..
./autogen.sh
make stamp-prepare-target
make libetpan-config.h
cd build-mac
mkdir -p ${ROOTDIR}/include/libetpan
cp -r ../include/libetpan/ ${ROOTDIR}/include/libetpan/
cp ../config.h ${ROOTDIR}/include
cp ../libetpan-config.h ${ROOTDIR}/include
sed -i.original 's/^#define HAVE_CURL 1$/\/\/#define HAVE_CURL 1/' ${ROOTDIR}/include/config.h
sed -i '' 's/^\#define HAVE_EXPAT 1/\/\/\#define HAVE_EXPAT 1/g' ${ROOTDIR}/include/config.h

rm -rf SASL-SSL-for-iOS
git clone git://github.com/miyabichan/SASL-SSL-for-iOS.git

pushd SASL-SSL-for-iOS
sh ./build-libraries.sh
popd

rm -rf lib
cp -R ${ROOTDIR}/SASL-SSL-for-iOS/lib .
rm -rf SASL-SSL-for-iOS