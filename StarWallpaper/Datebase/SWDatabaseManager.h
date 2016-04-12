//
//  SWDatabaseManager.h
//  StarWallpaper
//
//  Created by Fnoz on 16/4/11.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabase;

@interface SWDatabaseManager : NSObject

+ (SWDatabaseManager *)sharedFMDBSqlite;

- (BOOL)openDb:(FMDatabase *)database;

- (BOOL)closeDb:(FMDatabase *)database;

- (void)insertImageUrlString:(NSString *)imageUrlString;

- (void)deleteImageUrlString:(NSString *)imageUrlString;

- (BOOL)imageUrlStringHasInDB:(NSString *)imageUrlString;

@end
