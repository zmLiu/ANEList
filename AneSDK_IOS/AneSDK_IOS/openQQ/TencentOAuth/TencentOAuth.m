//
//  TencentOAuth.m
//  TencentOAuthDemo
//
//  Created by cloudxu on 11-8-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TencentOAuth.h"


static NSString* kGraphBaseURL = @"https://graph.qq.com/oauth2.0/";
static NSString* kRedirectURL = @"www.qq.com";
static NSString* kRestserverBaseURL = @"https://graph.qq.com/";


static NSString* kLogin = @"authorize";
static NSString* kMe = @"me";



//float version = [[[UIDevice currentDevice] systemVersion] floatValue]; 
//NSString *s = [[UIDevice currentDevice] name]; 
//NSLog(@"%@\n%@",[NSString stringWithFormat:@"%f",version],s);

///////////////////////////////////////////////////////////////////////////////////////////////////

@interface TencentOAuth ()

// private properties
@property(nonatomic, retain) NSArray* permissions;

@end

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation TencentOAuth

@synthesize accessToken = _accessToken,
expirationDate = _expirationDate,
sessionDelegate = _sessionDelegate,
permissions = _permissions,
localAppId = _localAppId,
openId = _openId,
redirectURI = _redirectURI;

///////////////////////////////////////////////////////////////////////////////////////////////////
// private


- (id)initWithAppId:(NSString *)appId
				andDelegate:(id<TencentSessionDelegate>)delegate
{
	if ([super init]) 
	{
		[_appId release];
		_appId = [appId copy];
		self.sessionDelegate = delegate;
				
		_redirectURI = [[NSString alloc] initWithString:kRedirectURL];
		_apiRequests = [[NSMutableDictionary alloc] init];
	}
	return self;
}

/**
 * Override NSObject : free the space
 */
- (void)dealloc {
	[_accessToken release];
	[_expirationDate release];
	[_request release];
	[_loginDialog release];
	[_appId release];
	[_permissions release];
	[_localAppId release];
	[_openId release];
	[_redirectURI release];
	[_apiRequests removeAllObjects];
	[_apiRequests release];
	[super dealloc];
}

/**
 * A private helper function for sending HTTP requests.
 *
 * @param url
 *            url to send http request
 * @param params
 *            parameters to append to the url
 * @param httpMethod
 *            http method @"GET" or @"POST"
 * @param delegate
 *            Callback interface for notifying the calling application when
 *            the request has received response
 */
- (TencentRequest*)openUrl:(NSString *)url
               params:(NSMutableDictionary *)params
           httpMethod:(NSString *)httpMethod
             delegate:(id<TencentRequestDelegate>)delegate {
	
	[params setValue:@"json" forKey:@"format"];
	[params setValue:_appId forKey:@"oauth_consumer_key"];
	if ([self isSessionValid]) {
		[params setValue:self.accessToken forKey:@"access_token"];
	}
	if ([self isOpenIdValid]) {
		[params setValue:self.openId forKey:@"openid"];
	}
		
	
	[_request release];
	_request = [[TencentRequest getRequestWithParams:params
									 httpMethod:httpMethod
									   delegate:delegate
									 requestURL:url] retain];
	[_request connect];
	return _request;
}

- (NSString *)getOwnBaseUrl {
	return [NSString stringWithFormat:@"tencent%@://%@", _appId, _redirectURI];
}


/**
 * A private function for opening the authorization dialog.
 */
