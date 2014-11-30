package com.lzm.anesdk.xg
{
	import com.lzm.anesdk.AneSDK;

	public class XG extends AneSDK
	{
		public static const aneFunction:String = "xg";
		private var _isInit:Boolean = false;
		
		/**
		 * 注册信鸽
		 */		
		public function registerXG():void{
			if(isSimulator || _isInit) return;
			_isInit = true;
			extensionContext.call(aneFunction,"registerXG");
			trace("register XG");
		}
	}
}