//
//  YZPlatformDelete.h
//  AneSDK_IOS
//
//  Created by lzm on 13-3-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "AneFunction.h"
#import "Platformlib.h"

#define EVENT_ON_YZPLATFROM_STARTRUN @"EVENT_ON_YZPLATFROM_STARTRUN"    //平台启动成功
#define EVENT_ON_YZPLATFROM_APPSTART @"EVENT_ON_YZPLATFROM_APPSTART"    //平台点击了当前游戏
#define EVENT_ON_YZPLATFROM_TIMEOUT @"EVENT_ON_YZPLATFROM_TIMEOUT"      //平台超时

@interface YZPlatformDelete : AneFunction<IAppDelegate>{
    Platformlib *mPlatformlib;
}
@end
