package
{
	import com.lzm.anesdk.AneSDK;
	import com.lzm.anesdk.weibo.WeiBo;
	
	import flash.filesystem.File;
	import flash.utils.setTimeout;

	public class TestWeiBo
	{
		private var weibo:WeiBo;
		
		public function TestWeiBo()
		{
			setTimeout(function():void{
				weibo = new WeiBo();
				AneSDK.addCodelistener(WeiBo.EVENT_SINAWEIBODIDLOGIN,onLogin);
				
				weibo.initWeiBo("464058549","d0d66f0f0ea0fb74f8394ae216aa5e83");
				weibo.login();
			},3000);
		}
		
		private function onLogin(data:String):void{
			var file:File = File.applicationDirectory;
			var imagePath:String = file.resolvePath("testshare.png").nativePath;
			trace(imagePath);
			weibo.share("测试分享",imagePath);
		}
	}
}