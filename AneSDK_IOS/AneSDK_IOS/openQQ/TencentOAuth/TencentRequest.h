

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol TencentRequestDelegate;

/**
 * Do not use this interface directly, instead, use method in TencentOAuth.h
 */



/*!
 @class       TencentRequest 
 @superclass  NSObject { id<TencentRequestDelegate> _delegate; NSString* _url; NSString* _httpMethod; NSMutableDictionary* _params; NSURLConnection* _connection; NSMutableData* _responseText; }
 
 */
@interface TencentRequest : NSObject {
	id<TencentRequestDelegate> _delegate;
	NSString*             _url;
	NSString*             _httpMethod;
	NSMutableDictionary*  _params;
	NSURLConnection*      _connection;
	NSMutableData*        _responseText;
}


@property(nonatomic,assign) id<TencentRequestDelegate> delegate;

/**
 * The URL which will be contacted to execute the request.
 */
@property(nonatomic,copy) NSString* url;

/**
 * The API method which will be called.
 */
@property(nonatomic,copy) NSString* httpMethod;

/**
 * The dictionary of parameters to pass to the method.
 *
 * These values in the dictionary will be converted to strings using the
 * standard Objective-C object-to-string conversion facilities.
 */
@property(nonatomic,retain) NSMutableDictionary* params;
@property(nonatomic,assign) NSURLConnection*  connection;
@property(nonatomic,assign) NSMutableData* responseText;


/*!
 @method     serializeURL:params:
 @param      baseUrl baseUrl
 @param      params params
 */
+ (NSString*)serializeURL:(NSString *)baseUrl
                   params:(NSDictionary *)params;

/*!
 @method     serializeURL:params:httpMethod:
 @param      baseUrl baseUrl
 @param      params params
 @param      httpMethod httpMethod
 */
+ (NSString*)serializeURL:(NSString *)baseUrl
                   params:(NSDictionary *)params
               httpMethod:(NSString *)httpMethod;


/*!
 @method     getRequestWithParams:httpMethod:delegate:requestURL:
 @param      params params
 @param      httpMethod httpMethod
 @param      delegate delegate
 @param      url url
 */
+ (TencentRequest*)getRequestWithParams:(NSMutableDictionary *) params
							 httpMethod:(NSString *) httpMethod
							   delegate:(id<TencentRequestDelegate>)delegate
							 requestURL:(NSString *) url;
/*!
 @method      loading
 */
- (BOOL) loading;

/*!
 @method      connect
 */
- (void) connect;

@end

////////////////////////////////////////////////////////////////////////////////

/*
 *Your application should implement this delegate
 */
@protocol TencentRequestDelegate <NSObject>

@optional

/**
 * Called just before the request is sent to the server.
 */
/*!
 @method     requestLoading:
 @discussion Called just before the request is sent to the server.
 @param      request request
 */
- (void)requestLoading:(TencentRequest *)request;

/**
 * Called when the server responds and begins to send back data.
 */
/*!
 @method     request:didReceiveResponse:
 @discussion Called when the server responds and begins to send back data.
 @param      request request
 @param      response response
 */
- (void)request:(TencentRequest *)request didReceiveResponse:(NSURLResponse *)response;

/**
 * Called when an error prevents the request from completing successfully.
 */
/*!
 @method     request:didFailWithError:
 @discussion Called when an error prevents the request from completing successfully.
 @param      request request
 @param      error error
 */
- (void)request:(TencentRequest *)request didFailWithError:(NSError *)error;

/**
 * Called when a request returns and its response has been parsed into
 * an object.
 *
 * The resulting object may be a dictionary, an array, a string, or a number,
 * depending on thee format of the API response.
 */
/*!
 @method     request:didLoad:dat:
 @abstract    Called when a request returns and its response has been parsed into an object.
 @discussion   The resulting object may be a dictionary, an array, a string, or a number,depending on thee format of the API response.
 @param      request request
 @param      result result
 @param      data data
 */
- (void)request:(TencentRequest *)request didLoad:(id)result dat:(NSData *)data;

/**
 * Called when a request returns a response.
 *
 * The result object is the raw response from the server of type NSData
 */
/*!
 @method     request:didLoadRawResponse:
 @abstract   Called when a request returns a response.
 @discussion The result object is the raw response from the server of type NSData
 @param      request request
 @param      data data
 */
- (void)request:(TencentRequest *)request didLoadRawResponse:(NSData *)data;

@end


