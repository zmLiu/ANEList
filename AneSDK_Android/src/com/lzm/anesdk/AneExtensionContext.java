package com.lzm.anesdk;

import java.util.HashMap;
import java.util.Map;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.lzm.anesdk.tools.Tools;
import com.lzm.anesdk.xg.XG;
import com.lzm.anesdk.yeepay.YeePay;

public class AneExtensionContext extends FREContext {

	public void dispose() {
		
	}

	@Override
	public Map<String, FREFunction> getFunctions() {
		Map<String, FREFunction> funMap = new HashMap<String, FREFunction>();
		
		funMap.put("aneInits", new AneFunction());//flash调用init方法之后调用该方法初始化一些必要信息
		funMap.put("tools", new Tools());//工具类
		funMap.put("yeepay", new YeePay());//易宝支付
		funMap.put("xg", new XG());//腾讯信鸽
		
		return funMap;
	}

}
