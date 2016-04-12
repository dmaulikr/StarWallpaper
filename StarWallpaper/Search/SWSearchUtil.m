//
//  SWSearchUtil.m
//  StarWallpaper
//
//  Created by Fnoz on 16/4/12.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import "SWSearchUtil.h"
#import "SWSearchSuggestDO.h"
#import "SWSearchSuggestSubDO.h"

@implementation SWSearchUtil

+ (NSArray *)getSuggestionArray {
    NSArray *abc = @[
                      @"体育明星#詹姆斯@http://h.hiphotos.baidu.com/baike/w%3D268/sign=5d09cba4d33f8794d3ff4f28ea1b0ead/5bafa40f4bfbfbed64281e637ff0f736afc31fbc.jpg,科比@http://a.hiphotos.baidu.com/baike/w%3D268/sign=bf735d259a16fdfad86cc1e88c8e8cea/32fa828ba61ea8d3e583d20a900a304e251f581e.jpg,詹姆斯@http://h.hiphotos.baidu.com/baike/w%3D268/sign=5d09cba4d33f8794d3ff4f28ea1b0ead/5bafa40f4bfbfbed64281e637ff0f736afc31fbc.jpg,科比@http://a.hiphotos.baidu.com/baike/w%3D268/sign=bf735d259a16fdfad86cc1e88c8e8cea/32fa828ba61ea8d3e583d20a900a304e251f581e.jpg,詹姆斯@http://h.hiphotos.baidu.com/baike/w%3D268/sign=5d09cba4d33f8794d3ff4f28ea1b0ead/5bafa40f4bfbfbed64281e637ff0f736afc31fbc.jpg,科比@http://a.hiphotos.baidu.com/baike/w%3D268/sign=bf735d259a16fdfad86cc1e88c8e8cea/32fa828ba61ea8d3e583d20a900a304e251f581e.jpg,詹姆斯@http://h.hiphotos.baidu.com/baike/w%3D268/sign=5d09cba4d33f8794d3ff4f28ea1b0ead/5bafa40f4bfbfbed64281e637ff0f736afc31fbc.jpg,科比@http://a.hiphotos.baidu.com/baike/w%3D268/sign=bf735d259a16fdfad86cc1e88c8e8cea/32fa828ba61ea8d3e583d20a900a304e251f581e.jpg",
                      @"体育明星#詹姆斯@http://h.hiphotos.baidu.com/baike/w%3D268/sign=5d09cba4d33f8794d3ff4f28ea1b0ead/5bafa40f4bfbfbed64281e637ff0f736afc31fbc.jpg,科比@http://a.hiphotos.baidu.com/baike/w%3D268/sign=bf735d259a16fdfad86cc1e88c8e8cea/32fa828ba61ea8d3e583d20a900a304e251f581e.jpg,詹姆斯@http://h.hiphotos.baidu.com/baike/w%3D268/sign=5d09cba4d33f8794d3ff4f28ea1b0ead/5bafa40f4bfbfbed64281e637ff0f736afc31fbc.jpg,科比@http://a.hiphotos.baidu.com/baike/w%3D268/sign=bf735d259a16fdfad86cc1e88c8e8cea/32fa828ba61ea8d3e583d20a900a304e251f581e.jpg,詹姆斯@http://h.hiphotos.baidu.com/baike/w%3D268/sign=5d09cba4d33f8794d3ff4f28ea1b0ead/5bafa40f4bfbfbed64281e637ff0f736afc31fbc.jpg,科比@http://a.hiphotos.baidu.com/baike/w%3D268/sign=bf735d259a16fdfad86cc1e88c8e8cea/32fa828ba61ea8d3e583d20a900a304e251f581e.jpg,詹姆斯@http://h.hiphotos.baidu.com/baike/w%3D268/sign=5d09cba4d33f8794d3ff4f28ea1b0ead/5bafa40f4bfbfbed64281e637ff0f736afc31fbc.jpg,科比@http://a.hiphotos.baidu.com/baike/w%3D268/sign=bf735d259a16fdfad86cc1e88c8e8cea/32fa828ba61ea8d3e583d20a900a304e251f581e.jpg",
                      @"体育明星#詹姆斯@http://h.hiphotos.baidu.com/baike/w%3D268/sign=5d09cba4d33f8794d3ff4f28ea1b0ead/5bafa40f4bfbfbed64281e637ff0f736afc31fbc.jpg,科比@http://a.hiphotos.baidu.com/baike/w%3D268/sign=bf735d259a16fdfad86cc1e88c8e8cea/32fa828ba61ea8d3e583d20a900a304e251f581e.jpg,詹姆斯@http://h.hiphotos.baidu.com/baike/w%3D268/sign=5d09cba4d33f8794d3ff4f28ea1b0ead/5bafa40f4bfbfbed64281e637ff0f736afc31fbc.jpg,科比@http://a.hiphotos.baidu.com/baike/w%3D268/sign=bf735d259a16fdfad86cc1e88c8e8cea/32fa828ba61ea8d3e583d20a900a304e251f581e.jpg,詹姆斯@http://h.hiphotos.baidu.com/baike/w%3D268/sign=5d09cba4d33f8794d3ff4f28ea1b0ead/5bafa40f4bfbfbed64281e637ff0f736afc31fbc.jpg,科比@http://a.hiphotos.baidu.com/baike/w%3D268/sign=bf735d259a16fdfad86cc1e88c8e8cea/32fa828ba61ea8d3e583d20a900a304e251f581e.jpg,詹姆斯@http://h.hiphotos.baidu.com/baike/w%3D268/sign=5d09cba4d33f8794d3ff4f28ea1b0ead/5bafa40f4bfbfbed64281e637ff0f736afc31fbc.jpg,科比@http://a.hiphotos.baidu.com/baike/w%3D268/sign=bf735d259a16fdfad86cc1e88c8e8cea/32fa828ba61ea8d3e583d20a900a304e251f581e.jpg"];
    NSMutableArray *suggestionArray = [NSMutableArray array];
    for (NSString *suggestion in abc) {
        SWSearchSuggestDO *suggest = [[SWSearchSuggestDO alloc] init];
        if ([suggestion rangeOfString:@"#"].location != NSNotFound) {
            suggest.type = [suggestion substringToIndex:[suggestion rangeOfString:@"#"].location];
            NSMutableArray *array = [NSMutableArray array];
            if ([suggestion rangeOfString:@"#"].location<=suggestion.length) {
                NSString *itemsString = [suggestion substringFromIndex:[suggestion rangeOfString:@"#"].location+1];
                NSArray *items = [itemsString componentsSeparatedByString:@","];
                for (NSString *item in items) {
                    SWSearchSuggestSubDO *subItem = [[SWSearchSuggestSubDO alloc] init];
                    if ([item rangeOfString:@"@"].location != NSNotFound) {
                        subItem.keyword = [item substringToIndex:[item rangeOfString:@"@"].location];
                        if ([item rangeOfString:@"@"].location<=suggestion.length) {
                            subItem.imageUrl = [item substringFromIndex:[item rangeOfString:@"@"].location+1];
                        }
                    }
                    [array addObject:subItem];
                }
            }
            suggest.keywordItems = array;
        }
        [suggestionArray addObject:suggest];
    }
    return [suggestionArray copy];
}

@end
