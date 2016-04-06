//
//  SWImageItemDO.h
//  StarWallpaper
//
//  Created by Fnoz on 16/4/5.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWBaseDO.h"

@interface SWImageItemDO : SWBaseDO

@property (nonatomic, copy) NSString *diyImageUrl;
@property (nonatomic, copy) NSString *smallImageUrl;
@property (nonatomic, copy) NSString *bigImageUrl;
@property (nonatomic, copy) NSString *middleImageUrl;  //自己拼接尺寸

@end
