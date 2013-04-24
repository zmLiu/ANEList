package
{
	import com.lzm.anesdk.weixin.WeiXin;
	
	import flash.filesystem.File;

	public class TestWX
	{
		
		public function TestWX()
		{
			var wx:WeiXin = new WeiXin();
			wx.registerApp("wx8a4a9f30028b58af");
			
			trace(wx.isWXAppInstalled());
			
			
			
			var file:File = File.applicationDirectory;
			var imagePath:String = file.resolvePath("testshare.png").nativePath;
			trace(imagePath);
			
			wx.shareImage(imagePath);
			
		}
	}
}