package com.lzm.anesdk.tools
{
	import com.lzm.anesdk.AneSDK;

	public class Tools extends AneSDK
	{
		
		public static const aneFunction:String = "tools";
		
		/**
		 * 获取设备id 
		 */
		public function getDevciteID():String{
			if(isSimulator){
				return "devciteid_simulator";
			}
			return extensionContext.call(aneFunction,"getDeviceID") as String;
		}
		
		/**
		 * 设置通知数量
		 * */
		public function ShowIconBadageNumber(value:int):void{
			if(isSimulator) return;
			extensionContext.call(aneFunction,"ShowIconBadageNumber",value);
		}
		
		/**
		 * 设置屏幕常亮
		 * */
		public function setIdleTimerDisabled(value:Boolean):void{
			if(isSimulator) return;
			extensionContext.call(aneFunction,"setIdleTimerDisabled",value);
		}
		
		/**
		 * 评分
		 * */
		public function makeScore_IOS(appid:String):void{
			if(anePlatform != ANE_PLATFORM_IOS || isSimulator) return;
			extensionContext.call(aneFunction,"makeScore",appid);
		}
		
		/**
		 * 转换购物小票IOS
		 * */
		public function parseTransactionReceipt(receipt:String):String{
			if(isSimulator) return "";
			return extensionContext.call(aneFunction,"parseTransactionReceipt",receipt) as String;
		}
		
		/**
		 * 获取设备描述符 
		 * @return 
		 * 
		 */		
		public function deviceString():String{
			if(isSimulator) return "";
			return extensionContext.call(aneFunction,"deviceString") as String;
		}
		
	}
}