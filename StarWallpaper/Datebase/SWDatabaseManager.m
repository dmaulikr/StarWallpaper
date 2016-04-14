//
//  SWDatabaseManager.m
//  StarWallpaper
//
//  Created by Fnoz on 16/4/11.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import "SWDatabaseManager.h"
#import "FMDatabase.h"
#import <pthread.h>
#import "SWCommonUtil.h"
#import "SWImageItemDO.h"

pthread_mutex_t db_mutex = PTHREAD_MUTEX_INITIALIZER;

@interface SWDatabaseManager ()
{
    FMDatabase *db;
}
@end

@implementation SWDatabaseManager

static SWDatabaseManager *sharedSqlite = nil;

+ (SWDatabaseManager *)sharedFMDBSqlite
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSqlite = [[SWDatabaseManager alloc] initWithObj];
    });
    
    return sharedSqlite;
}

- (id)initWithObj
{
    self = [super init];
    if (self)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex: 0];
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent: @"SWLikeList.sqlite"];
        db = [[FMDatabase alloc] initWithPath:dbPath];
        if (![self openDb:db])
        {
            return nil;
        }
        [db setShouldCacheStatements:YES];
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS sw_image_like_list(`imageUrlString` varchar(128));"];
        [self closeDb:db];
    }
    return self;
}

- (BOOL)openDb:(FMDatabase *)database
{
    pthread_mutex_lock(&db_mutex);
    return [database open];
}

- (BOOL)closeDb:(FMDatabase *)database
{
    BOOL result = [database close];
    pthread_mutex_unlock(&db_mutex);
    
    return result;
}

- (void)insertImageUrlString:(NSString *)imageUrlString
{
    NSLog(@"Do Like:\n%@", imageUrlString);
    if (![self openDb:db])
    {
        return;
    }
    
    [db setShouldCacheStatements:YES];
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM sw_image_like_list where `imageUrlString` = ?", imageUrlString];
    if (![rs next])
    {
        [db executeUpdate:@"INSERT INTO sw_image_like_list(`imageUrlString`) VALUES (?)", imageUrlString];
    }
    [self closeDb:db];
}

- (void)deleteImageUrlString:(NSString *)imageUrlString
{
    if (![self openDb:db])
    {
        return;
    }
    [db setShouldCacheStatements:YES];
    [db executeUpdate:@"DELETE FROM sw_image_like_list WHERE `imageUrlString` = ?", imageUrlString];
    [self closeDb:db];
}

- (BOOL)imageUrlStringHasInDB:(NSString *)imageUrlString
{
    if (![self openDb:db])
    {
        return NO;
    }
    [db setShouldCacheStatements:YES];
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM sw_image_like_list WHERE `imageUrlString` = ?", imageUrlString];
    if ([rs next])
    {
        [self closeDb:db];
        return YES;
    }
    else
    {
        [self closeDb:db];
        return NO;
    }
}

- (NSArray *)getLikeList
{
    NSMutableArray *infoArray = [[NSMutableArray alloc] init];
    if (![self openDb:db])
    {
        return nil;
    }
    
    [db setShouldCacheStatements:YES];
    
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM sw_image_like_list"];
    while ([rs next])
    {
        SWImageItemDO *item = [[SWImageItemDO alloc] init];
        item.bigImageUrl = [rs stringForColumn:@"imageUrlString"];
        item.smallImageUrl = [SWCommonUtil getSmallImageUrl:[rs stringForColumn:@"imageUrlString"]];
        [infoArray addObject:item];
    }
    [self closeDb:db];
    return infoArray;
}

@end
