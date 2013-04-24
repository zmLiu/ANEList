//
//  WeiBoDelegate.h
//  AneSDK_IOS
//
//  Created by lzm on 13-3-13.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "AneFunction.h"
#import "SinaWeibo.h"

#define EVENT_SINAWEIBODIDLOGIN @"EVENT_SINAWEIBODIDLOGIN"

@interface WeiBoDelegate : AneFunction<SinaWeiboDelegate,SinaWeiboRequestDelegate>{
    SinaWeibo *mWeiBo;
}



@end
