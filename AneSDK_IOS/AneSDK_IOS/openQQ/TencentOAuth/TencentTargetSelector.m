//
//  TencentTargetSelector.m
//  TencentOAuthDemo
//
//  Created by cloudxu on 11-8-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TencentTargetSelector.h"


@implementation TencentTargetSelector

@synthesize target = _target;
@synthesize selector = _selector;

+ (TencentTargetSelector *) target:(id)target selector:(SEL)selector {
	TencentTargetSelector *aQTagertSelector = [[[TencentTargetSelector alloc] init] autorelease];
	aQTagertSelector.target = target;
	aQTagertSelector.selector = selector;
	return aQTagertSelector;
}

@end
