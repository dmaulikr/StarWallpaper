//
//  SWImageItemDO.m
//  StarWallpaper
//
//  Created by Fnoz on 16/4/5.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import "SWImageItemDO.h"
#import "SWConstDef.h"

@implementation SWImageItemDO

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"diyImageUrl"  : @"image.diy",
             @"smallImageUrl"  : @"image.small",
             @"bigImageUrl"  : @"image.big"};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _middleImageUrl = [self handleMiddleImageUrl:_diyImageUrl];
    return YES;
}

/*
diy = "http://s.qdcdn.com/d/13040413.jpg";
original = "http://s.qdcdn.com/c/13040413,1080,1920.webp";
*/

- (NSString *)handleMiddleImageUrl:(NSString *)urlStr {
    NSInteger dotPosition = [urlStr rangeOfString:@"." options:NSBackwardsSearch].location;
    if (dotPosition != NSNotFound) {
        urlStr = [urlStr substringToIndex:dotPosition];
        urlStr = [NSString stringWithFormat:@"%@,%ld,%ld.webp", urlStr, (long)(kScreenHeight * [UIScreen mainScreen].scale / 3), (long)(kScreenHeight * [UIScreen mainScreen].scale / 3)];
        return urlStr;
    }
    return nil;
}

@end
