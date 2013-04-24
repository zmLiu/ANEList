//
//  WXDelegate.h
//  AneSDK_IOS
//
//  Created by lzm on 13-3-13.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "AneFunction.h"
#import "WXApi.h"

@interface WXDelegate : AneFunction<WXApiDelegate>{
    
    BOOL mIsRegisterApp;
    NSString *mAppid;
    
}

@end
