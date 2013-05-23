cp -rf AneSDK_ActionScript.swc AneSDK.tar

tar xvf AneSDK.tar

cp library.swf Android-ARM/library.swf

cp library.swf iPhone-ARM/library.swf

cp library.swf Default/library.swf

/Applications/Adobe\ Flash\ Builder\ 4.7/sdks/4.6.0/bin/adt -package -target ane AneSDK_Android.ane extension_android.xml -swc AneSDK_ActionScript.swc -platform Android-ARM -C Android-ARM . -platform default -C Default .

/Applications/Adobe\ Flash\ Builder\ 4.7/sdks/4.6.0/bin/adt -package -target ane AneSDK_IOS.ane extension_ios.xml -swc AneSDK_ActionScript.swc -platform iPhone-ARM -C iPhone-ARM . -platformoptions platform.xml -platform default -C default .

rm -rf AneSDK.tar
rm -rf catalog.xml
rm -rf library.swf