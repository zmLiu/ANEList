package com.lzm.anesdk.xg;

import android.content.Intent;
import android.util.Log;

import com.adobe.fre.FREObject;
import com.lzm.anesdk.AneFunction;
import com.tencent.android.tpush.XGIOperateCallback;
import com.tencent.android.tpush.XGPushManager;
import com.tencent.android.tpush.service.XGPushService;

public class XG extends AneFunction {
	protected FREObject execute(FREObject[] args) throws Exception {
		if(funKey.equals("registerXG")){
			return registerXG();
		}
		return null;
	}
	
	private FREObject registerXG(){
		XGPushManager.registerPush(freContext.getActivity().getApplicationContext(), new XGIOperateCallback() {
			@Override
			public void onSuccess(Object data, int flag) {
				Log.d("TPush", "注册成功，设备token为：" + data);
			}
			@Override
			public void onFail(Object data, int errCode, String msg) {
				Log.d("TPush", "注册失败，错误码：" + errCode + ",错误信息：" + msg);
			}
		});
		Intent service = new Intent(freContext.getActivity().getApplicationContext(), XGPushService.class);
		freContext.getActivity().startService(service);
		return null;
	}
}
