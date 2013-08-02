//
//  ZeeSQLiteHelper.m
//  SQLiteHelperDemo
//
//  Created by Muhammad Zeeshan on 31/07/2013.
//  Copyright (c) 2013 Muhammad Zeeshan. All rights reserved.
//

#import "ZeeSQLiteHelper.h"
#import <sqlite3.h>

@implementation ZeeSQLiteHelper
static sqlite3 *database;
+(BOOL)initializeSQLiteDB
{
	if(D) NSLog(@"DB path %@",DATABASEPATH);
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
	if(![fileManager fileExistsAtPath:DATABASEPATH])
		[fileManager copyItemAtPath:DATABASEPATHFROMAPP toPath:DATABASEPATH error:&error];
    if(error)
    {
        if(D) NSLog(@"Error: %@",[error localizedDescription]);
        return FALSE;
    }
    
    if(sqlite3_open([DATABASEPATH UTF8String],&database) == SQLITE_OK)
    {
        if(D) NSLog(@"DB initialized successfully");
        return TRUE;
    }
    else
    {
        if(D) NSLog(@"Error: %s",sqlite3_errmsg(database));
        return FALSE;
    }
}
+(BOOL)executeQuery:(NSString *)query
{
    if(sqlite3_exec(database, [query UTF8String], NULL, NULL, NULL) == SQLITE_OK)
    {
        if(D) NSLog(@"Success: Query executed successfully");
        return TRUE;
    }
    else
    {
        if(D) NSLog(@"Error: %s",sqlite3_errmsg(database));
        return FALSE;
    }
}
+(NSMutableArray *)readQueryFromDB:(NSString *)query
{
    NSMutableArray *resultOfQuery = [[NSMutableArray alloc] init];
    
    sqlite3_stmt *compiledStatement;
    if(sqlite3_prepare(database, [query UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK)
    {
        while (sqlite3_step(compiledStatement) == SQLITE_ROW)
        {
            NSMutableDictionary *resultDict = [[NSMutableDictionary alloc] init];
            int noOfColumns = sqlite3_column_count(compiledStatement);
            for(int n=0;n<noOfColumns;n++)
            {   
                NSString *columnName = [NSString stringWithUTF8String:(char *)sqlite3_column_name(compiledStatement, n)];
                NSString *columnText;
                if((char *)sqlite3_column_text(compiledStatement, n))
                    columnText = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, n)];
                else
                    columnText = [NSString stringWithFormat:@"%@",[NSNull null]];
                [resultDict setObject:columnText forKey:columnName];
            }
            [resultOfQuery addObject:resultDict];
        }
        if(D) NSLog(@"Success: Query executed successfully");
    }
    else
    {
        if(D) NSLog(@"Error: %s",sqlite3_errmsg(database));
    }
    sqlite3_finalize(compiledStatement);
    
	return resultOfQuery;
}
+(NSMutableArray *)getAllColumnTitlesOfTable:(NSString *)tableName
{
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY ROWID ASC LIMIT 1",tableName];
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    
    sqlite3_stmt *compiledStatement;
    if(sqlite3_prepare(database, [query UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK)
    {
        int noOfColumns = sqlite3_column_count(compiledStatement);
        for(int n=0;n<noOfColumns;n++)
        {
            NSString *columnName = [NSString stringWithUTF8String:(char *)sqlite3_column_name(compiledStatement, n)];
            [resultArray addObject:columnName];
        }
        if(D) NSLog(@"Success: Query executed successfully");
    }
    else
    {
        if(D) NSLog(@"Error: %s",sqlite3_errmsg(database));
    }
    sqlite3_finalize(compiledStatement);
    
    return resultArray;
}
+(NSInteger)getTotalNumberOfRowsOfTable:(NSString *)tableName
{
    NSString *query = [NSString stringWithFormat:@"SELECT count() as rowCount FROM %@",tableName];
    NSMutableArray *resultArray = [self readQueryFromDB:query];
    
    if(resultArray.count > 0)
        return [[[resultArray objectAtIndex:0] objectForKey:@"rowCount"] integerValue];
    else
        return 0;
}
+(BOOL)closeDatabase;
{
    if(sqlite3_close(database) == SQLITE_OK)
    {
        if(D) NSLog(@"Success: Database closed successfully");
        return TRUE;
    }
    else
    {
        if(D) NSLog(@"Error: %s",sqlite3_errmsg(database));
        return FALSE;
    }
}
@end
