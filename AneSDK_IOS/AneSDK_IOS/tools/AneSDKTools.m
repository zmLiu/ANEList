//
//  AneSDKTools.m
//  AneSDK_IOS
//
//  Created by lzm on 13-3-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "AneSDKTools.h"
#import <sys/socket.h> // Per msqr
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <CommonCrypto/CommonDigest.h>

@implementation AneSDKTools

-(FREObject) execute:(FREObject [])args{
    NSString *funKey = [self getNSStringFromFreObject:args[0]];
    if([funKey isEqualToString:@"getDeviceID"]){
        return [self getDeviceID];
    }else if([funKey isEqualToString:@"ShowIconBadageNumber"]){
        return [self ShowIconBadageNumber:args];
    }else if([funKey isEqualToString:@"setIdleTimerDisabled"]){
        return [self setIdleTimerDisabled:args];
    }else if ([funKey isEqualToString:@"makeScore"]) {
        return [self makeScore:[self getNSStringFromFreObject:args[1]]];
    }else if([funKey isEqualToString:@"parseTransactionReceipt"]){
        return [self parseTransactionReceipt:[self getNSStringFromFreObject:args[1]]];
    }
    return NULL;
}

-(FREObject) getDeviceID{
    NSString *deviceId = [self macAddress];
    deviceId = [self md5:deviceId];
    return [self getfreobjectFromNSString:deviceId];
}

//设置通知数量
-(FREObject) ShowIconBadageNumber:(FREObject[])args{
    int value = [self getIntFromFreObject:args[1]];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:value];
    return NULL;
}

//设置屏幕常亮
-(FREObject) setIdleTimerDisabled:(FREObject[])args{
    BOOL value = [self getBoolFromFreObject:args[1]];
    [[UIApplication sharedApplication] setIdleTimerDisabled:value];
    return NULL;
}

//评分
-(FREObject) makeScore:(NSString *)appid{
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",appid]]];
    return NULL;
}

-(FREObject) parseTransactionReceipt:(NSString *)receipt{
    receipt = [receipt stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"]; 
    return [self getfreobjectFromNSString:receipt];
}


-(NSString *) macAddress{
    
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    buf = (char*)malloc(len);
    if (buf == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

- (NSString *)md5HexDigest:(NSString*)input 
{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",result];
    }    
    return ret;
} 

- (NSString *) md5:(NSString *)str
{
    
    if(str == nil || [str length] == 0)
        return nil;
    
    const char *value = [str UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, strlen(value), outputBuffer);
    
    NSMutableString *outputString = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

@end
