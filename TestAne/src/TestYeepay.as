package
{
	import com.lzm.anesdk.AneSDK;
	import com.lzm.anesdk.yeepay.YeePay;

	public class TestYeepay
	{
		
		private var _yeepay:YeePay;
		private var CUSTOMER_NUMBER:String = "10040011767";
		private var KEY:String = "f767xqL03W000s2P714768191iU4UFvJ2p5lj5S93hj2348d2oL86LJAZYw3";
		
		public function TestYeepay()
		{
			AneSDK.addCodelistener(YeePay.EVENT_YEEPAY,payCallBack);
			
			_yeepay = new YeePay();
			
			var customerNumber:String = CUSTOMER_NUMBER;
			var requestId:String = "" + int(Math.random()*10000);
			var amount:String = "" + 0.01;
			var productName:String = "驴肉火烧";
			var productDesc:String = "驴肉火烧，很便宜";
			var support:String = YeePay.SUPPORT_ALL;
			var environment:String = YeePay.ENVIRONMENT_TEST;
			var key:String = KEY;
			
			_yeepay.pay(customerNumber,requestId,amount,productName,productDesc,support,environment,key);
			
		}
		
		private function payCallBack(data:String):void{
			trace(data);
		}
	}
}