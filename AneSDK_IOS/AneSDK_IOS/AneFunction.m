//
//  AneFunction.m
//  AneSDK_IOS
//
//  Created by lzm on 13-3-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "AneFunction.h"

@implementation AneFunction

-(id) initWithFreContext:(FREContext)freContext{
    self = [super init];
    if(self){
        mFreContext = freContext;
    }
    return self;
}

-(FREObject) execute:(FREObject [])args{
    
    
    
    return NULL;
}

-(double) getDoubleFromFreObject:(FREObject)freObject{
    double num;
    FREGetObjectAsDouble(freObject, &num);
    return num;
}

-(FREObject) getFreObjectFromDouble:(double)num{
    FREObject numToReturn = nil;
    FRENewObjectFromDouble(num, &numToReturn);
    return numToReturn;
}

-(int) getIntFromFreObject:(FREObject) freObject{
    int32_t value;
    FREGetObjectAsInt32(freObject, &value);
    return value;
}

-(FREObject) getFreObjectFromInt:(int) value{
    FREObject intToReturn = nil;
    FRENewObjectFromInt32(value, &intToReturn);
    return intToReturn;
}

-(uint) getUintFromFreObject:(FREObject) freObject{
    uint32_t value;
    FREGetObjectAsUint32(freObject, &value);
    return value;
}

-(FREObject) getFreObjectFromUint:(uint) value{
    FREObject uintToReturn = nil;
    FRENewObjectFromUint32(value, &uintToReturn);
    return uintToReturn;
}

-(NSString *) getNSStringFromFreObject:(FREObject)freObject{
    uint32_t strLength;
    const uint8_t *str;
    FREGetObjectAsUTF8(freObject, &strLength, &str);
    NSString *ocStr = [NSString stringWithUTF8String:(char*)str];
    return ocStr;
}

-(FREObject) getfreobjectFromNSString:(NSString *) nsstring{
    const char *str = [nsstring UTF8String];
    FREObject strReturn;
    FRENewObjectFromUTF8(strlen(str)+1, (const uint8_t*)str, &strReturn);
    return strReturn;
}

-(BOOL) getBoolFromFreObject:(FREObject) freObject{
    uint32_t boolean;
    FREGetObjectAsBool(freObject, &boolean);
    return boolean;
}

-(FREObject) getfreobjectFromBool:(BOOL) b{
    FREObject retBool = nil;
    FRENewObjectFromBool(b, &retBool);
    return retBool;
}

-(void) broadcast:(NSString *)code level:(NSString *)level{
    FREDispatchStatusEventAsync(mFreContext, (const uint8_t *)[code UTF8String],(const uint8_t *)[level UTF8String]);
}

-(void) dealloc{
    mFreContext = nil;
    [super dealloc];
}

@end
