//
//  YZPlatformDelete.m
//  AneSDK_IOS
//
//  Created by lzm on 13-3-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "YZPlatformDelete.h"

@implementation YZPlatformDelete

-(FREObject) execute:(FREObject [])args{
    NSString *funKey = [self getNSStringFromFreObject:args[0]];
    if ([funKey isEqualToString:@"initYZPlatform"]) {
        [self initYZPlatform:[self getNSStringFromFreObject:args[1]] isDebug:[self getBoolFromFreObject:args[2]]];
    }else if([funKey isEqualToString:@"showYZPlatform"]){
        [self showYZPlatform];
    }
    return NULL;
} 

//初始化yz平台
-(void) initYZPlatform:(NSString *)appid isDebug:(BOOL)isDebug{
    mPlatformlib = [Platformlib getInstance];
    [mPlatformlib run:nil appDelegate:self appid:appid isNetworkReachable:[mPlatformlib isNetworkReachable] orientation:UIDeviceOrientationLandscapeLeft isDebug:isDebug];
}

//显示yz平台
-(void) showYZPlatform{
    [mPlatformlib show:nil];
}

-(void) dealloc{
    [mPlatformlib release];
    [super dealloc];
}

//通知app,平台已经开始运行(可进行关闭启动画面等操作)
-(void)onPlatformLibStartRuning{
    [self broadcast:EVENT_ON_YZPLATFROM_STARTRUN level:@"someData"];
}

//app运行(可打开app主界面)
-(void)onAppStart{
    [self broadcast:EVENT_ON_YZPLATFROM_APPSTART level:@"someData"];
}

//平台登录状态返回
-(void)onLoginPT:(BOOL)status data:(NSMutableDictionary *)d{

}

//登陆超时
-(void)onPlatformLibTimeout{
    [self broadcast:EVENT_ON_YZPLATFROM_TIMEOUT level:@"someData"];
}

@end
