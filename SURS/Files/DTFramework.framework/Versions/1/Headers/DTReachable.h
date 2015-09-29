//
//  DTReachable.h
//  FTPMananger
//
//  Created by DT-MM-MikelDin on 2/14/13.
//  Copyright (c) 2013 Dev-Touch Information Systems. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DTReachable : NSObject

/*!
 Checks WIFI and 3G availablity. Returns NO if connectivity is non existent.
 @return Returns status of connectivity. YES = can connect : NO = cannot connect.
 */
+ (BOOL)canConnect;

/*!
 Returns BOOL value for reachablity status of given host.
 @param host set the host to test reachability.
 @return Returns status of connectivity. YES = can connect : NO = cannot connect.
 */
+ (BOOL)canConnectToHost:(NSString *)host;
@end
