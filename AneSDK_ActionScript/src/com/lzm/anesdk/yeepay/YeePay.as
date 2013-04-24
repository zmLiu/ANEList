package com.lzm.anesdk.yeepay
{
	import com.lzm.anesdk.AneSDK;
	
	import flash.events.StatusEvent;
	
	public class YeePay extends AneSDK
	{
		
		public static const EVENT_YEEPAY:String = "EVENT_YEEPAY";//支付事件
		
		public static const PAY_STATE_SUCCESS:String = "PAY_STATE_SUCCESS";//支付成功
		public static const PAY_STATE_FAILURE:String = "PAY_STATE_FAILURE";//支付失败
		
		public static const SUPPORT_CH_BANK:String = "CH_BANK";//支持银行卡支付
		public static const SUPPORT_CH_MOBILE:String = "CH_MOBILE";//支持电信卡支付
		public static const SUPPORT_CH_GAME:String = "CH_GAME";//支持游戏卡支付
		public static const SUPPORT_ALL:String = "";//全部
		
		public static const ENVIRONMENT_TEST:String = "ENV_TEST";//测试环境
		public static const ENVIRONMENT_LIVE:String = "ENV_LIVE";//正式环境
		
		/**
		 * 开始支付
		 * @param 	customerNumber	商品编号
		 * @param 	requestId		商户自定义订单号 (丌能重复，可以使用时间戳迚行组合定义)
		 * @param	amount			商品所要支付金额 (格式为：元.角分，最小金额为分， 例如：20.00，此金额将会在支付时显示给用户确认。)
		 * @param	productName		商品名称 (此名称将会在支付时显示给用户确认。)
		 * @param	productDesc		商户对商品的自定义描述(选)
		 * @param	support			商户支持的支付渠道 参数： CH_BANK:支持银行卡支付 CH_GAME:支持游戏卡支付 CH_MOBILE:支持电信卡支付 其他情况为全支持(选)
		 * @param	environment		目前使用的服务器连接环境。 需要传入标识： ENV_TEST：测试环境 ENV_LIVE：正式环境 默认为正式支付环境(选)
		 * @param	key				支付key
		 * */
		public function pay(customerNumber:String,requestId:String,amount:String,productName:String,productDesc:String,support:String,environment:String,key:String):void{
			if(isSimulator){
				var statusEvent:StatusEvent = new StatusEvent(StatusEvent.STATUS,false,false,EVENT_YEEPAY,JSON.stringify({"state":PAY_STATE_FAILURE}));
				AneSDK.onStatus(statusEvent);
			}else{
				extensionContext.call("yeepay","pay",customerNumber,requestId,amount,productName,productDesc,support,environment,key);
			}
		}
		
	}
}