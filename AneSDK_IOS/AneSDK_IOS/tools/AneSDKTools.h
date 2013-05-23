//
//  AneSDKTools.h
//  AneSDK_IOS
//
//  Created by lzm on 13-3-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "AneFunction.h"
#import <UIKit/UIKit.h>

@interface AneSDKTools : AneFunction

//获取设备id
-(FREObject) getDeviceID;

//设置通知数量
-(FREObject) ShowIconBadageNumber:(FREObject[])args;

//设置屏幕常亮
-(FREObject) setIdleTimerDisabled:(FREObject[])args;

//评分
-(FREObject) makeScore:(NSString*) appid;

//获取设备描述符
-(FREObject) deviceString;

@end
