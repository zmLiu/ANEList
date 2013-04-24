package com.lzm.anesdk.weibo
{
	import com.lzm.anesdk.AneSDK;
	
	public class WeiBo extends AneSDK
	{
		public static const aneFunction:String = "weibo";
		
		public static const EVENT_SINAWEIBODIDLOGIN:String = "EVENT_SINAWEIBODIDLOGIN";
		
		private var _isInit:Boolean = false;
		
		public function initWeiBo(appKey:String,appSceret:String):void{
			if(isSimulator || _isInit) return;
			_isInit = true;
			extensionContext.call(aneFunction,"initWeiBo",appKey,appSceret);
		}
		
		public function login():void{
			if(isSimulator) return;
			extensionContext.call(aneFunction,"login");
		}
		
		/**
		 * 分享 
		 * @param status		微博类容
		 * @param imagePath		本地图片地址
		 */		
		public function share(status:String,imagePath:String):void{
			if(isSimulator) return;
			extensionContext.call(aneFunction,"share",status,imagePath);
		}
		
	}
}