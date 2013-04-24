//
//  TencentLoginView.h
//  TencentOAuthDemo
//
//  Created by cloudxu on 11-8-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

/*!
 @header TencentLoginView
 @discussion 登录页
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*!
 @protocol       TencentLoginViewDelegate;
 @discussion  TencentLoginViewDelegate
 */
@protocol TencentLoginViewDelegate;

/**
 * Do not use this interface directly, instead, use authorize in  TencentOAuth.h
 *
 */


/*!
 @class       TencentLoginView 
 @superclass  UIView <UIWebViewDelegate> { id<TencentLoginViewDelegate> _delegate; NSMutableDictionary *_params; NSString * _serverURL; NSURL* _loadingURL; UIWebView* _webView; UIActivityIndicatorView* _spinner; UILabel* _titleLabel; UIButton* _closeButton; UIDeviceOrientation _orientation; BOOL _showingKeyboard; }
 
 */
@interface TencentLoginView : UIView <UIWebViewDelegate> {
	id<TencentLoginViewDelegate> _delegate;
	NSMutableDictionary *_params;
	NSString * _serverURL;
	NSURL* _loadingURL;
	UIWebView* _webView;
	UIActivityIndicatorView* _spinner;
	UILabel* _titleLabel;
	UIButton* _closeButton;
	UIDeviceOrientation _orientation;
	BOOL _showingKeyboard;
}

/**
 * The delegate.
 */


@property(nonatomic,assign) id<TencentLoginViewDelegate> delegate;

/**
 * The parameters.
 */
@property(nonatomic, retain) NSMutableDictionary* params;

/**
 * The title that is shown in the header atop the view.
 */
@property(nonatomic,copy) NSString* title;

/*!
 @method     getStringFromUrl:needle:
 @param      url url
 @param      needle needle
 @result     NSString
 */
- (NSString *) getStringFromUrl: (NSString*) url needle:(NSString *) needle;

/*!
 @method     initWithURL:params:delegate:
 @param      serverURL serverURL
 @param      params params
 @param      delegate delegate
 @result     id
 */
- (id)initWithURL: (NSString *) serverURL
           params: (NSMutableDictionary *) params
         delegate: (id <TencentLoginViewDelegate>) delegate;

/**
 * Displays the view with an animation.
 *
 * The view will be added to the top of the current key window.
 */

/*!
 @method     show
 @abstract   Displays the view with an animation.
 @discussion The view will be added to the top of the current key window.
 */
- (void)show;

/**
 * Displays the first page of the dialog.
 *
 * Do not ever call this directly.  It is intended to be overriden by subclasses.
 */

/*!
 @method     load
 @abstract   Displays the first page of the dialog.
 @discussion Do not ever call this directly.  It is intended to be overriden by subclasses.
 
 */
- (void)load;

/**
 * Displays a URL in the dialog.
 */
/*!
 @method     loadURL:get:
 @discussion Displays a URL in the dialog.
 @param      url url
 @param      getParams params
 */
- (void)loadURL:(NSString*)url
            get:(NSDictionary*)getParams;

/**
 * Hides the view and notifies delegates of success or cancellation.
 */
/*!
 @method     dismissWithSuccess:animated:
 @discussion Hides the view and notifies delegates of success or cancellation.
 @param      success success
 @param      animated animated
 */
- (void)dismissWithSuccess:(BOOL)success animated:(BOOL)animated;

/**
 * Hides the view and notifies delegates of an error.
 */
/*!
 @method     dismissWithError:animated:
 @discussion   Hides the view and notifies delegates of an error.
 @param      error error
 @param      animated animated
 */
- (void)dismissWithError:(NSError*)error animated:(BOOL)animated;

/**
 * Subclasses may override to perform actions just prior to showing the dialog.
 */
/*!
 @method     dialogWillAppear
 @discussion Subclasses may override to perform actions just prior to showing the dialog.
 */
- (void)dialogWillAppear;

/**
 * Subclasses may override to perform actions just after the dialog is hidden.
 */
/*!
 @method     dialogWillDisappear
 @discussion Subclasses may override to perform actions just after the dialog is hidden.
 */
- (void)dialogWillDisappear;

/**
 * Subclasses should override to process data returned from the server in a 'connect' url.
 *
 * Implementations must call dismissWithSuccess:YES at some point to hide the dialog.
 */
/*!
 @method     dialogDidSucceed:
 @abstract   Subclasses should override to process data returned from the server in a 'connect' url.
 @discussion Implementations must call dismissWithSuccess:YES at some point to hide the dialog.
 @param      url url
 */
- (void)dialogDidSucceed:(NSURL *)url;

/**
 * Subclasses should override to process data returned from the server in a 'connect' url.
 *
 * Implementations must call dismissWithSuccess:YES at some point to hide the dialog.
 */
/*!
 @method     dialogDidCancel:
 @abstract   Subclasses should override to process data returned from the server in a 'connect' url.
 @discussion Implementations must call dismissWithSuccess:YES at some point to hide the dialog.
 @param      url url
 */
- (void)dialogDidCancel:(NSURL *)url;
@end

///////////////////////////////////////////////////////////////////////////////////////////////////

/*
 *Your application should implement this delegate
 */
/*!
 @protocol       TencentLoginViewDelegate <NSObject>
 @discussion  Your application should implement this delegate
 */
@protocol TencentLoginViewDelegate <NSObject>

@optional

/**
 * Called when the dialog succeeds and is about to be dismissed.
 */
/*!
 @method     dialogDidComplete:
 @discussion Called when the dialog succeeds and is about to be dismissed.
 @param      dialog dialog
 */
- (void)dialogDidComplete:(TencentLoginView *)dialog;

/**
 * Called when the dialog succeeds with a returning url.
 */
/*!
 @method     dialogCompleteWithUrl:
 @discussion  Called when the dialog succeeds with a returning url.
 @param      url url
 */
- (void)dialogCompleteWithUrl:(NSURL *)url;

/**
 * Called when the dialog get canceled by the user.
 */
/*!
 @method     dialogDidNotCompleteWithUrl:
 @discussion  Called when the dialog get canceled by the user.
 @param      url url
 */
- (void)dialogDidNotCompleteWithUrl:(NSURL *)url;

/**
 * Called when the dialog is cancelled and is about to be dismissed.
 */
/*!
 @method     dialogDidNotComplete:
 @discussion   Called when the dialog is cancelled and is about to be dismissed.
 @param      dialog dialog
 */
- (void)dialogDidNotComplete:(TencentLoginView *)dialog;

/**
 * Called when dialog failed to load due to an error.
 */
/*!
 @method     dialog:didFailWithError:
 @discussion   Called when dialog failed to load due to an error.
 @param      dialog dialog
 @param      error error
 */
- (void)dialog:(TencentLoginView*)dialog didFailWithError:(NSError *)error;

/**
 * Called when the token is received.
 */
/*!
 @method     tencentDialogLogin:expirationDate:
 @discussion   Called when the token is received.
 @param      token token
 @param      expirationDate expirationDate
 */
- (void)tencentDialogLogin:(NSString*)token expirationDate:(NSDate*)expirationDate;

/*!
 @method     tencentDialogNotLogin:    @param      cancelled cancelled
 */
- (void)tencentDialogNotLogin:(BOOL)cancelled;

@end
