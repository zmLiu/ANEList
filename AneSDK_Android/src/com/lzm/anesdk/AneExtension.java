package com.lzm.anesdk;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class AneExtension implements FREExtension {

	@Override
	public FREContext createContext(String arg0) {
		AneExtensionContext extensionContext = new AneExtensionContext();
		return extensionContext;
	}

	@Override
	public void dispose() {
		// TODO Auto-generated method stub

	}

	@Override
	public void initialize() {
		// TODO Auto-generated method stub

	}

}