- (void)authorizeWithTencentAppAuthInSafari:(BOOL) bInSafari{
	NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
																	 @"token", @"response_type",
																	 _appId, @"client_id",
																	 @"user_agent", @"type",
																	 _redirectURI, @"redirect_uri",
																	 @"mobile", @"display",
								   [NSString stringWithFormat:@"%f",[[[UIDevice currentDevice] systemVersion] floatValue]],@"status_os",
								   [[UIDevice currentDevice] name],@"status_machine",
																	@"v2.0",@"status_version",
								   
																	 nil];
	
	NSString *loginDialogURL = [kGraphBaseURL stringByAppendingString:kLogin];
	
	if (_permissions != nil) {
		NSString* scope = [_permissions componentsJoinedByString:@","];
		[params setValue:scope forKey:@"scope"];
	}
	
	// 先尝试从safari打开网页
	BOOL didOpenOtherApp = NO;
	if (bInSafari)
	{
		UIDevice *device = [UIDevice currentDevice];
		if ([device respondsToSelector:@selector(isMultitaskingSupported)] && [device isMultitaskingSupported]) {
			
			if (!didOpenOtherApp) {
				NSString *nextUrl = [self getOwnBaseUrl];
				[params setValue:nextUrl forKey:@"redirect_uri"];
				
				NSString *appUrl = [TencentRequest serializeURL:loginDialogURL params:params];
				didOpenOtherApp = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appUrl]];
			}
		}
	}
	
	// 再尝试在app内部创建webview的形式
	if (!didOpenOtherApp)
	{
		[_loginDialog release];
		_loginDialog = [[TencentLoginView alloc] initWithURL:loginDialogURL
													  params:params
													delegate:self];
		[_loginDialog show];
		
	
	}
	
}

/**
 * A function for parsing URL parameters.
 */
