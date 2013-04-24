package com.lzm.anesdk;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class AneFunction implements FREFunction {
	
	private static boolean isInit = false;//是否已经初始化
	
	protected FREContext freContext;//frecontext
	protected String funKey;//方法key
	
	public FREObject call(FREContext context, FREObject[] args) {
		if(args.length < 1) return null;//参数不能小于1个
		
		FREObject reObject = null;
		try {
			this.freContext = context;
			this.funKey = args[0].getAsString();
			reObject = execute(args);
		} catch (Exception e) {
			AneEventBroadcast.broadcast(AneEvents.EVENT_EXCPTION, e.getMessage());
			Log.e("AneFunctionError", e.getMessage());
		}
		
		return reObject;
	}
	
	/**
	 * ִ执行ane方法
	 * */
	protected FREObject execute(FREObject[] args)throws Exception{
		if(funKey.equals("init")){
			init();
		}
		return null;
	}
	
	
	private void init(){
		if(isInit) return;
		isInit = true;
		
		AneEventBroadcast.initBroadcast(freContext);//初始化ane广播器
		
		//监听屏幕亮起以及锁屏事件
		final IntentFilter filter = new IntentFilter();  
		filter.addAction(Intent.ACTION_SCREEN_OFF);  
		filter.addAction(Intent.ACTION_SCREEN_ON); 
		freContext.getActivity().registerReceiver(screen_ON_OFF_BroadcastReceiver, filter);
	}
	
	/**
	 * 锁屏监听
	 * */
	private final BroadcastReceiver screen_ON_OFF_BroadcastReceiver = new BroadcastReceiver() {  
	       @Override  
	       public void onReceive(final Context context, final Intent intent) {  
	           final String action = intent.getAction();  
	          if(Intent.ACTION_SCREEN_ON.equals(action)){  
	               AneEventBroadcast.broadcast(AneEvents.EVENT_SCREEN_ON, "AneEvents.EVENT_SCREEN_ON");
	          }else if(Intent.ACTION_SCREEN_OFF.equals(action)){  
	        	  AneEventBroadcast.broadcast(AneEvents.EVENT_SCREEN_OFF, "AneEvents.EVENT_SCREEN_ON");
	          }  
	       }  
	   };

}
