package com.lzm.anesdk.yeepay;

import org.json.JSONObject;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;

import com.lzm.anesdk.AneEventBroadcast;
import com.lzm.anesdk.sdkutls.StringUtil;
import com.yeepay.android.plugin.YeepayPlugin;

/**
 *  yeepay支付Activity
 *  @author lzm
 * */
public class StartYeepayActivity extends Activity {
	
	public static final String STARTYEEPAYACTIVITY_ACTION = "com.lzm.anesdk.yeepay.StartYeepayActivity";
	
	private String payKey;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		savedInstanceState = getIntent().getExtras();
		
		String customerNumber = savedInstanceState.getString("customerNumber");
		String requestId = savedInstanceState.getString("requestId");
		String amount = savedInstanceState.getString("amount");
		String productName = savedInstanceState.getString("productName");
		String productDesc = savedInstanceState.getString("productDesc");
		String support = savedInstanceState.getString("support");
		String environment = savedInstanceState.getString("environment");
		String key = savedInstanceState.getString("key");
		
		startPay(customerNumber, requestId, amount, productName, productDesc, support, environment, key);
	}
	
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
	private void startPay(String customerNumber,String requestId,String amount,String productName,String productDesc,String support,String environment,String key) {
		payKey = key;
		
		Intent intent = new Intent(getBaseContext(), YeepayPlugin.class);
		intent.putExtra("customerNumber", customerNumber);
		
		String time = "" + System.currentTimeMillis();
		
		intent.putExtra("requestId", requestId);
		intent.putExtra("amount",  amount);
		intent.putExtra("productName", productName);
		intent.putExtra("time", time);
		intent.putExtra("productDesc", (productDesc == null) ? "" : productDesc);
		intent.putExtra("support", (support == null) ? "" : support);
		intent.putExtra("environment", (environment == null) ? "ENV_LIVE" : "ENV_TEST" );
		
		StringBuilder builder = new StringBuilder();
		builder.append(customerNumber).append("$");
		builder.append(requestId).append("$");
		builder.append(amount).append("$");
		builder.append(productName).append("$");
		builder.append(time);
		
		String hmac = YeepayUtils.hmacSign(builder.toString(), key);
		
		intent.putExtra("hmac", hmac);
		
		startActivityForResult(intent, 200);
	}
	
	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		
		JSONObject json = new JSONObject();
		try {
			if(data == null){
				json.put("state", YeePay.PAY_STATE_FAILURE);//支付失败
			}else{
				
				Bundle params = data.getExtras();
				
				String requestId = StringUtil.getNotNullString(params.getString("requestId"));
				String amount = StringUtil.getNotNullString(params.getString("amount"));
				String returnCode = StringUtil.getNotNullString(params.getString("returnCode"));
				String customerNumber = StringUtil.getNotNullString(params.getString("customerNumber"));
				String appId = StringUtil.getNotNullString(params.getString("appId"));
				String errorMessage = StringUtil.getNotNullString(params.getString("errorMessage"));
				String time = StringUtil.getNotNullString(params.getString("time"));
				String hmac = StringUtil.getNotNullString(params.getString("hmac"));
				
				if(TextUtils.isEmpty(requestId) && TextUtils.isEmpty(amount)){
					json.put("state", YeePay.PAY_STATE_FAILURE);//支付失败
				}else{
				    StringBuilder builder = new StringBuilder(); 
			    		builder.append(returnCode).append("$") 
			    		.append(customerNumber).append("$") 
			    		.append(requestId).append("$") 
			    		.append(amount).append("$")
			    		.append(appId).append("$") 
			    		.append(errorMessage).append("$") 
			    		.append(time);
			    		
			    	String genHmac = YeepayUtils.hmacSign(builder.toString(), payKey);
			    	if(genHmac.equals(hmac)){
			    		json.put("state", YeePay.PAY_STATE_SUCCESS);//支付成功
			    		json.put("requestId", requestId);
			    		json.put("amount", amount);
			    		json.put("returnCode",returnCode);
			    		json.put("customerNumber", customerNumber);
			    		json.put("appId", appId);
			    		json.put("errorMessage", errorMessage);
			    		json.put("time", time);
			    	}else{
			    		json.put("state", YeePay.PAY_STATE_FAILURE);//支付失败
			    		json.put("returnCode", returnCode);
			    		json.put("errorMessage", errorMessage);
			    	}
				}
				
			}
		} catch (Exception e) {
			Log.e("err", e.getMessage());
		}
		AneEventBroadcast.broadcast(YeePay.EVENT_YEEPAY, json.toString());
		finish();
	}
	
}
