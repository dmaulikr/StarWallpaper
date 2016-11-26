//
//  SWCommonUtil.h
//  StarWallpaper
//
//  Created by Fnoz on 16/4/6.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWCommonUtil : NSObject

+ (BOOL)is5OrEarlier;
+ (BOOL)is6Or6s;
+ (BOOL)is6pOr6sp;

+ (UIViewController *)getCurrentVC;
+ (NSString *)replaceUnicode:(NSString *)unicodeStr;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (NSString *)getBigImageUrl:(NSString *)imageUrl;
+ (NSString *)getSmallImageUrl:(NSString *)imageUrl;
+ (void)saveImageToAlbum:(UIImage *)image;

@end
