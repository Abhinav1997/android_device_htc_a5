#!/sbin/sh

set -e

modelid=`getprop ro.boot.mid`

case $modelid in
	0P9C50000|0P9C51000)	variant="dwg" ;;
	0P9C70000)		variant="dug" ;;
	0P9C30000)		variant="chl" ;;
	*)			variant="gsm" ;;
esac

if [ $variant == "dwg" ] || [ $variant == "dug" ]; then
	rm -f /system/bin/rild
	rm -f /system/lib/libril.so
	NFCFILES="app/NfcNci.apk etc/permissions/android.hardware.nfc.xml etc/permissions/android.hardware.nfc.hce.xml etc/permissions/com.android.nfc_extras.xml etc/permissions/com.cyanogenmod.nfc.enhanced.xml etc/nfcee_access.xml etc/libnfc-nxp.conf etc/libnfc-brcm.conf lib/libnfc-nci.so lib/hw/nfc_nci.a5.so lib/libnfc_nci_jni.so lib/libnfc_ndef.so framework/com.android.nfc_extras.jar priv-app/Tag.apk"
	for i in $NFCFILES; do
		rm -f /system/$i
	done
fi

basedir="/system/blobs/$variant/"
cd $basedir
chmod 755 bin/*
find . -type f | while read file; do ln -s $basedir$file /system/$file ; done
