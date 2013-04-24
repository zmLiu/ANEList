package
{
	import com.lzm.anesdk.AneSDK;
	import com.lzm.anesdk.tools.Tools;
	
	import flash.display.Sprite;
	import flash.sensors.Geolocation;
	
	public class TestAne_Android extends Sprite
	{
		public function TestAne_Android()
		{
			super();
			
			AneSDK.initSDK(!Geolocation.isSupported,AneSDK.ANE_PLATFORM_ANDROID);
			trace(new Tools().getDevciteID());
		}
	}
}