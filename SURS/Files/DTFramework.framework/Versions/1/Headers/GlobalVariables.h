//
//  GlobalVariables.h
//  FrameworkClass
//
//  Created by Jolo Tupas on 1/30/14.
//  Copyright (c) 2014 Dev-Touch Information Systems. All rights reserved.
//

#ifndef FrameworkClass_GlobalVariables_h
#define FrameworkClass_GlobalVariables_h

/*!
 GlobalFunctions purpose type properties
 */
typedef NS_ENUM(NSInteger, Purpose) {
    
    PurposeTypeInformation,
    PurposeTypeWarning,
    PurposeTypeError,
    PurposeTypeQuestion,
    PurposeTypeLog,
};

#pragma mark DTDate

#define DTDateFormat (@"yyyy-MM-dd")
#define DTTimeFormat (@"HH:mm")

#endif
