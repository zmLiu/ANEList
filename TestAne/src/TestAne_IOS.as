package
{
	import com.lzm.anesdk.AneSDK;
	
	import flash.display.Sprite;
	import flash.sensors.Geolocation;

	public class TestAne_IOS extends Sprite
	{
		public function TestAne_IOS()
		{
			AneSDK.initSDK(!Geolocation.isSupported,AneSDK.ANE_PLATFORM_IOS);
			new TestOpenQQ();
		}
	}
}