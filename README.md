ZeeSQLiteHelper
===============

SQLite helper

Simple SQLite helper for performing general database tasks with few lines of code like fetching records from DB, Inserting, Updating and Deleting records.

Steps are:

1) Copy the ZeeSQLiteHelper class in your project.

2) Change the databse name in the ZeeSQLiteHelper class.

3) Import it in your class.

4) Open database by using the "initializeSQLiteDB" helper function like this [ZeeSQLiteHelper initializeSQLiteDB];

5) Setup your query string like this NSString *query = @"PRAGMA table_info(recipes)";

6) If you are fetching records than get results by calling "readQueryFromDB" helper function like this NSMutableArray *results = [ZeeSQLiteHelper readQueryFromDB:query];

7) If you are updating the DB than call this "executeQuery" helper function like this [ZeeSQLiteHelper executeQuery:query];

8) Close database by calling "closeDatabase" helper function [ZeeSQLiteHelper closeDatabase];

  In short all steps looks like this:
  
    [ZeeSQLiteHelper initializeSQLiteDB];
    
    NSString *query = @"SELECT * FROM recipes";
    
    NSMutableArray *results = [ZeeSQLiteHelper readQueryFromDB:query];
    
    [ZeeSQLiteHelper closeDatabase];

Note: libsqlite3.0.dylib is required.

If you want to turn off the success or failure logging on console than set the value of macro "D" to FALSE in ZeeSQLiteHelper class.

More features and updates to come.

Enjoy!
