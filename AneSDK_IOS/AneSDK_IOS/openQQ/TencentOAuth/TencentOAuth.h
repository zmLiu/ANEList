//
//  TencentOAuth.h
//  TencentOAuthDemo
//
//  Created by cloudxu on 11-8-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "TencentLoginView.h"
#import "TencentRequest.h"
#import "APIBase.h"

@protocol TencentSessionDelegate;


/*!
 @class       TencentOAuth 
 @superclass  NSObject<TencentLoginViewDelegate, TencentRequestDelegate>{ NSString* _accessToken; NSDate* _expirationDate; id<TencentSessionDelegate> _sessionDelegate; TencentRequest* _request; TencentLoginView* _loginDialog; NSString* _appId; NSString* _localAppId; NSString* _openId; NSString* _redirectURI; NSArray* _permissions; NSMutableDictionary*	_apiRequests; }
 */
@interface TencentOAuth : NSObject<TencentLoginViewDelegate, TencentRequestDelegate>{
	NSString* _accessToken;
	NSDate* _expirationDate;
	id<TencentSessionDelegate> _sessionDelegate;
	TencentRequest* _request;
	TencentLoginView* _loginDialog;
	NSString* _appId;
	NSString* _localAppId;
	NSString* _openId;
	NSString* _redirectURI;
	NSArray* _permissions;	
	NSMutableDictionary*	_apiRequests;
}

@property(nonatomic, copy) NSString* accessToken;
@property(nonatomic, copy) NSDate* expirationDate;
@property(nonatomic, assign) id<TencentSessionDelegate> sessionDelegate;
@property(nonatomic, copy) NSString* localAppId;
@property(nonatomic, copy) NSString* openId;
@property(nonatomic, copy) NSString* redirectURI;

/*!
 @method     initWithAppId:andDelegate:
 @param      appId appId
 @param      delegate delegate
 */
- (id)initWithAppId:(NSString *)appId
        andDelegate:(id<TencentSessionDelegate>)delegate;

/*!
 @method     authorize:inSafari:
 @param      permissions permissions
 @param      bInSafari bInSafari
 */
- (void)authorize:(NSArray *)permissions 
		 inSafari:(BOOL)bInSafari;

/*!
 @method     authorize:localAppId:inSafari:
 @param      permissions permissions
 @param      localAppId localAppId
 @param      bInSafari bInSafari
 */
- (void)authorize:(NSArray *)permissions
       localAppId:(NSString *)localAppId
		 inSafari:(BOOL)bInSafari;

/*!
 @method     handleOpenURL:
 @param      url url
 */
- (BOOL)handleOpenURL:(NSURL *)url;

/*!
 @method     logout:
 @param      delegate delegate
 */
- (void)logout:(id<TencentSessionDelegate>)delegate;

/*!
 @method     requestWithParams:andDelegate:
 @param      params params
 @param      delegate delegate
 */
- (TencentRequest*)requestWithParams:(NSMutableDictionary *)params
						 andDelegate:(id <TencentRequestDelegate>)delegate;

/*!
 @method     requestWithMethodName:andParams:andHttpMethod:andDelegate:
 @param      methodName methodName
 @param      params parames
 @param      httpMethod httpMethod
 @param      delegate delegate
 */
- (TencentRequest*)requestWithMethodName:(NSString *)methodName
							   andParams:(NSMutableDictionary *)params
						   andHttpMethod:(NSString *)httpMethod
							 andDelegate:(id <TencentRequestDelegate>)delegate;

/*!
 @method     requestWithGraphPath:andDelegate:
 @param      graphPath graphPath
 @param      delegate  delegate
 */
- (TencentRequest*)requestWithGraphPath:(NSString *)graphPath
							andDelegate:(id <TencentRequestDelegate>)delegate;

/*!
 @method     requestWithGraphPath:andParams:andDelegate:
 @param      graphPath graphPath
 @param      params params
 @param      delegate delegate
 */
- (TencentRequest*)requestWithGraphPath:(NSString *)graphPath
							  andParams:(NSMutableDictionary *)params
							andDelegate:(id <TencentRequestDelegate>)delegate;

/*!
 @method     requestWithGraphPath:andParams:andHttpMethod:andDelegate:
 @param      graphPath graphPath
 @param      params params
 @param      httpMethod httpMethod
 @param      delegate delegate
 */
- (TencentRequest*)requestWithGraphPath:(NSString *)graphPath
							  andParams:(NSMutableDictionary *)params
						  andHttpMethod:(NSString *)httpMethod
							andDelegate:(id <TencentRequestDelegate>)delegate;

/*!
 @method     isSessionValid
 */
- (BOOL)isSessionValid;

////////////////////////////////////////////////////////////////////////////////
//APIs, can be called after accesstoken and openid have received 

/**
 * Get user info.
 */
/*!
 @method     getUserInfo
 @discussion Get user info.
 */
