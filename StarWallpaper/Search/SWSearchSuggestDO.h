//
//  SWSearchSuggestDO.h
//  StarWallpaper
//
//  Created by Fnoz on 16/4/12.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import "SWBaseDO.h"

@interface SWSearchSuggestDO : SWBaseDO

@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) NSArray *keywordItems;

@end
