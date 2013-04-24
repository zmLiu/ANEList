//
//  TencentTargetSelector.h
//  TencentOAuthDemo
//
//  Created by cloudxu on 11-8-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>


/*!
    @class       TencentTargetSelector 
    @superclass  NSObject { id _target; SEL _selector; }
*/
@interface TencentTargetSelector : NSObject {
	id _target;
	SEL _selector;
}

@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL selector;

/*!
    @method     target:selector:
    @param      target target
    @param      selector selector
*/
+ (TencentTargetSelector *) target:(id)target selector:(SEL)selector;

@end

