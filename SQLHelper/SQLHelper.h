/*
 * SQLHelper.h
 * SQLEd
 *
 * Created by Árpád Goretity on 27/08/2012.
 * Licensed under the 3-clause BSD license
 */

#include <sqlite3.h>
#import "AppDelegate.h"
#include <Foundation/Foundation.h>

@interface SQLHelper: NSObject {
        sqlite3 *db;
    AppDelegate *app;
    NSString *strPath;
}

- (id)initWithContentsOfFile:(NSString *)file;
- (NSMutableDictionary *)executeQuery:(NSString *)query;
- (NSArray *)tables;
- (NSArray *)columnsInTable:(NSString *)table;
- (NSMutableArray *)boardpost:(NSString *)query;
- (void)saveImage : (NSString *)bid : (NSString *)imgName;
- (UIImage *)showImage :(NSString *)bid;


-(BOOL)iud :(NSString *)que;
-(BOOL)deleteall:(NSString *)que;

@end
