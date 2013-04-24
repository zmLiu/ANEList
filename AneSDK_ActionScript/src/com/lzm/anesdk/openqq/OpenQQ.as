package com.lzm.anesdk.openqq
{
	import com.lzm.anesdk.AneSDK;
	
	public class OpenQQ extends AneSDK
	{
		public static const aneFunction:String = "openqq";
		
		public static const EVENT_DIDLOGIN_QQ:String = "EVENT_DIDLOGIN_QQ";//登陆成功
		public static const EVENT_DIDNOTLOGIN_QQ:String = "EVENT_DIDNOTLOGIN_QQ";//登陆失败
		public static const EVENT_DIDNOTNETWORK_QQ:String = "EVENT_DIDNOTNETWORK_QQ";//没有网路
		public static const EVENT_GETUSERINFO_QQ:String = "EVENT_GETUSERINFO_QQ";//获取用户信息回调
		public static const EVENT_SHARE_QQ:String = "EVENT_SHARE_QQ";//分享回调
		public static const EVENT_TOPIC_QQ:String = "EVENT_TOPIC_QQ";//说说回调
		
		private var _isInit:Boolean = false;
		
		/**
		 * 初始化 
		 * @param appid
		 * 
		 */		
		public function initOpenQQ(appid:String):void{
			if(isSimulator || _isInit) return;
			_isInit = true;
			extensionContext.call(aneFunction,"initOpenQQ",appid);
		}
		
		/**
		 * 登陆 
		 * 
		 */		
		public function login():void{
			if(isSimulator) return;
			extensionContext.call(aneFunction,"login");
		}
		
		/**
		 * 获取用户信息 
		 * 
		 */		
		public function getUserInfo():void{
			if(isSimulator) return;
			extensionContext.call(aneFunction,"getUserInfo");
		}
		
		/**
		 * 分享 
		 * @param title
		 * @param url
		 * @param comment
		 * @param summary
		 * @param images
		 * 
		 */		
		public function share(title:String,url:String,comment:String,summary:String,images:String):void{
			if(isSimulator) return;
			extensionContext.call(aneFunction,"share",title,url,comment,summary,images);
		}
		
		/**
		 * 发表说说 
		 * @param con
		 * @param image
		 * @param imageW
		 * @param imageH
		 * 
		 */
		public function topic(con:String,image:String,imageW:String,imageH:String):void{
			if(isSimulator) return;
			extensionContext.call(aneFunction,"topic",con,image,imageW,imageH);
		}
		
		/**
		 *  
		 * @return	是否已经登陆 
		 * 
		 */		
		public function isLogin():Boolean{
			if(isSimulator) return false;
			return extensionContext.call(aneFunction,"isLogin");
		}
		
	}
}