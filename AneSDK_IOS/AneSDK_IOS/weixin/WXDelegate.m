//
//  WXDelegate.m
//  AneSDK_IOS
//
//  Created by lzm on 13-3-13.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "WXDelegate.h"

@implementation WXDelegate

-(void) dealloc{
    [mAppid release];
    [super dealloc];
}

-(FREObject) execute:(FREObject [])args{
    NSString *funcKey = [self getNSStringFromFreObject:args[0]];
    if ([funcKey isEqualToString:@"registerApp"]) {
        [self registerApp:[self getNSStringFromFreObject:args[1]]];
    }else if ([funcKey isEqualToString:@"shareImage"]) {
        [self shareImage:[self getNSStringFromFreObject:args[1]]];
    }else if ([funcKey isEqualToString:@"isWXAppInstalled"]) {
        return [self isWXAppInstalled];
    }
    return NULL;
}

//检测微信是否安装
-(FREObject) isWXAppInstalled{
    BOOL isInstalled = [WXApi isWXAppInstalled];
    return [self getfreobjectFromBool:isInstalled];
}

//注册
-(void) registerApp:(NSString *) appid{
    if(mIsRegisterApp == YES){
        return;
    }
    [WXApi registerApp:appid];
    mIsRegisterApp = YES;
    mAppid = appid;
    [mAppid retain];
}

//分享本地图片
-(void) shareImage:(NSString *)imagePath{
    [WXApi handleOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://",mAppid]] delegate:self];
    
    WXMediaMessage *message = [WXMediaMessage message];
    
    [message setThumbData:UIImageJPEGRepresentation([UIImage imageWithContentsOfFile:imagePath], 0.3)];
    
    WXImageObject *ext = [WXImageObject object];
    ext.imageData = UIImageJPEGRepresentation([UIImage imageWithContentsOfFile:imagePath], 1);
    message.mediaObject = ext;
    
    SendMessageToWXReq *req = [[[SendMessageToWXReq alloc] init] autorelease];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;//分享到朋友圈
    
    [WXApi sendReq:req];
    
}

-(void) onReq:(BaseReq *)req{
    [self broadcast:@"WXBaseReq" level:@"WXBaseReq"];
}

-(void) onResp:(BaseResp *)resp{
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *strMsg = [NSString stringWithFormat:@"发送消息结果:%d", resp.errCode];
        [self broadcast:@"BaseResp" level:strMsg];
    }
}

@end
