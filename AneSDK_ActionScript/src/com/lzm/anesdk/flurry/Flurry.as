package com.lzm.anesdk.flurry
{
	import com.lzm.anesdk.AneSDK;
	
	public class Flurry extends AneSDK
	{
		
		public static const aneFunction:String = "flurry";
		
		/**
		 * 开始会话 
		 * @param apiKey
		 * 
		 */		
		public function startSession(apiKey:String):void{
			if(isSimulator || anePlatform != ANE_PLATFORM_IOS) return;
			extensionContext.call(aneFunction,"startSession",apiKey);
		}
		
		/**
		 * 记录发生的事件 
		 * @param event
		 * 
		 */
		public function logEvent(event:String):void{
			if(isSimulator || anePlatform != ANE_PLATFORM_IOS) return;
			extensionContext.call(aneFunction,"logEvent",event);
		}
	}
}