//
//  Platformlib.h
//  Platformlib
//
//  Created by user on 12-9-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


//app protocol
@protocol IAppDelegate <NSObject>
    @required
        -(void)onPlatformLibStartRuning;    //通知app,平台已经开始运行(可进行关闭启动画面等操作)
        -(void)onAppStart;  //app运行(可打开app主界面)
        -(void)onLoginPT:(BOOL)status data:(NSMutableDictionary *)d;   //平台登录状态返回
        -(void)onPlatformLibTimeout;    //通知app,平台已经运行超时
@end


//libs
@interface Platformlib : NSObject

@property(nonatomic, readonly) NSString *uuid;  //the phone deriveID

@property(nonatomic, readonly) NSString *appid; //the appid

@property(nonatomic, readonly) BOOL isConnected;    //是否已经联网

@property(nonatomic, readonly) BOOL isLogin;    //是否已经登录了
@property(nonatomic, readonly) NSString *uid;  //用户uid
@property(nonatomic, readonly) NSString *token; //用户的token
@property(nonatomic, readonly) NSString *apiUrl; //请求api的地址
@property(nonatomic, readonly) NSString *resUserUrl; //加载用户图片的地址

#pragma mark
#pragma mark method
//start runing platform
-(void) run:(UIViewController *)mainViewController appDelegate:(id<IAppDelegate>)app appid:(NSString *)theAppid isNetworkReachable:(BOOL)theNetWorkReachable orientation:(UIDeviceOrientation)appOrientation isDebug:(bool)debug;

//is phone has alive network
-(BOOL) isNetworkReachable;

-(void) show:(UIViewController *)mainViewController;   //显示
-(void) hide;   //隐藏

-(void) loginPT:(NSString *)ptname pass:(NSString *)ptpass;

-(void) request:(NSString *)url cmd:(NSString *)c modlue:(NSString *)m data:(NSMutableDictionary *)d type:(NSString *)t;


+(Platformlib *) getInstance;

@end





