//
//  OpenQQDelegate.h
//  AneSDK_IOS
//
//  Created by lzm on 13-3-13.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "AneFunction.h"
#import "TencentOAuth.h"

#define EVENT_DIDLOGIN_QQ   @"EVENT_DIDLOGIN_QQ"
#define EVENT_DIDNOTLOGIN_QQ    @"EVENT_DIDNOTLOGIN_QQ"
#define EVENT_DIDNOTNETWORK_QQ  @"EVENT_DIDNOTNETWORK_QQ"
#define EVENT_GETUSERINFO_QQ    @"EVENT_GETUSERINFO_QQ"
#define EVENT_SHARE_QQ  @"EVENT_SHARE_QQ"
#define EVENT_TOPIC_QQ  @"EVENT_TOPIC_QQ"

@interface OpenQQDelegate : AneFunction<TencentSessionDelegate>{
    
    TencentOAuth *mTencenOAuth;
    NSMutableArray *mPermissions;
    
}

@end
