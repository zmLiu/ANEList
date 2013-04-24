package com.lzm.anesdk.yzplatform
{
	import com.lzm.anesdk.AneSDK;
	
	import flash.events.StatusEvent;

	public class YZPlatform extends AneSDK
	{
		public static const aneFunction:String = "yzPlatform";
		
		public static const EVENT_ON_YZPLATFROM_STARTRUN:String = "EVENT_ON_YZPLATFROM_STARTRUN";
		public static const EVENT_ON_YZPLATFROM_APPSTART:String = "EVENT_ON_YZPLATFROM_APPSTART";
		public static const EVENT_ON_YZPLATFROM_TIMEOUT:String = "EVENT_ON_YZPLATFROM_TIMEOUT";
		
		/**
		 * 初始化平台 
		 * @param appid		appid
		 * @param isDebug	是否为调试模式
		 * 
		 */		
		public function initYZPlatform(appid:String,isDebug:Boolean):void{
			if(isSimulator) {
				var statusEvent:StatusEvent = new StatusEvent(StatusEvent.STATUS,false,false,EVENT_ON_YZPLATFROM_APPSTART,JSON.stringify({"state":"someData"}));
				AneSDK.onStatus(statusEvent);
				return;
			}
			extensionContext.call(aneFunction,"initYZPlatform",appid,isDebug);
		}
		
		/**
		 * 显示平台 
		 * 
		 */		
		public function showYZPlatform():void{
			if(isSimulator) return;
			extensionContext.call(aneFunction,"showYZPlatform");
		}
		
	}
}