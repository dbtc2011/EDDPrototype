//
//  DTDatabase.h
//  FrameworkClass
//
//  Created by Jolo Tupas on 2/4/14.
//  Copyright (c) 2014 Dev-Touch Information Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMResultSet.h"

#define kFMDBPath (@"database.sqlite")
#define kMultipleDBPath (@"databases")

enum OPERATOR_TYPE {
    OPERATOR_AND = 1,
    OPERATOR_OR = 2
};

enum ORDER_BY{
    ORDER_ASCENDING = 1,
    ORDER_DESCENDING = 2
};

@interface DTDatabase : NSObject
/*!
 Method to rcopy database to the document
 @param database object that will hold the name of the database
 @param object that will hold the the location path of the databse
 @return return a boleann for the status of the copy.
 */
+ (BOOL)copyDatabase:(NSString *)database
              toPath:(NSString *)dbPath;
/*!
 Method to copy multiple database to the document
 @param databaseArr object that will hold the array of the database
 @param object that will hold the the location path of the databse
 @return return a boleann for the status of the copy.
 */
+ (BOOL)copyMultipleDatabase:(NSArray *)databaseArr
                      toPath:(NSString *)dbPath;
/*!
 Method to return the database path.
 @return return the database path.
 */
+ (NSString *)getDatabasePath;
/*!
 Method to set the current database to be used (use this when copying multiple database only).
 @param database object that will hold the database to be used
 @return return a bolean if the database is valid.
 */
+ (BOOL) setDatabaseName:(NSString *)database;
/*!
 Method to add a new database to be used .
 @param databaseName object that will hold the database to be added
 */
+ (void) addNewDatabaseInUserDefaults:(NSString *)databaseName;
/*!
 Method to return the application document path.
 @return return the application document path.
 */
+ (NSString *)getDocumentPath;

@end

@interface DTDatabase (DTDBSelect)

/*!
 Select all from table with condition and desired operator.
 @param table specify the table name on where to querry.
 @param dict insert objects to be constructed as condition clause. ex.[dict setObject:@"item" forKey:@"column_name"];
 @param op specify the operater based in the enumarated choices (OPERATOR_TYPE ; default is AND operator)
 @return returns an array that contains the result of the querry.
 */
+ (NSArray *)selectFromTable:(NSString *)table
               withCondition:(NSDictionary *)dict
                withOperator:(NSInteger)op;
/*!
 Select specified columns from table with condition and desired operator.
 @param arrColumns specify the columns name to be retreived.
 @param table specify the table name on where to querry.
 @param dict insert objects to be constructed as condition clause. ex.[dict setObject:@"item" forKey:@"column_name"];
 @param op specify the operater based in the enumarated choices (OPERATOR_TYPE ; default is AND operator)
 @return returns an array that contains the result of the querry.
 */
+ (NSArray *)selectColumn:(NSArray *)arrColumns
                fromTable:(NSString *)table
            withCondition:(NSDictionary *)dict
             withOperator:(NSInteger)op;
/*!
 Enumerate distinct columns from table with condition and desired operator.
 @param arrColumns specify the columns name to be retreived.
 @param table specify the table name on where to querry.
 @param dict insert objects to be constructed as condition clause. ex.[dict setObject:@"item" forKey:@"column_name"];
 @param op specify the operater based in the enumarated choices (OPERATOR_BY ; default is AND operator)
 @return returns an array that contains the result of the querry.
 */
+ (NSArray *)selectDistinctColumn:(NSArray *)arrColumns
                        fromTable:(NSString *)table
                    withCondition:(NSDictionary *)dict
                     withOperator:(NSInteger)op;
/*!
 Select specified columns from table with condition, desired operator and order.
 @param arrColumns specify the columns name to be retreived.
 @param table specify the table name on where to querry.
 @param dict insert objects to be constructed as condition clause. ex.[dict setObject:@"item" forKey:@"column_name"];
 @param op specify the operater based in the enumarated choices (OPERATOR_TYPE ; default is AND operator)
 @param order specify the order based in the enumarated choices (ORDER_BY ; default is ASCENDING order)
 @return returns an array that contains the result of the querry.
 */
+ (NSArray *)selectOrderByColumn:(NSArray *)arrColumns
                       fromTable:(NSString *)table
                   withCondition:(NSDictionary *)dict
                    withOperator:(NSInteger)op
                       withOrder:(NSInteger)order;

@end

@interface DTDatabase (DTDBInsert)

/*!
 Insert data to the table indicated
 @param table specify the table name on where to insert.
 @param dictionary specify the object to be inserted. ex.[dict setObject:@"item" forKey:@"column_name"];
 @return returns an boolean of the action.
 */
+ (BOOL)insertRecordInTable:(NSString *)table
               withContents:(NSDictionary *)dictionary;

/*!
 Insert multiple data with the given query
 @param query which will be executed
 @return returns an boolean of the action.
 */
+ (BOOL)insertMultipeRecordsWithQuery:(NSString *)query;

@end

@interface DTDatabase (DTDBUpdate)

/*!
 Update data to the table indicated
 @param table specify the table name on where to update.
 @param dictContents specify the object to be inserted. ex.[dict setObject:@"item" forKey:@"column_name"];
 @param dictCondition insert objects to be constructed as condition clause. ex.[dict setObject:@"item" forKey:@"column_name"];
 @return returns an boolean of the action.
 */
+ (BOOL) updateRecordInTable:(NSString *)table
                withContents:(NSDictionary *)dictContents
               withCondition:(NSDictionary *)dictCondition;

@end

@interface DTDatabase (DTDBDelete)

/*!
 Delete specific column in the table indicated
 @param table specify the table name on where to delete.
 @param dictionary insert objects to be constructed as condition clause. ex.[dict setObject:@"item" forKey:@"column_name"];
 @return returns an boolean of the action.
 */
+ (BOOL) deleteRecordInTable:(NSString *)table
               withCondition:(NSDictionary *)dictionary;
/*!
 Delete all column in the table indicated
 @param table specify the table name on where to delete.
 @return returns an boolean of the action.
 */
+ (BOOL) deleteAllDataInTable:(NSString *)table;

@end

@interface DTDatabase (DTDBFunctions)
/*!
 Run queue based on user input
 @param sql object that will hold yung sql queue
 @param table specify the table name on where to retreive.
 @return returns an array of the action.
 */
+ (NSArray *) returnArrayForQueue:(NSString *)sql
                         forTable:(NSString *)table;
/*!
 Run queue based on user input
 @param sql object that will hold yung sql queue
 @param table specify the table name on where to retreive.
 @param arrayColumns specify the columns to get
 @return returns an array of the action.
 */
+ (NSArray *) returnArrayForQueue:(NSString *)sql
                         forTable:(NSString *)table
                       getColumns:(NSArray*)arrayColumns;

@end
