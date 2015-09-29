//
//  DTParser.h
//  FrameworkClass
//
//  Created by Jolo Tupas on 2/3/14.
//  Copyright (c) 2014 Dev-Touch Information Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTParser : NSObject

/*!
 Return converted data response into string
 @param data object that will hold the data to be converted
 @retun returns the string equivalent of the data
 */
+ (NSString *)convertDataResponseToString:(NSData *)data;
/*!
 Method for deserializing a JSON string.
 @param jsonStr object that contains a valid json value.
 @return returns an id(NSDictionary) that contains the deserialized contents of the json.
 */
+ (id)parseJSONString:(NSString *)jsonStr;

/*!
 Method for deserializing a JSON data.
 @param jsonData object that contains a valid json value.
 @return returns an id(NSDictionary) that contains the deserialized contents of the json.
 */
+ (id)parseJSONData:(NSData *)jsonData;

@end
