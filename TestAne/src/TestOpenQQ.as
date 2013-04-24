package
{
	import com.lzm.anesdk.AneSDK;
	import com.lzm.anesdk.openqq.OpenQQ;
	
	import flash.utils.setTimeout;

	public class TestOpenQQ
	{
		private var openQQ:OpenQQ = new OpenQQ();
		
		public function TestOpenQQ()
		{
			setTimeout(function():void{
				openQQ.initOpenQQ("100619194");
				
				trace(openQQ.isLogin());
				
				AneSDK.addCodelistener(OpenQQ.EVENT_DIDLOGIN_QQ,onLogin);
				AneSDK.addCodelistener(OpenQQ.EVENT_DIDNOTLOGIN_QQ,onNotLogin);
				AneSDK.addCodelistener(OpenQQ.EVENT_GETUSERINFO_QQ,onGetUserInfo);
				AneSDK.addCodelistener(OpenQQ.EVENT_SHARE_QQ,onShare);
				AneSDK.addCodelistener(OpenQQ.EVENT_TOPIC_QQ,onTopic);
				
//				openQQ.login();
			},3000);
		}
		
		private function onLogin(data:String):void{
			trace(data);
			openQQ.getUserInfo();
		}
		
		private function onNotLogin(data:String):void{
			trace(data);
		}
		
		private function onGetUserInfo(data:String):void{
			trace(data);
			openQQ.topic("测试分享图片","http://t3.baidu.com/it/u=1388153813,1308540609&fm=25&gp=0.jpg","230","230");
		}
		
		private function onShare(data:String):void{
			trace(data);
		}
		
		private function onTopic(data:String):void{
			trace(data);
		}
	}
}