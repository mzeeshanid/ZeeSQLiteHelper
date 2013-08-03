//
//  ViewController.m
//  SQLiteHelperDemo
//
//  Created by Muhammad Zeeshan on 31/07/2013.
//  Copyright (c) 2013 Muhammad Zeeshan. All rights reserved.
//

#import "ViewController.h"
#import "ZeeSQLiteHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [ZeeSQLiteHelper initializeSQLiteDB];
    queryResults = [[NSString alloc] init];
    [self getTableInformation];
    [self getAllColumnTitles];
    [self getRowCountOfTable];
    [self getAllRecordsFromTable];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getTableInformation
{
    NSString *query = @"PRAGMA table_info(recipes)";
    [ZeeSQLiteHelper initializeSQLiteDB];
    NSMutableArray *results = [ZeeSQLiteHelper readQueryFromDB:query];
    [ZeeSQLiteHelper closeDatabase];
    
    queryResults = [queryResults stringByAppendingFormat:@"***TABLE INFROMATION***\n%@\n*** ***\n",results];

//    NSLog(@"TableInformation:%@",results);
}
-(void)getAllColumnTitles
{
    [ZeeSQLiteHelper initializeSQLiteDB];
    NSMutableArray *results = [ZeeSQLiteHelper getAllColumnTitlesOfTable:@"recipes"];
    [ZeeSQLiteHelper closeDatabase];
    
    queryResults = [queryResults stringByAppendingFormat:@"***COLUMN TITLES***\n%@\n*** ***\n",results];
    
//    NSLog(@"Column titles:%@",results);
}
-(void)getRowCountOfTable
{
    [ZeeSQLiteHelper initializeSQLiteDB];
    NSInteger results = [ZeeSQLiteHelper getTotalNumberOfRowsOfTable:@"recipes"];
    [ZeeSQLiteHelper closeDatabase];
    
    queryResults = [queryResults stringByAppendingFormat:@"***ROW COUNT***\n%d\n*** ***\n",results];
    NSLog(@"Row count:%d",results);
}
-(void)getAllRecordsFromTable
{
    NSString *query = @"SELECT * FROM recipes";
    [ZeeSQLiteHelper initializeSQLiteDB];
    NSMutableArray *results = [ZeeSQLiteHelper readQueryFromDB:query];
    [ZeeSQLiteHelper closeDatabase];
    
    queryResults = [queryResults stringByAppendingFormat:@"***ALL RECORDS***\n%@\n*** ***\n",results];
    
    [txtView setText:queryResults];
    
//    NSLog(@"allRecords: %@",results);
}
@end
