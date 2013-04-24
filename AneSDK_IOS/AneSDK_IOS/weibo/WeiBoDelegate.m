//
//  WeiBoDelegate.m
//  AneSDK_IOS
//
//  Created by lzm on 13-3-13.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "WeiBoDelegate.h"

@implementation WeiBoDelegate

-(FREObject) execute:(FREObject [])args{
    NSString *funKey = [self getNSStringFromFreObject:args[0]];
    if([funKey isEqualToString:@"initWeiBo"]){
        [self initWeiBo:[self getNSStringFromFreObject:args[1]] appSceret:[self getNSStringFromFreObject:args[2]]];
    }else if([funKey isEqualToString:@"login"]){
        [self login];
    }else if([funKey isEqualToString:@"share"]){
        [self share:[self getNSStringFromFreObject:args[1]] imagePath:[self getNSStringFromFreObject:args[2]]];
    }
    return NULL;
}

-(void) dealloc{
    [mWeiBo release];
    mWeiBo = nil;
    [super dealloc];
}

-(void) initWeiBo:(NSString *) appKey appSceret:(NSString *)appSceret{
    if(mWeiBo == nil){
        mWeiBo = [[SinaWeibo alloc] initWithAppKey:appKey appSecret:appSceret appRedirectURI:@"http://" andDelegate:self];
    }
}

//登陆
-(void) login{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"SinaWeiBoUserId"] != nil) {
        mWeiBo.userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"SinaWeiBoUserId"];
        mWeiBo.accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"SinaWeiBoAccessToken"];
        mWeiBo.expirationDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"SinaWeiBoExpirationDate"];
    }
    if ([mWeiBo isAuthValid]) {
        [self sinaweiboDidLogIn:mWeiBo];
    }else{
        [mWeiBo logIn];
    }
}

//分享
//status    微薄类容
//imagePath 本地图片地址
-(void) share:(NSString *)status imagePath:(NSString *)imagePath{
    if ([mWeiBo isAuthValid]) {
        [mWeiBo requestWithURL:@"statuses/upload.json" params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                               status,@"status",
                                                               UIImagePNGRepresentation([UIImage imageWithContentsOfFile:imagePath]),@"pic",
                                                               nil] httpMethod:@"POST" delegate:self];
        [self broadcast:@"shareSinaWeiBo" level:@"shareSinaWeiBo"];
    }else {
        [self login];
    }
}


//登陆成功
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo{
    [[NSUserDefaults standardUserDefaults] setObject:mWeiBo.userID forKey:@"SinaWeiBoUserId"];
    [[NSUserDefaults standardUserDefaults] setObject:mWeiBo.accessToken forKey:@"SinaWeiBoAccessToken"];
    [[NSUserDefaults standardUserDefaults] setObject:mWeiBo.expirationDate forKey:@"SinaWeiBoExpirationDate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self broadcast:EVENT_SINAWEIBODIDLOGIN level:EVENT_SINAWEIBODIDLOGIN];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo{
    
}
- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo{
    
}
- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error{
    
}
- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error{
    
}

- (void)request:(SinaWeiboRequest *)request didReceiveResponse:(NSURLResponse *)response{
    
}
- (void)request:(SinaWeiboRequest *)request didReceiveRawData:(NSData *)data{
    
}
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error{
    
}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    
}


@end
