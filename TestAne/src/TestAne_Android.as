package
{
	import com.lzm.anesdk.AneSDK;
	
	import flash.display.Sprite;
	import flash.sensors.Geolocation;
	
	public class TestAne_Android extends Sprite
	{
		public function TestAne_Android()
		{
			super();
			
			AneSDK.initSDK(!Geolocation.isSupported,AneSDK.ANE_PLATFORM_ANDROID);
			
			new TestXG();
			
		}
	}
}