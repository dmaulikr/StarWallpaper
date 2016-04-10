//
//  SWCommonUtil.h
//  StarWallpaper
//
//  Created by Fnoz on 16/4/6.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWCommonUtil : NSObject

+ (UIViewController *)getCurrentVC;
+ (NSString *)replaceUnicode:(NSString *)unicodeStr;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end
