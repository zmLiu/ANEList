package com.lzm.anesdk;

import com.adobe.fre.FREContext;


/**
 * Ane事件广播
 * @author lzm
 * */
public class AneEventBroadcast {
	
	private static FREContext freContext;
	
	public static void initBroadcast(FREContext freContext){
		AneEventBroadcast.freContext = freContext;
	}
	
	/**
	 * 广播	事件到flash
	 * @param	code
	 * @param 	level
	 * */
	public static void broadcast(String code,String level){
		freContext.dispatchStatusEventAsync(code, level);
	}

}
