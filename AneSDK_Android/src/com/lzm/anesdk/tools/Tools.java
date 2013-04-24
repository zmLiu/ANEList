package com.lzm.anesdk.tools;

import android.content.Context;
import android.telephony.TelephonyManager;

import com.adobe.fre.FREObject;
import com.lzm.anesdk.AneFunction;

/**
 * 	工具集合
 * 	@author	lzm
 * */
public class Tools extends AneFunction {
	
	protected FREObject execute(FREObject[] args) throws Exception {
		if(funKey.equals("getDeviceID")){
			return getDevciteID();
		}
		return null;
	}
	
	/**
	 * 获取设备id
	 * */
	private FREObject getDevciteID()throws Exception{
		TelephonyManager telephoneManager = (TelephonyManager) freContext.getActivity().getSystemService(Context.TELEPHONY_SERVICE);
		String deviceID = telephoneManager.getDeviceId();
		return FREObject.newObject(deviceID);
	}
	
}
