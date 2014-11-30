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
	
	/**
	 * 
	 * 
	 * <android>
        <manifestAdditions><![CDATA[
			<manifest android:installLocation="auto">
				 <application>
	                 <activity android:name="com.yeepay.android.plugin.YeepayPlugin" 
						android:screenOrientation="portrait"
						android:configChanges="keyboardHidden|orientation"
						android:theme="@android:style/Theme.Translucent.NoTitleBar" />
			        
			        <activity android:name="com.lzm.anesdk.yeepay.StartYeepayActivity">
			          	<intent-filter>
			          		<action android:name="com.lzm.anesdk.yeepay.StartYeepayActivity" />
			          		<category android:name="android.intent.category.DEFAULT" />
			      		</intent-filter>
			        </activity>
                 </application>
			
			
			    <!--See the Adobe AIR documentation for more information about setting Google Android permissions-->
			    <!--删除 android.permission.INTERNET 权限将导致无法调试设备上的应用程序-->
			    <uses-permission android:name="android.permission.INTERNET"/>
			    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
			    <uses-permission android:name="android.permission.READ_PHONE_STATE"/>
			    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
			    <!--应同时切换 DISABLE_KEYGUARD 和 WAKE_LOCK 权限，才能访问 AIR
					的 SystemIdleMode API-->
			    <uses-permission android:name="android.permission.DISABLE_KEYGUARD"/>
			    <uses-permission android:name="android.permission.WAKE_LOCK"/>
			    <uses-permission android:name="android.permission.CAMERA"/>
			    <uses-permission android:name="android.permission.RECORD_AUDIO"/>
			    <!--应同时切换 ACCESS_NETWORK_STATE 和 ACCESS_WIFI_STATE 权限，才能使用 AIR
					的 NetworkInfo API-->
			    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
			    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
			    
			    <uses-permission android:name="android.permission.INSTALL_PACKAGES" />
			    
			</manifest>
			
		]]></manifestAdditions>
    </android>
	 * 
	 * */
}