package com.lzm.anesdk.yeepay;

import android.content.Intent;

import com.adobe.fre.FREObject;
import com.lzm.anesdk.AneFunction;

/**
 * 	易宝支付
 *	@author lzm
 * */
public class YeePay extends AneFunction {
	/**
	 * 	使用此ane需要配置
	 * 	<application>
             <activity android:name="com.yeepay.android.plugin.YeepayPlugin" 
				android:screenOrientation="portrait"
				android:configChanges="keyboardHidden|orientation"
				android:theme="@android:style/Theme.Translucent.NoTitleBar" />
	        
	        <activity android:name="com.lzm.anesdk.yeepay.StartYeepayActivity">
	          	<intent-filter>
	          		<action android:name="com.lzm.anesdk.yeepay.StartYeepayActivity" />
	          		<category android:name="android.intent.category.DEFAULT" />
	      		</intent-filter>
	        </activity>
         </application>
	 * */
	
	public static final String EVENT_YEEPAY = "EVENT_YEEPAY";//支付事件
	
	public static final String PAY_STATE_SUCCESS = "PAY_STATE_SUCCESS";//支付成功
	public static final String PAY_STATE_FAILURE = "PAY_STATE_FAILURE";//支付失败
	
	@Override
	protected FREObject execute(FREObject[] args) throws Exception {
		if(funKey.equals("pay")){
			return pay(args[1].getAsString(),args[2].getAsString(),args[3].getAsString(),args[4].getAsString(),args[5].getAsString(),args[6].getAsString(),args[7].getAsString(),args[8].getAsString());
		}
		return null;
	}
	
	private FREObject pay(String customerNumber,String requestId,String amount,String productName,String productDesc,String support,String environment,String key){
		
		Intent intent = new Intent(StartYeepayActivity.STARTYEEPAYACTIVITY_ACTION);
		
		intent.putExtra("customerNumber", customerNumber);
		intent.putExtra("requestId", requestId);
		intent.putExtra("amount", amount);
		intent.putExtra("productName", productName);
		intent.putExtra("productDesc", productDesc);
		intent.putExtra("support", support);
		intent.putExtra("environment", environment);
		intent.putExtra("key", key);
		
		freContext.getActivity().startActivity(intent);
		
		return null;
	}
	
}
