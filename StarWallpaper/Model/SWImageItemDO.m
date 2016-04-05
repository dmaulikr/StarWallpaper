//
//  SWImageItemDO.m
//  StarWallpaper
//
//  Created by Fnoz on 16/4/5.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import "SWImageItemDO.h"

@implementation SWImageItemDO

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"thumnailImageUrl"  : @"image.small",
             @"bigImageUrl"  : @"image.big"};
}

@end
