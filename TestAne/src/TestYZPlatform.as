package
{
	import com.lzm.anesdk.AneSDK;
	import com.lzm.anesdk.yzplatform.YZPlatform;

	public class TestYZPlatform
	{
		
		private var platform:YZPlatform;
		
		public function TestYZPlatform()
		{
			AneSDK.addCodelistener(YZPlatform.EVENT_ON_YZPLATFROM_STARTRUN,onPlatformStartRun);
			AneSDK.addCodelistener(YZPlatform.EVENT_ON_YZPLATFROM_APPSTART,onAppStart);
			AneSDK.addCodelistener(YZPlatform.EVENT_ON_YZPLATFROM_TIMEOUT,onPlatTimeout);
			
			platform = new YZPlatform();
			platform.initYZPlatform("com.FutureBright.app1",true);
		}
		
		private function onPlatformStartRun(data:String):void{
			trace("onPlatformStartRun",data);
			platform.showYZPlatform();
		}
		
		private function onAppStart(data:String):void{
			trace("onAppStart",data);
		}
		
		private function onPlatTimeout(data:String):void{
			trace("onPlatTimeout",data);
		}
		
	}
}