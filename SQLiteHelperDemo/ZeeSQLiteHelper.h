//
//  ZeeSQLiteHelper.h
//  SQLiteHelperDemo
//
//  Created by Muhammad Zeeshan on 31/07/2013.
//  Copyright (c) 2013 Muhammad Zeeshan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DATABASENAME @"RecipeAppDB.sqlite"
#define DATABASEPATH [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:DATABASENAME]
#define DATABASEPATHFROMAPP [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DATABASENAME]
#define D TRUE
@interface ZeeSQLiteHelper : NSObject
{
    
}
+(BOOL)initializeSQLiteDB;
+(BOOL)executeQuery:(NSString *)query;
+(NSMutableArray *)readQueryFromDB:(NSString *)query;
+(NSMutableArray *)getAllColumnTitlesOfTable:(NSString *)tableName;
+(NSInteger)getTotalNumberOfRowsOfTable:(NSString *)tableName;
+(BOOL)closeDatabase;
@end
