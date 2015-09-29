//
//  DTDate.h
//  FrameworkClass
//
//  Created by Jolo Tupas on 1/30/14.
//  Copyright (c) 2014 Dev-Touch Information Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalVariables.h"

@interface DTDate : NSObject


/*!
 Return current date with default date format in the global variable
 @retun returns current date
 */
+ (NSString *) currentDate;
/*!
 Return current time with default date format in the global variable
 @retun returns current time
 */
+ (NSString *) currentTime;
/*!
 Return current date with desired date format
 @param stringDateFormat object that will hold the desired date format
 @return returns current date with the desired format
 */
+ (NSString *) currentDateWithFormat:(NSString *)stringDateFormat;
/*!
 Return current date with desired date format
 @param timezone object that will hold the desired timezone
 @return returns current date with the desired format
 */
+ (NSString *) currentDateFromTimeZone:(NSString *)timezone;
/*!
 Return date from date count inserted
 Date Format is based on the global variable
 @param dateCount object that will hold the count of days
 @return returns the date after calculating the jump
 */
+ (NSString *) jumpCurrentDateToNumberOfDays:(NSInteger)dateCount;
/*!
 Return date from date count inserted
 @param dateCount object that will hold the count of days
 @param stringDateFormat object that will hold the desired date format
 @return returns the date after calculating the jump with desired format
 */
+ (NSString *) jumpCurrentDateToNumberOfDays:(NSInteger)dateCount
                                  withFormat:(NSString*)stringDateFormat;
/*!
 Return string date into NSDate
 Date Format is based on the global variable
 @param dateString object that will hold the date string
 @return returns date converted from the date string
 */
+ (NSDate *) convertStringDate:(NSString *)dateString;
/*!
 Return days count from the paramater
 @param firstDate object that will hold the base date
 @param secondDate object that will hold the jumped date
 @return returns the difference of the two dates
 */
+ (NSInteger) countNumberOfDaysBetween:(NSDate *)firstDate
                                   and:(NSDate *)secondDate;
+ (NSString *) currentDateFromNSDate:(NSDate *)date;
/*!
 Convert indicated date to its Gregorian equivalent
 @param datePassed the date that will be converted
 @return returns the converted date in Gregorian
*/
- (NSString *)convertDateToGregorianEquivalent: (NSDate *)datePassed;

@end
