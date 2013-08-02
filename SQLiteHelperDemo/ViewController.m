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
    
//    NSString *query = @"select * from recipes";
//    NSString *query = [NSString stringWithFormat:@"SELECT DISTINCT `key` FROM (SELECT SUBSTR(`title`, 1, 1) AS `key` FROM `recipes`WHERE `category_ids` LIKE '%%2,%%' OR `category_ids` LIKE '%%,2' ORDER BY `title` ASC ) AS `temp` GROUP BY `key`"];
    
//    NSString *query = @"SELECT * FROM recipes ORDER BY ROWID ASC LIMIT 1";
    
    
//    NSLog(@"%@",[ZeeSQLiteHelper readQueryFromDB:query]);
    
//    NSLog(@"%d",[ZeeSQLiteHelper getTotalNumberOfRowsOfTable:@"recipes"]);
    
    
//    NSLog(@"%@ column count: %d",[ZeeSQLiteHelper getAllColumnTitlesOfTable:@"recipes"],[[ZeeSQLiteHelper getAllColumnTitlesOfTable:@"recipes"] count]);
    
    
//    NSString *query = @"PRAGMA table_info(recipes)";
    
//    NSLog(@"schema %@",[ZeeSQLiteHelper readQueryFromDB:query]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
