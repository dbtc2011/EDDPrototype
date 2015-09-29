//
//  DTConnect.h
//  DevTouchFramework
//
//  Created by Jolo Tupas on 1/28/14.
//  Copyright (c) 2014 Dev-Touch Information System Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define filePath (@"filePath")
#define formName (@"formName")
#define linkPath (@"linkPath")

@protocol DTConnectDelegate;

@interface DTConnect : NSObject{
}

@property (assign) id delegate;
@property (retain, nonatomic) NSTimer *sendingTimer;
@property (strong, nonatomic) NSString *name;
@property (assign) BOOL timerOff;

@property (strong, nonatomic) NSMutableArray *arrayDataCollection;

- (void) startLossTimer;
- (void) stopLossTimer;

@property (nonatomic, strong) void (^connectionDidFinishLoadingBlock)(NSURLConnection *connection);
@property (nonatomic, strong) void (^connectionDidSendBodyDataBlock) (NSURLConnection *connection, NSInteger bytesWritten, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite);
@property (nonatomic, strong) void (^connectionDidReceiveDataBlock) (NSURLConnection *connection, NSData *data, NSString *file);
@property (nonatomic, strong) void (^connectionFailWithErrorBlock) (NSURLConnection *connection, NSError *error);
@property (nonatomic, strong) void (^connectionDidFinishUploadingMultipleDataBlock)(NSURLConnection *connection);

/*!
 Post values using a dictionary to a given URL.
 @param valuesDict object that will hold the value and name of the post.
 @param urlString object that will hold the URL on where the post will be sent.
 @return Returns an NSData value that contains server response.
 */
+ (NSData *)postPageUsingDictionary:(NSDictionary *)valuesDict
                       usingURLLink:(NSString *)urlString;
/*!
 Post values using a dictionary to a given URL.
 @param valuesDict object that will hold the value and name of the post.
 @param urlString object that will hold the URL on where the post will be sent.
 */
- (void)postPageUsingDictionary:(NSDictionary *)valuesDict
                   usingURLLink:(NSString *)urlString;
/*!
 Send data to server using multipart.
 @param pathString object that will hold the to be sent.
 @param urlString object that will hold the URL on where the file will be sent.
 */
- (void) sendDataWithPath:(NSString *)pathString withURL:(NSString*)urlString;
/*!
 Send data to server using multipart.
 @param pathString object that will hold the filepath to be sent.
 @param formString object that will hold the form name of the the multi part
 @param urlString object that will hold the URL on where the file will be sent.
 */
- (void) sendDataWithPath:(NSString *)pathString withFormName:(NSString *)formString forURL:(NSString*)urlString;
/*!
 Send multiple data to server using multipart.
 @param arrayDataCollection object that will hold the information of the files to send (filepath, formname, linkpath)
 e.g.  
    [dictionary setObject:file forKey:filePath];
    [dictionary setObject:url forKey:linkPath];
    [dictionary setObject:formname forKey:formName];
 */
- (void) sendMultipleData;
/*!
 Send multiple data to server using multipaty after posting values using a dictionary to a given URL.
 @param arrayDataCollection object that will hold the information of the files to send (filepath, formname, linkpath)
 e.g.
 [dictionary setObject:file forKey:filePath];
 [dictionary setObject:url forKey:linkPath];
 [dictionary setObject:formname forKey:formName];
 @param valuesDict object that will hold the value and name of the post.
 @param urlString object that will hold the URL on where the post will be sent.
*/
- (void)sendMultipleDataWithPostUsingDictionary: (NSDictionary *)valuesDict usingURLLink: (NSString *)urlString;

@end

@protocol DTConnectDelegate <NSObject>
@optional

- (void)DTConnection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite;
- (void)DTConnectionDidFinishLoading:(NSURLConnection *)connection;
- (void)DTConnection:(NSURLConnection *)connection didReceiveData:(NSData *)data withFile:(NSString *)file;
- (void)DTConnection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
- (void)DTConnectionDidFinishUploadingMultipleData:(NSURLConnection *)connection;
- (void)DTConnectionDidFailTimeout;

@end