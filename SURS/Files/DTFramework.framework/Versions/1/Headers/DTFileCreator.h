//
//  DTFileCreator.h
//  FrameworkClass
//
//  Created by Jolo Tupas on 2/7/14.
//  Copyright (c) 2014 Dev-Touch Information Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZipArchive.h"

@interface DTFileCreator : NSObject

/*!
 Inititalizes and allocates the class.
 @return Returns the class instance.
 */
+ (id)init;
/*!
 Creates folder in the designated path
 @param folderPath object that containts the path folder that will be created
 */
+ (void)createFileFolderDir:(NSString *)folderPath;
/*!
 Method to return the application document path.
 @return return the application document path.
 */
+ (NSString *)getDocumentPath;

@end

@interface DTFileCreator (DTTextFile)
/*!
 Creates text file from string into a designated path
 @param stringFile object that will hold the content of the text file
 @param stringLocation object that will hold the path including the desired filename of the text file
 @return returns a boolean if the text file is successfully created
 */
+ (BOOL) createTextFileFor:(NSString *)stringFile
                inLocation:(NSString *)stringLocation;

@end

@interface DTFileCreator (DTZip)
/*!
 Creates a zip file from the designated folder
 @param folder object that will hold the path of the folder to be zipped
 @param directory object that will hold the path where the zip will be created
 @param filename object that will hold the filename of the zip file (NOTE: the filename should not include the file extension)
 */
+ (void)zipFolder:(NSString *)folder
    toDestination:(NSString *)directory
     withFileName:(NSString *) filename;

@end


