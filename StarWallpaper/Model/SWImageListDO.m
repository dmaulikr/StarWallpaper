//
//  SWImageListDO.m
//  StarWallpaper
//
//  Created by Fnoz on 16/4/5.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import "SWImageListDO.h"
#import "SWImageItemDO.h"

@implementation SWImageListDO

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"itemArray"  : @"data"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"itemArray" : [SWImageItemDO class]};
}

@end
