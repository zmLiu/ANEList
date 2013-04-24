package com.lzm.anesdk
{
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import flash.utils.Dictionary;

	public class AneSDK extends EventDispatcher
	{
		public static const ANE_PLATFORM_ANDROID:String = "ANDROID";
		public static const ANE_PLATFORM_IOS:String = "IOS";
		
		private static const ANDROID_ID:String = "com.lzm.anesdk.android";
		private static const IOS_ID:String = "com.lzm.anesdk.ios";
		
		private static var statusCallBack:Dictionary;//回调事件集合
		
		public static var extensionContext:ExtensionContext;
		public static var isSimulator:Boolean;
		protected static var anePlatform:String;//当前运行的平台
		
		/**
		 * 初始化ane接口 
		 * @param isSimulator	是否在模拟器中运行
		 * @param anePlatform	目标平台
		 */
		public static function initSDK(isSimulator:Boolean,anePlatform:String):void{
			AneSDK.isSimulator = isSimulator;
			AneSDK.anePlatform = anePlatform;
			
			statusCallBack = new Dictionary();
			
			if(!AneSDK.isSimulator){
				if(anePlatform == ANE_PLATFORM_ANDROID){
					extensionContext = ExtensionContext.createExtensionContext(ANDROID_ID,null);
				}else if(anePlatform == ANE_PLATFORM_IOS){
					extensionContext = ExtensionContext.createExtensionContext(IOS_ID,null);
				}
				extensionContext.call("aneInits","init");
				extensionContext.addEventListener(StatusEvent.STATUS,onStatus);
			}
		}
		
		/**
		 * 监听原生代码传回来的事件 
		 * @param e
		 * 
		 */		
		public static function onStatus(e:StatusEvent):void{
			var code:String = e.code;
			var level:String = e.level;
			
			var funcs:Vector.<Function> = statusCallBack[code];
			if(funcs == null) return;
			
			var count:int = funcs.length;
			for (var i:int = 0; i < count; i++) {
				funcs[i](level);
			}
		}
		
		/**
		 * 添加原生代码事件回调 
		 * @param code
		 * @param callBack
		 * 
		 */		
		public static function addCodelistener(code:String,callBack:Function):void{
			var funcs:Vector.<Function> = statusCallBack[code];
			if(funcs == null) funcs = new Vector.<Function>();
			
			funcs.push(callBack);
			statusCallBack[code] = funcs;
		}
		
		/**
		 * 移出原生代码事件回调 
		 * @param code
		 * @param callBack
		 * 
		 */		
		public static function removeCodeListener(code:String,callBack:Function):void{
			var funcs:Vector.<Function> = statusCallBack[code];
			if(funcs == null) return;
			
			var count:int = funcs.length;
			for (var i:int = 0; i < count; i++) {
				if(funcs[i] == callBack){
					funcs.splice(i,1);
					break;
				}
			}
			
		}
	}
}