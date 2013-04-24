package com.lzm.anesdk.weixin
{
	import com.lzm.anesdk.AneSDK;

	public class WeiXin extends AneSDK
	{
		public static const aneFunction:String = "weixin";
		
		private var _isInit:Boolean = false;
		
		/**
		 * @return 是否安装了微信 
		 */		
		public function isWXAppInstalled():Boolean{
			if(isSimulator) return false;
			return extensionContext.call(aneFunction,"isWXAppInstalled") as Boolean;
		}
		
		
		/**
		 * 注册微信 
		 * @param appid
		 */		
		public function registerApp(appid:String):void{
			if(isSimulator || _isInit) return;
			_isInit = true;
			extensionContext.call(aneFunction,"registerApp",appid);
		}
		
		/**
		 * 分享本地图片 
		 * @param imagePath
		 */		
		public function shareImage(imagePath:String):void{
			if(isSimulator) return;
			extensionContext.call(aneFunction,"shareImage",imagePath);
		}
		
	}
}