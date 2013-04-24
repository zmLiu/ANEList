//
//  AneSDKFlurry.m
//  AneSDK_IOS
//
//  Created by lzm on 13-3-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "AneSDKFlurry.h"

@implementation AneSDKFlurry

-(FREObject) execute:(FREObject [])args{
    NSString *funKey = [self getNSStringFromFreObject:args[0]];
    if([funKey isEqualToString:@"startSession"]){
        [self startSession:[self getNSStringFromFreObject:args[1]]];
    }else if([funKey isEqualToString:@"logEvent"]){
        [self logEvent:[self getNSStringFromFreObject:args[1]]];
    }
    return NULL;
}

//开始会话
-(void) startSession:(NSString *)apiKey{
    [Flurry startSession:apiKey];
}

//记录事件
-(void) logEvent:(NSString *)event{
    [Flurry logEvent:event];
}

@end
