/*
 * SQLHelper.m
 * SQLEd
 *
 * Created by Árpád Goretity on 27/08/2012.
 * Licensed under the 3-clause BSD license
 */


#include "SQLHelper.h"
#include "AppDelegate.h"

@implementation SQLHelper

-(id)init
{
    app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *file1 =[[NSString alloc]initWithString:app.strPath];
    
    if ((self = [super init])) {
        if (sqlite3_open([file1 UTF8String], &db) != 0) {
            
            return nil;
        }
    }
    return self;
            
}


- (id)initWithContentsOfFile:(NSString *)file
{
    
    app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *file1 =[[NSString alloc]initWithString:app.strPath];
    
        if ((self = [super init])) {
                if (sqlite3_open([file1 UTF8String], &db) != 0) {

                        return nil;
                }
        }
        return self;
}

- (void)dealloc
{
        sqlite3_close(db);

}






-(BOOL)deleteall:(NSString *)que
{
    BOOL resul = NO;
    sqlite3_stmt *stmt;
    
    
    if (sqlite3_prepare_v2(db, [que UTF8String], -1, &stmt, nil)==SQLITE_OK)
    {
        sqlite3_step(stmt);
        resul = YES;
    }
    sqlite3_finalize(stmt);
    
    return resul;
}

- (NSMutableDictionary *)executeQuery:(NSString *)query
{
        sqlite3_stmt *stmt;
        const char *tail;
        sqlite3_prepare_v2(db, [query UTF8String], -1, &stmt, &tail);
        if (stmt == NULL)
                return nil;

        int status;
        int num_cols;
        int i;
        int j;
        int type;
        id obj;
        NSString *key;
        NSMutableArray *result;
        NSMutableDictionary *row,*roww;
        j = 0;
        result = [NSMutableArray array];
      roww = [NSMutableDictionary dictionary];
        while ((status = sqlite3_step(stmt)) != SQLITE_DONE) {

                if (status != SQLITE_ROW)
                        continue;

                row = [NSMutableDictionary dictionary];
            
                num_cols = sqlite3_data_count(stmt);
                for (i = 0; i < num_cols-1; i++) {
                        obj = nil;
                        type = sqlite3_column_type(stmt, i);
                        switch (type) {
                        case SQLITE_INTEGER:
                                obj = [NSNumber numberWithLongLong:sqlite3_column_int64(stmt, i)];
                                break;
                        case SQLITE_FLOAT:
                                obj = [NSNumber numberWithDouble:sqlite3_column_double(stmt, i)];
                                break;
                        case SQLITE_TEXT:
                                obj = [NSString stringWithUTF8String:sqlite3_column_text(stmt, i)];
                                break;
                        case SQLITE_BLOB:
                                obj = [NSData dataWithBytes:sqlite3_column_blob(stmt, i)
                                	length:sqlite3_column_bytes(stmt, i)];
                                break;
                        case SQLITE_NULL:
                                obj = [NSNull null];
                                break;
                        default:
                                break;
                        }

                        key = [NSString stringWithUTF8String:sqlite3_column_name(stmt, i)];
                        [row setObject:obj forKey:key];
                }
            
            NSString *keyq = [NSString stringWithFormat:@"%d",j];
            [roww setObject:row forKey:keyq];
            j++;
        }
  
    [roww setValue:@"1" forKey:@"Success"];
   
    sqlite3_finalize(stmt);
    
   // NSLog(@"%@",roww);
    return roww;
}




-(BOOL)iud :(NSString *)que
{
    BOOL resul = NO;
    sqlite3_stmt *stmt;
   
    if (sqlite3_prepare_v2(db, [que UTF8String], -1, &stmt, nil)==SQLITE_OK)
    {
        sqlite3_step(stmt);
        resul = YES;
    }
    sqlite3_finalize(stmt);
    return resul;

}

