//
//  OpenQQDelegate.m
//  AneSDK_IOS
//
//  Created by lzm on 13-3-13.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "OpenQQDelegate.h"

@implementation OpenQQDelegate

-(void) dealloc{
    [mPermissions release];
    mPermissions = nil;
    
    [mTencenOAuth release];
    mTencenOAuth = nil;
    
    [super dealloc];
}

-(FREObject) execute:(FREObject [])args{
    NSString *funKey = [self getNSStringFromFreObject:args[0]];
    if([funKey isEqualToString:@"initOpenQQ"]){
        [self initOpenQQ:[self getNSStringFromFreObject:args[1]]];
    }else if ([funKey isEqualToString:@"login"]) {
        [self login];
    }else if ([funKey isEqualToString:@"getUserInfo"]) {
        [self getUserInfo];
    }else if ([funKey isEqualToString:@"share"]) {
        [self share:[self getNSStringFromFreObject:args[1]] url:[self getNSStringFromFreObject:args[2]] comment:[self getNSStringFromFreObject:args[3]] summary:[self getNSStringFromFreObject:args[4]] images:[self getNSStringFromFreObject:args[5]]];
    }else if ([funKey isEqualToString:@"topic"]) {
        [self topic:[self getNSStringFromFreObject:args[1]] image:[self getNSStringFromFreObject:args[2]] imageW:[self getNSStringFromFreObject:args[3]] imageH:[self getNSStringFromFreObject:args[4]]];
    }else if([funKey isEqualToString:@"isLogin"]){
        return [self isLogin];
    }
    return NULL;
}

-(void) initOpenQQ:(NSString *)appid{
    
    if(mTencenOAuth == nil){
        
        mPermissions = [[NSArray arrayWithObjects:@"get_user_info",@"add_share", @"add_topic",@"add_one_blog", @"list_album",@"upload_pic",@"list_photo", @"add_album", @"check_page_fans",nil] retain];
        
        mTencenOAuth = [[TencentOAuth alloc] initWithAppId:appid andDelegate:self];
        mTencenOAuth.redirectURI = @"www.qq.com";
        
    }
    
}

//是否已经登陆
-(FREObject) isLogin{
    if (mTencenOAuth == nil) {
        return [self getfreobjectFromBool:NO];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"openQQAccessToken"] != nil) {
        mTencenOAuth.accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"openQQAccessToken"];
        mTencenOAuth.expirationDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"openQQexpirationDate"];
        mTencenOAuth.openId = [[NSUserDefaults standardUserDefaults] objectForKey:@"openQQopenId"];
        
        if(mTencenOAuth.isSessionValid){
            return [self getfreobjectFromBool:YES];
        }
    }
    
    return [self getfreobjectFromBool:NO];
}

- (void) login{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"openQQAccessToken"] != nil) {
        mTencenOAuth.accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"openQQAccessToken"];
        mTencenOAuth.expirationDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"openQQexpirationDate"];
        mTencenOAuth.openId = [[NSUserDefaults standardUserDefaults] objectForKey:@"openQQopenId"];
    }
    if(mTencenOAuth.isSessionValid){
        [self tencentDidLogin];
    }else{
        [mTencenOAuth authorize:mPermissions inSafari:NO];
    }
}


- (void) getUserInfo{
    [mTencenOAuth getUserInfo];
}

//分享
- (void) share:(NSString *)title url:(NSString *)url comment:(NSString *)comment summary:(NSString *)summary images:(NSString *)images{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   title, @"title",
								   url, @"url",
                                   comment,@"comment",
								   summary,@"summary",
								   images,@"images",
								   @"4",@"source",
								   nil];
	
	[mTencenOAuth addShareWithParams:params];
}

//发表说说
- (void) topic:(NSString *)con image:(NSString *)image imageW:(NSString *)imageW imageH:(NSString *)imageH{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   con, @"con",
								   @"1",@"richtype",
                                   [NSString stringWithFormat:@"url=%@&width=%@&height=%@",image,imageW,imageH],@"richval",
								   @"2",@"third_source",
								   nil];
	[mTencenOAuth addTopicWithParams:params];
    
}

/**
 * 登陆成功
 */
- (void)tencentDidLogin {
    [[NSUserDefaults standardUserDefaults] setObject:mTencenOAuth.accessToken forKey:@"openQQAccessToken"];
    [[NSUserDefaults standardUserDefaults] setObject:mTencenOAuth.expirationDate forKey:@"openQQexpirationDate"];
    [[NSUserDefaults standardUserDefaults] setObject:mTencenOAuth.openId forKey:@"openQQopenId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSString *level = [NSString stringWithFormat:@"%@|%@",mTencenOAuth.accessToken,mTencenOAuth.openId];
    [self broadcast:EVENT_DIDLOGIN_QQ level:level];
}


/**
 * 登陆失败
 */
- (void)tencentDidNotLogin:(BOOL)cancelled{
    NSString *level = @"didNotLogin";
    [self broadcast:EVENT_DIDNOTLOGIN_QQ level:level];
}

/**
 * 没有网络
 */
-(void)tencentDidNotNetWork{
    NSString *level = @"didNotNetWork";
    [self broadcast:EVENT_DIDNOTNETWORK_QQ level:level];
}

/**
 获取用户信息回调
 */
- (void)getUserInfoResponse:(APIResponse*) response {
    NSString *level = @"err";
	if (response.retCode == URLREQUEST_SUCCEED){
        level = [NSString stringWithFormat:@"%@",response.jsonResponse];
	}
    [self broadcast:EVENT_GETUSERINFO_QQ level:level];
}

/*
 
 分享回调
 
 */
- (void)addShareResponse:(APIResponse*) response {
    NSString *level = @"failed";
	if (response.retCode == URLREQUEST_SUCCEED){
		level = @"suc";
	}
    [self broadcast:EVENT_SHARE_QQ level:level];
}

/*
 说说回调
 */
-(void)addTopicResponse:(APIResponse*) response {
    NSString *level = @"failed";
	if (response.retCode == URLREQUEST_SUCCEED){
		level = @"suc";
	}
    [self broadcast:EVENT_TOPIC_QQ level:level];
}

@end
