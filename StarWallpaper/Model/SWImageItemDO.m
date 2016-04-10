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

@end