- (BOOL)getUserInfo;

/**
 * Get List Album.
 */
/*!
 @method     getListAlbum
 @discussion    Get List Album.
 */
- (BOOL)getListAlbum;

/**
 * Get List  Photo
 */
/*!
 @method     getListPhotoWithParams:
 @discussion Get List  Photo
 @param      params params
 */
- (BOOL)getListPhotoWithParams:(NSMutableDictionary *)params;
/**
 * Add share.
 */
/*!
 @method     addShareWithParams:
 @discussion Add share.
 @param      params params
 */
- (BOOL)addShareWithParams:(NSMutableDictionary *)params;

/**
 * Upload picture.
 */
/*!
 @method     uploadPicWithParams:
 @discussion Upload picture.
 @param      params params
 */
- (BOOL)uploadPicWithParams:(NSMutableDictionary *)params;

/**
 * Add Album.
 */
/*!
 @method     addAlbumWithParams:
 @discussion Upload picture.
 @param      params params
 */
- (BOOL)addAlbumWithParams:(NSMutableDictionary *)params;
/**
 * Check Page Fans.
 */
/*!
 @method     checkPageFansWithParams:
 @discussion Check Page Fans.
 @param      params params
 */
- (BOOL)checkPageFansWithParams:(NSMutableDictionary *)params;


/**
 * Add One Blog.
 */
/*!
 @method     addOneBlogWithParams:
 @discussion Add One Blog.
 @param      params params
 */
- (BOOL)addOneBlogWithParams:(NSMutableDictionary *)params;

/**
 * Add topic.
 */
/*!
 @method     addTopicWithParams:
 @discussion Add topic
 @param      params params
 */
- (BOOL)addTopicWithParams:(NSMutableDictionary *)params;

@end

////////////////////////////////////////////////////////////////////////////////

/**
 * Your application should implement this delegate to receive session callbacks.
 */


@protocol TencentSessionDelegate <NSObject>

@optional

/**
 * Called when the user successfully logged in.
 */
/*!
 @method     tencentDidLogin
 @discussion Called when the user successfully logged in.
 */
- (void)tencentDidLogin;

/**
 * Called when the user dismissed the dialog without logging in.
 */
/*!
 @method     tencentDidNotLogin:
 @discussion Called when the user dismissed the dialog without logging in.
 @param      cancelled cancelled
 */
- (void)tencentDidNotLogin:(BOOL)cancelled;

/**
 * Called when the notNewWork.
 */
/*!
 @method     tencentDidNotNetWork
 @discussion Called when the notNewWork.
 */
- (void)tencentDidNotNetWork;

/**
 * Called when the user logged out.
 */
/*!
 @method     tencentDidLogout
 @discussion Called when the user logged out.
 */
- (void)tencentDidLogout;

/**
 * Called when the get_user_info has response.
 */
/*!
 @method     getUserInfoResponse:
 @discussion Called when the get_user_info has response.
 @param      response response
 */
- (void)getUserInfoResponse:(APIResponse*) response;

/**
 * Called when the get_list_album has response.
 */
/*!
 @method     getListAlbumResponse:
 @discussion Called when the get_list_album has response.
 @param      response response
 */
- (void)getListAlbumResponse:(APIResponse*) response;

/**
 * Called when the get_list_photo has response.
 */

/*!
 @method     getListPhotoResponse:
 @discussion Called when the get_list_photo has response.
 @param      response response
 */
- (void)getListPhotoResponse:(APIResponse*) response;

/**
 * Called when the check_page_fans has response.
 */
/*!
 @method     checkPageFansResponse:
 @discussion Called when the check_page_fans has response.
 @param      response response
 */
- (void)checkPageFansResponse:(APIResponse*) response;

/**
 
 /**
 * Called when the add_share has response.
 */
/*!
 @method     addShareResponse:
 @discussion Called when the add_share has response.
 @param      response response
 */
- (void)addShareResponse:(APIResponse*) response;

/**
 * Called when the add_album has response.
 */
/*!
 @method     addAlbumResponse:
 @discussion Called when the add_album has response.
 @param      response response
 */
- (void)addAlbumResponse:(APIResponse*) response;

/**
 * Called when the upload_pic has response.
 */
/*!
 @method     uploadPicResponse:
 @discussion Called when the upload_pic has response.
 @param      response response
 */
- (void)uploadPicResponse:(APIResponse*) response;

/**
 * Called when the add_one_blog has response.
 */
/*!
 @method     addOneBlogResponse:
 @discussion Called when the add_one_blog has response.
 @param      response response
 */
- (void)addOneBlogResponse:(APIResponse*) response;

/**
 * Called when the add_topic has response.
 */
/*!
 @method     addTopicResponse:
 @discussion Called when the add_topic has response.
 @param      response response
 */
- (void)addTopicResponse:(APIResponse*) response;


@end