- (NSMutableArray *)getFloderData:(NSString *)query
{
    sqlite3_stmt *stmt;
    const char *tail;
    sqlite3_prepare_v2(db, [query UTF8String], -1, &stmt, &tail);
    if (stmt == NULL)
        return nil;
  
    int status;
    int num_cols;
    int i;
    int type;
    id obj;
    NSString *key;
    NSMutableArray *result;
    NSMutableDictionary *row;
    NSMutableDictionary *smallRow;
    
    result = [NSMutableArray array];
    while ((status = sqlite3_step(stmt)) != SQLITE_DONE) {
        if (status != SQLITE_ROW)
            continue;
        smallRow = [NSMutableDictionary dictionary];
        row = [NSMutableDictionary dictionary];
        num_cols = sqlite3_data_count(stmt);
        for (i = 0; i < num_cols; i++) {
            obj = nil;
            type = sqlite3_column_type(stmt, i);
            switch (type) {
                case SQLITE_INTEGER:
                    obj = [NSNumber numberWithLongLong:sqlite3_column_int64(stmt, i)];
                    break;
                case SQLITE_FLOAT:
                    obj = [NSNumber numberWithDouble:sqlite3_column_double(stmt, i)];
                    break;
                case SQLITE_TEXT:
                    obj = [NSString stringWithUTF8String:sqlite3_column_text(stmt, i)];
                    break;
                case SQLITE_BLOB:
                    obj = [NSData dataWithBytes:sqlite3_column_blob(stmt, i)
                                         length:sqlite3_column_bytes(stmt, i)];
                    break;
                case SQLITE_NULL:
                    obj = [NSNull null];
                    break;
                default:
                    break;
            }
            key = [NSString stringWithUTF8String:sqlite3_column_name(stmt, i)];
            [row setObject:obj forKey:key];
        }
        
        [result addObject:row];
    }
    
    sqlite3_finalize(stmt);
    return result;
}


- (NSArray *)tables
{
        NSArray *descs = [self boardpost:@"SELECT tbl_name FROM sqlite_master WHERE type = 'table'"];
        NSMutableArray *result = [NSMutableArray array];
        for (NSDictionary *row in descs) {
                NSString *tblName = [row objectForKey:@"tbl_name"];
                [result addObject:tblName];
        }
        return result;
}

- (NSArray *)columnsInTable:(NSString *)table
{
        char *sql = sqlite3_mprintf("PRAGMA table_info(%q)", [table UTF8String]);
        NSString *query = [NSString stringWithUTF8String:sql];
        sqlite3_free(sql);
        return [self boardpost:query];
}





- (void)saveImage : (NSString *)bid : (NSString *)imgName
{
    sqlite3_stmt *compiledStmt;
  
        NSString *insertSQL=[NSString stringWithFormat:@"insert into img(bid,image)values('%@',?)",bid];
    
    
        if(sqlite3_prepare_v2(db,[insertSQL UTF8String], -1, &compiledStmt, NULL) == SQLITE_OK)
        {
            UIImage *image;
            
            if (imgName != nil)
            {
                if (imgName != [NSNull null]) {
                    
                
            NSURL *imgUrl =[[NSURL alloc]initWithString:imgName];
            NSData *dataa = [[NSData alloc]initWithContentsOfURL:imgUrl];
            image = [[UIImage alloc]initWithData:dataa];
                }
            }
            else
            {
                NSURL *imgUrl =[[NSURL alloc]initWithString:@"ic_launcher-1"];
                NSData *dataa = [[NSData alloc]initWithContentsOfURL:imgUrl];
                image = [[UIImage alloc]initWithData:dataa];
                
            }
            
            NSData *imageData=UIImagePNGRepresentation(image);
            sqlite3_bind_blob(compiledStmt, 1, [imageData bytes], [imageData length], NULL);
            
            sqlite3_step(compiledStmt);
            
            char *errMsg;
            sqlite3_exec(db, [insertSQL UTF8String], NULL,compiledStmt,&errMsg);
            
        
    }
}

- (UIImage *)showImage :(NSString *)bid
{
    UIImage *image;
    sqlite3_stmt *compiledStmt;
   
    NSString *insertSQL = [NSString stringWithFormat:@"Select image from img Where bid = %@",bid];
        sqlite3_prepare_v2(db,[insertSQL UTF8String], -1, &compiledStmt, NULL);
    
        if(sqlite3_prepare_v2(db,[insertSQL UTF8String], -1, &compiledStmt, NULL) == SQLITE_OK)
        {
            sqlite3_bind_int(compiledStmt, 1, 1);
            if(SQLITE_DONE != sqlite3_step(compiledStmt))
            {
                NSData *data = [[NSData alloc] initWithBytes:sqlite3_column_blob(compiledStmt, 1) length:sqlite3_column_bytes(compiledStmt, 1)];

                if(data == nil)
                     NSLog(@"No image found.");
                else
                {
                    image = [UIImage imageWithData:data];
                }
            }
            
        }
    return image;
    
}

@end
