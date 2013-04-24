package 
{
	import flash.events.EventDispatcher;

	public class BasePlatform extends EventDispatcher
	{
		public function BasePlatform()
		{
			
		}
		
		/**
		 * 显示平台
		 */		
		public function showPt():void{}
		
		/**
		 * 初始化平台
		 */		
		public function initPlatform():void{}
		
		/**
		 * 获取uid
		 */		
		public function getUid():String{
			return "99999999";
		}
		
		/**
		 * 获取token 
		 */		
		public function getToken():String{
			return "99999999token";
		}
		
		/**
		 * 获取设备id，根据网卡获得 
		 * @return 
		 * 
		 */		
		public function getUUid():String{
			return "99999999uuid";
		}
		
		/**
		 * 获取api地址
		 * @return 
		 * 
		 */		
		public function getApiUrl():String{
			return "http://192.168.1.107/";
		}
		
		/**
		 * 加载用户图片的地址
		 * 
		 */		
		public function getResUserUrl():String{
			return "http://r.nonogame.com/";
		}
		
		/**
		 * 显示通知气泡 
		 */		
		public function ShowIconBadageNumber(num:int):int{
			return 0;
		}
		
		/**
		 * 获取设备唯一id 
		 */		
		public function deviceID():String{
			return "lzm-iphone";
		}
		
		/**
		 * 设置屏幕是否常亮
		 */		
		public function setIdleTimerDisabled(value:Boolean):void{
			
		}
		
		/**
		 * 存放用户数据
		 * @param key
		 * @param jsonStr
		 * 
		 */		
		public function saveUserMessage(key:String,jsonStr:String):void{
		}
		
		/**
		 * 获取用户数据 
		 * @param key
		 * @return
		 * 
		 */		
		public function getUserMessage(key:String):String{
			return null;
		}
		
		/**
		 * 购买物品 
		 * @param productId
		 */		
		public function purchaseProduct(productId:String):void{
			
		}
		
		/**
		 * 转换购物小票 
		 * @param receipt
		 * @return 
		 * 
		 */		
		public function parseTransactionReceipt(receipt:String):String{
			return receipt;
		}
		
		/**
		 * 评分
		 * */
		public function mkScore(appid:String):void{
			
		}
		
		public function loginQQ():void{
			
		}
		
		public function getUserInfoQQ():void{
			
		}
		
		public function share(title:String,url:String,comment:String,summary:String,images:String):void{
			
		}
		
		public function topic(con:String,image:String,imageW:String,imageH:String):void{
			
		}
		
		public function shareSinaWeiBo(status:String):void{
			
		}
		
		public function isWXAppInstalled():String{
			return "false";
		}
		
		public function shareWX():void{
			
		}
		
		public function showDialog():void{
			
		}
		
		/**
		 * 释放 
		 */		
		public function dispose():void{}
	}
}