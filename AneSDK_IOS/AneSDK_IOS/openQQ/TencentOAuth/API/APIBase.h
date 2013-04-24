//
//  APIBase.h
//  TencentOAuthDemo
//
//  Created by cloudxu on 11-8-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

/*!
 @header APIBase
 @discussion APIBase
 */

#import <Foundation/Foundation.h>
#import "TencentRequest.h"
#import "APIResponse.h"


/*!
 @class       APIBase 
 @superclass  NSObject <TencentRequestDelegate>{ TencentRequest* _request; NSString* _httpMethod; id _target; SEL _selector; int _seq; }
 
 */
@interface APIBase : NSObject <TencentRequestDelegate>{
	TencentRequest* _request;
	
	NSString*		_httpMethod;
	id				_target;
	SEL				_selector;
	int				_seq;
}

@property (nonatomic, retain) NSString* httpMethod;
@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, assign) int seq;

/*!
 @method     initWithTarget:andSelector:andHttpMethod
 @discussion 初始化
 @param      target target
 @param      selector selector
 @param      method method
 @result     id
 */
- (id)initWithTarget:(id)target
		 andSelector:(SEL)selector
	   andHttpMethod:(NSString*)method;

/*!
 @method     openUrl:token:openid:appid:params:
 @discussion 打开链接
 @param      url url
 @param      token token
 @param      openid openid
 @param      appid appid
 @param      params 参数列表
 @result     TencentRequest
 */
- (TencentRequest*)openUrl:(NSString *)url
					 token:(NSString *)token
					openid:(NSString *)openid
					 appid:(NSString *)appid
					params:(NSMutableDictionary *)params;
@end