- (NSDictionary*)parseURLParams:(NSString *)query {
	NSArray *pairs = [query componentsSeparatedByString:@"&"];
	NSMutableDictionary *params = [[[NSMutableDictionary alloc] init] autorelease];
	for (NSString *pair in pairs) {
		NSArray *kv = [pair componentsSeparatedByString:@"="];
		NSString *val = [[kv objectAtIndex:1]
		stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		
		[params setObject:val forKey:[kv objectAtIndex:0]];
	}
	return params;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
//public

- (void)authorize:(NSArray *)permissions inSafari:(BOOL)bInSafari {
	[self authorize:permissions
		 localAppId:nil
		   inSafari:bInSafari];
}


- (void)authorize:(NSArray *)permissions
	localAppId:(NSString *)localAppId
		 inSafari:(BOOL)bInSafari{
	self.localAppId = localAppId;
	self.permissions = permissions;
	
	[self authorizeWithTencentAppAuthInSafari:bInSafari];
}


- (void)logout:(id<TencentSessionDelegate>)delegate {

}


- (TencentRequest*)requestWithParams:(NSMutableDictionary *)params
                    andDelegate:(id <TencentRequestDelegate>)delegate {
	if ([params objectForKey:@"method"] == nil) {
			NSLog(@"API Method must be specified");
			return nil;
	}
	
	NSString * methodName = [params objectForKey:@"method"];
	[params removeObjectForKey:@"method"];
	
	return [self requestWithMethodName:methodName
							andParams:params
						andHttpMethod:@"GET"
						  andDelegate:delegate];
}


- (TencentRequest*)requestWithMethodName:(NSString *)methodName
						  andParams:(NSMutableDictionary *)params
					  andHttpMethod:(NSString *)httpMethod
						andDelegate:(id <TencentRequestDelegate>)delegate {
	NSString * fullURL = [kRestserverBaseURL stringByAppendingString:methodName];
	return [self openUrl:fullURL
				params:params
			  httpMethod:httpMethod
				delegate:delegate];
}


- (TencentRequest*)requestWithGraphPath:(NSString *)graphPath
					   andDelegate:(id <TencentRequestDelegate>)delegate {
	
	return [self requestWithGraphPath:graphPath
							andParams:[NSMutableDictionary dictionary]
						andHttpMethod:@"GET"
						andDelegate:delegate];
}


- (TencentRequest*)requestWithGraphPath:(NSString *)graphPath
						 andParams:(NSMutableDictionary *)params
					   andDelegate:(id <TencentRequestDelegate>)delegate {
	
	return [self requestWithGraphPath:graphPath
							andParams:params
						andHttpMethod:@"GET"
						andDelegate:delegate];
}


- (TencentRequest*)requestWithGraphPath:(NSString *)graphPath
						 andParams:(NSMutableDictionary *)params
					 andHttpMethod:(NSString *)httpMethod
					   andDelegate:(id <TencentRequestDelegate>)delegate {
	
	NSString * fullURL = [kGraphBaseURL stringByAppendingString:graphPath];
	return [self openUrl:fullURL
								 params:params
								 httpMethod:httpMethod
								 delegate:delegate];
}



/**
 * @return boolean - whether this object has an non-expired session token
 */
- (BOOL)isSessionValid {
	return (self.accessToken != nil && self.expirationDate != nil
						&& NSOrderedDescending == [self.expirationDate compare:[NSDate date]]);
	
}

- (BOOL)isOpenIdValid {
	return (self.openId != nil);
}

- (BOOL)handleOpenURL:(NSURL *)url {
	// If the URL's structure doesn't match the structure used for Tencent authorization, abort.
	if (![[url absoluteString] hasPrefix:[self getOwnBaseUrl]]) {
		return NO;
	}
	
	NSString *query = [url fragment];
	
	// Version 3.2.3 encodes the parameters in the query but
	// version 3.3 and above encode the parameters in the fragment. To support
	// both versions, we try to parse the query if
	// the fragment is missing.
	if (!query) {
		query = [url query];
	}
	
	NSDictionary *params = [self parseURLParams:query];
	NSString *accessToken = [params valueForKey:@"access_token"];
	
	// If the URL doesn't contain the access token, an error has occurred.
	if (!accessToken) {
		NSString *errorReason = [params valueForKey:@"error"];
		
		// If the error response indicates that we should try again using Safari, open
		// the authorization dialog in Safari.
		if (errorReason && [errorReason isEqualToString:@"service_disabled_use_browser"]) {
			[self authorizeWithTencentAppAuthInSafari:YES];
			return YES;
		}
		
		// If the error response indicates that we should try the authorization flow
		// in an inline dialog, do that.
		if (errorReason && [errorReason isEqualToString:@"service_disabled"]) {
			[self authorizeWithTencentAppAuthInSafari:NO];
			return YES;
		}
		
		NSString *errorCode = [params valueForKey:@"error_code"];
		
		BOOL userDidCancel =
		!errorCode && (!errorReason || [errorReason isEqualToString:@"access_denied"]);
		[self tencentDialogNotLogin:userDidCancel];
		return YES;
	}
	
	// We have an access token, so parse the expiration date.
	NSString *expTime = [params valueForKey:@"expires_in"];
	NSDate *expirationDate = [NSDate distantFuture];
	if (expTime != nil) {
		int expVal = [expTime intValue];
		if (expVal != 0) {
			expirationDate = [NSDate dateWithTimeIntervalSinceNow:expVal];
		}
	}

	[self tencentDialogLogin:accessToken expirationDate:expirationDate];
	return YES;
}


/**
 * Get user info.
 */
- (BOOL)getUserInfo
{
	if (![self isSessionValid] || ![self isOpenIdValid]) {
		return NO;
	}
	NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
	APIBase *apiRequest = [[APIBase alloc] initWithTarget:self andSelector:@selector(getUserInfoResponse:) andHttpMethod:@"GET"];
	NSString * fullURL = [kRestserverBaseURL stringByAppendingString:@"user/get_user_info"];
	[apiRequest openUrl:fullURL token:_accessToken openid:_openId appid:_appId params:params];
	[_apiRequests setObject:apiRequest forKey:[NSString stringWithFormat:@"%d", apiRequest.seq]];
	return YES;
}

/**
 * Get List Album.
 */
- (BOOL)getListAlbum
{
	if (![self isSessionValid] || ![self isOpenIdValid]) {
		return NO;
	}
	NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
	APIBase *apiRequest = [[APIBase alloc] initWithTarget:self andSelector:@selector(getListAlbumResponse:) andHttpMethod:@"GET"];
	NSString * fullURL = [kRestserverBaseURL stringByAppendingString:@"photo/list_album"];
	[apiRequest openUrl:fullURL token:_accessToken openid:_openId appid:_appId params:params];
	[_apiRequests setObject:apiRequest forKey:[NSString stringWithFormat:@"%d", apiRequest.seq]];
	return YES;
}

/**
 * Get List Photo.
 */
- (BOOL)getListPhotoWithParams:(NSMutableDictionary *)params
{
	if (![self isSessionValid] || ![self isOpenIdValid]) {
		return NO;
	}
	//NSMutableDictionary * params1 = [[NSMutableDictionary alloc] init];
	APIBase *apiRequest = [[APIBase alloc] initWithTarget:self andSelector:@selector(getListPhotoResponse:) andHttpMethod:@"GET"];
	NSString * fullURL = [kRestserverBaseURL stringByAppendingString:@"photo/list_photo"];
	[apiRequest openUrl:fullURL token:_accessToken openid:_openId appid:_appId params:params];
	[_apiRequests setObject:apiRequest forKey:[NSString stringWithFormat:@"%d", apiRequest.seq]];
	return YES;
}

/**
 * Add share.
 */
- (BOOL)addShareWithParams:(NSMutableDictionary *)params
{
	if (![self isSessionValid] || ![self isOpenIdValid]) {
		return NO;
	}
	
	APIBase *apiRequest = [[APIBase alloc] initWithTarget:self andSelector:@selector(addShareResponse:) andHttpMethod:@"POST"];
	NSString * fullURL = [kRestserverBaseURL stringByAppendingString:@"share/add_share"];
	[apiRequest openUrl:fullURL token:_accessToken openid:_openId appid:_appId params:params];
	[_apiRequests setObject:apiRequest forKey:[NSString stringWithFormat:@"%d", apiRequest.seq]];
	return YES;
}

/**
 * Upload picture.
 */
- (BOOL)uploadPicWithParams:(NSMutableDictionary *)params
{
	if (![self isSessionValid] || ![self isOpenIdValid]) {
		return NO;
	}
	
	APIBase *apiRequest = [[APIBase alloc] initWithTarget:self andSelector:@selector(uploadPicResponse:) andHttpMethod:@"POST"];
	NSString * fullURL = [kRestserverBaseURL stringByAppendingString:@"photo/upload_pic"];
	[apiRequest openUrl:fullURL token:_accessToken openid:_openId appid:_appId params:params];
	[_apiRequests setObject:apiRequest forKey:[NSString stringWithFormat:@"%d", apiRequest.seq]];
	return YES;
}

/**
 * Add Album.
 */
- (BOOL)addAlbumWithParams:(NSMutableDictionary *)params
{
	if (![self isSessionValid] || ![self isOpenIdValid]) {
		return NO;
	}
	
	APIBase *apiRequest = [[APIBase alloc] initWithTarget:self andSelector:@selector(addAlbumResponse:) andHttpMethod:@"POST"];
	NSString * fullURL = [kRestserverBaseURL stringByAppendingString:@"photo/add_album"];
	[apiRequest openUrl:fullURL token:_accessToken openid:_openId appid:_appId params:params];
	[_apiRequests setObject:apiRequest forKey:[NSString stringWithFormat:@"%d", apiRequest.seq]];
	return YES;
}

/**
 * Add One Blog.
 */
- (BOOL)addOneBlogWithParams:(NSMutableDictionary *)params
{
	if (![self isSessionValid] || ![self isOpenIdValid]) {
		return NO;
	}
	
	APIBase *apiRequest = [[APIBase alloc] initWithTarget:self andSelector:@selector(addOneBlogResponse:) andHttpMethod:@"POST"];
	NSString * fullURL = [kRestserverBaseURL stringByAppendingString:@"blog/add_one_blog"];
	[apiRequest openUrl:fullURL token:_accessToken openid:_openId appid:_appId params:params];
	[_apiRequests setObject:apiRequest forKey:[NSString stringWithFormat:@"%d", apiRequest.seq]];
	return YES;
}
/**
 *Check Fans
 */
-(BOOL)checkPageFansWithParams:(NSMutableDictionary *)params
{
	if (![self isSessionValid] || ![self isOpenIdValid]) {
		return NO;
	}
	
	APIBase *apiRequest = [[APIBase alloc] initWithTarget:self andSelector:@selector(checkPageFansResponse:) andHttpMethod:@"GET"];
	NSString * fullURL = [kRestserverBaseURL stringByAppendingString:@"user/check_page_fans"];
	[apiRequest openUrl:fullURL token:_accessToken openid:_openId appid:_appId params:params];
	[_apiRequests setObject:apiRequest forKey:[NSString stringWithFormat:@"%d", apiRequest.seq]];
	return YES;
}


/**
 * Add topic.
 */
- (BOOL)addTopicWithParams:(NSMutableDictionary *)params
{
	if (![self isSessionValid] || ![self isOpenIdValid]) {
		return NO;
	}
	
	APIBase *apiRequest = [[APIBase alloc] initWithTarget:self andSelector:@selector(addTopicResponse:) andHttpMethod:@"POST"];
	NSString * fullURL = [kRestserverBaseURL stringByAppendingString:@"shuoshuo/add_topic"];
	[apiRequest openUrl:fullURL token:_accessToken openid:_openId appid:_appId params:params];
	[_apiRequests setObject:apiRequest forKey:[NSString stringWithFormat:@"%d", apiRequest.seq]];
	return YES;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)deleteAPIRequestBySeq:(NSString*)seq
{
	APIBase *apiRequest = [_apiRequests objectForKey:seq];
	if (apiRequest)
		[apiRequest release];
	[_apiRequests removeObjectForKey:seq];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Called when the get_user_info has response.
 */
- (void)getUserInfoResponse:(APIResponse*) response
{
	if (!response)
		return;
	[self deleteAPIRequestBySeq:[NSString stringWithFormat:@"%d", response.seq]];
	if ([self.sessionDelegate respondsToSelector:@selector(getUserInfoResponse:)]) 
	{
		[_sessionDelegate getUserInfoResponse:response];
	}
}

/**
 * Called when the get_list_album has response.
 */
- (void)getListAlbumResponse:(APIResponse*) response
{
	if (!response)
		return;
	[self deleteAPIRequestBySeq:[NSString stringWithFormat:@"%d", response.seq]];
	if ([self.sessionDelegate respondsToSelector:@selector(getListAlbumResponse:)]) 
	{
		[_sessionDelegate getListAlbumResponse:response];
	}
}
/**
 * Called when the get_list_photo has response.
 */
- (void)getListPhotoResponse:(APIResponse*) response
{
	if (!response)
		return;
	[self deleteAPIRequestBySeq:[NSString stringWithFormat:@"%d", response.seq]];
	if ([self.sessionDelegate respondsToSelector:@selector(getListPhotoResponse:)]) 
	{
		[_sessionDelegate getListPhotoResponse:response];
	}
}

/**
 * Called when the add_share has response.
 */
- (void)addShareResponse:(APIResponse*) response
{
	if (!response)
		return;
	[self deleteAPIRequestBySeq:[NSString stringWithFormat:@"%d", response.seq]];
	if ([self.sessionDelegate respondsToSelector:@selector(addShareResponse:)]) 
	{
		[_sessionDelegate addShareResponse:response];
	}
}

/**
 * Called when the add_album has response.
 */
- (void)addAlbumResponse:(APIResponse*) response
{
	if (!response)
		return;
	[self deleteAPIRequestBySeq:[NSString stringWithFormat:@"%d", response.seq]];
	if ([self.sessionDelegate respondsToSelector:@selector(addAlbumResponse:)]) 
	{
		[_sessionDelegate addAlbumResponse:response];
	}
}

/**
 * Called when the upload_pic has response.
 */
- (void)uploadPicResponse:(APIResponse*) response
{
	if (!response)
		return;
	[self deleteAPIRequestBySeq:[NSString stringWithFormat:@"%d", response.seq]];
	if ([self.sessionDelegate respondsToSelector:@selector(uploadPicResponse:)]) 
	{
		[_sessionDelegate uploadPicResponse:response];
	}
}
/**
 * Called when the  check_page_fans has response.
 */
- (void)checkPageFansResponse:(APIResponse*) response
{
	if (!response)
		return;
	[self deleteAPIRequestBySeq:[NSString stringWithFormat:@"%d", response.seq]];
	if ([self.sessionDelegate respondsToSelector:@selector(checkPageFansResponse:)]) 
	{
		[_sessionDelegate checkPageFansResponse:response];
	}
}


/**
 * Called when the add_one_blog has response.
 */
- (void)addOneBlogResponse:(APIResponse*) response
{
	if (!response)
		return;
	[self deleteAPIRequestBySeq:[NSString stringWithFormat:@"%d", response.seq]];
	if ([self.sessionDelegate respondsToSelector:@selector(addOneBlogResponse:)]) 
	{
		[_sessionDelegate addOneBlogResponse:response];
	}
}

/**
 * Called when the add_topic has response.
 */
- (void)addTopicResponse:(APIResponse*) response
{
	if (!response)
		return;
	[self deleteAPIRequestBySeq:[NSString stringWithFormat:@"%d", response.seq]];
	if ([self.sessionDelegate respondsToSelector:@selector(addTopicResponse:)]) 
	{
		[_sessionDelegate addTopicResponse:response];
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
//TencentLoginViewDelegate

/**
 * Set the authToken and expirationDate after login succeed
 */
- (void)tencentDialogLogin:(NSString *)token expirationDate:(NSDate *)expirationDate {
	self.accessToken = token;
	self.expirationDate = expirationDate;
	// 继续获取openid
		
	NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
																	token, @"access_token",
																	nil];

	[self requestWithGraphPath:kMe andParams:params andDelegate:self];
		
//	if ([self.sessionDelegate respondsToSelector:@selector(tencentDidLogin)]) {
//		[_sessionDelegate tencentDidLogin];
//	}
	
}

/**
 * Did not login call the not login delegate
 */
- (void)tencentDialogNotLogin:(BOOL)cancelled {
	if ([self.sessionDelegate respondsToSelector:@selector(tencentDidNotLogin:)]) {
		[_sessionDelegate tencentDidNotLogin:cancelled];
	}
}
/**
 * Did not network delegate
 */
- (void)tencentDidNotNetWork{
	if ([self.sessionDelegate respondsToSelector:@selector(tencentDidNotNetWork)]) {
		[_sessionDelegate tencentDidNotNetWork];
	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////

//TencentRequestDelegate

/**
 * Handle the auth.ExpireSession api call failure
 */
- (void)request:(TencentRequest*)request didFailWithError:(NSError*)error{
	NSLog(@"Failed to expire the session");
	[_loginDialog dismissWithSuccess:NO animated:YES];	
}

- (void)request:(TencentRequest *)request didReceiveResponse:(NSURLResponse *)response {
	NSLog(@"received response");
}

/**
 * Called when a request returns and its response has been parsed into
 * an object. The resulting object may be a dictionary, an array, a string,
 * or a number, depending on the format of the API response. If you need access
 * to the raw response, use:
 *
 * (void)request:(FBRequest *)request
 *      didReceiveResponse:(NSURLResponse *)response
 */
- (void)request:(TencentRequest *)request didLoad:(id)result dat:(NSData *)data {
	NSString *responseString = [[NSString alloc] initWithData:(NSData*)result encoding:NSUTF8StringEncoding];
	if ([[responseString substringToIndex:8] isEqualToString:@"callback"]) {
		responseString = [responseString substringWithRange:NSMakeRange(10, [responseString length]-13)];
	}
	
	NSDictionary *root = [responseString JSONValue];
	if ([[root allKeys] count] == 0) {
		NSLog(@"received didLoad error");
		[_loginDialog dismissWithSuccess:NO animated:YES];
		[self tencentDialogNotLogin:NO];
		return;
	}
		
	NSString *client_id = [root objectForKey:@"client_id"];
	NSString *openid = [root objectForKey:@"openid"];
	[_openId release];
	_openId = [openid copy];
	[_loginDialog dismissWithSuccess:YES animated:YES];
		
	if ([self.sessionDelegate respondsToSelector:@selector(tencentDidLogin)]) {
		[_sessionDelegate tencentDidLogin];
	}
	NSLog(@"received didLoad success clientid=%@, openid=%@", client_id, openid);
};

@end
