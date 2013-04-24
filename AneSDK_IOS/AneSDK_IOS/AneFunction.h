//
//  AneFunction.h
//  AneSDK_IOS
//
//  Created by lzm on 13-3-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"

@interface AneFunction : NSObject{
    FREContext mFreContext;
}

-(id) initWithFreContext:(FREContext) freContext;

-(FREObject) execute:(FREObject[]) args;

-(double) getDoubleFromFreObject:(FREObject) freObject;
-(FREObject) getFreObjectFromDouble:(double) num;

-(int) getIntFromFreObject:(FREObject) freObject;
-(FREObject) getFreObjectFromInt:(int) value;

-(uint) getUintFromFreObject:(FREObject) freObject;
-(FREObject) getFreObjectFromUint:(uint) value;


-(NSString *) getNSStringFromFreObject:(FREObject) freObject;
-(FREObject) getfreobjectFromNSString:(NSString *) nsstring;

-(BOOL) getBoolFromFreObject:(FREObject) freObject;
-(FREObject) getfreobjectFromBool:(BOOL) b;

//广播 事件到flash
-(void) broadcast:(NSString *)code level:(NSString *)level;

@end
