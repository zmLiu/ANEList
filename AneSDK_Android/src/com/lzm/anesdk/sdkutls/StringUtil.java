package com.lzm.anesdk.sdkutls;

public class StringUtil {
	
	/**
	 * 根据字符串返回一个肯定不为空的字符串
	 * */
	public static String getNotNullString(String str){
		return (str == null) ? "" : str;
	}
	
}
