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
                     @"内地男星#宋仲基@http://s.qdcdn.com/c/11990652,750,1334.webp;鹿晗@http://s.qdcdn.com/c/12060267,750,1334.webp;吴亦凡@http://s.qdcdn.com/c/12060480,750,1334.webp;李敏镐@http://s.qdcdn.com/c/11953123,750,1334.webp;胡歌@http://s.qdcdn.com/c/10286782,750,1334.webp;TFBoys@http://s.qdcdn.com/c/12494176,750,1334.webp;张艺兴@http://s.qdcdn.com/c/12060444,750,1334.webp;杨洋@http://s.qdcdn.com/c/13599901,750,1334.webp;霍建华@http://s.qdcdn.com/c/13446881,750,1334.webp;李易峰@http://s.qdcdn.com/c/13377814,750,1334.webp;周杰伦@http://s.qdcdn.com/c/10289639,750,1334.webp;黄晓明@http://s.qdcdn.com/c/11056869,750,1334.webp;陈学冬@http://s.qdcdn.com/c/13331236,750,1334.webp;马天宇@http://s.qdcdn.com/c/11174720,750,1334.webp;吴秀波@http://s.qdcdn.com/c/13004060,750,1334.webp",
                     @"内地女星#Angelababy@http://s.qdcdn.com/c/13237872,750,1334.webp;赵丽颖@http://s.qdcdn.com/c/12060267,750,1334.webp;孙俪@http://s.qdcdn.com/c/12060480,750,1334.webp;刘诗诗@http://s.qdcdn.com/c/12494176,750,1334.webp;刘亦菲@http://s.qdcdn.com/c/11953123,750,1334.webp;刘亦菲@http://s.qdcdn.com/c/10286782,750,1334.webp;周冬雨@http://s.qdcdn.com/c/13599901,750,1334.webp;张歆艺@http://s.qdcdn.com/c/13446881,750,1334.webp;唐嫣@http://s.qdcdn.com/c/13377814,750,1334.webp;古力娜扎@http://s.qdcdn.com/c/10289639,750,1334.webp;郭碧婷@http://s.qdcdn.com/c/11056869,750,1334.webp;李玟@http://s.qdcdn.com/c/13331236,750,1334.webp;邓紫棋@http://s.qdcdn.com/c/11174720,750,1334.webp;高圆圆@http://s.qdcdn.com/c/13004060,750,1334.webp",
                     @"内地男星#宋仲基@http://s.qdcdn.com/c/11990652,750,1334.webp;鹿晗@http://s.qdcdn.com/c/12060267,750,1334.webp;吴亦凡@http://s.qdcdn.com/c/12060480,750,1334.webp;TFBoys@http://s.qdcdn.com/c/12494176,750,1334.webp;李敏镐@http://s.qdcdn.com/c/11953123,750,1334.webp;胡歌@http://s.qdcdn.com/c/10286782,750,1334.webp;杨洋@http://s.qdcdn.com/c/13599901,750,1334.webp;霍建华@http://s.qdcdn.com/c/13446881,750,1334.webp;李易峰@http://s.qdcdn.com/c/13377814,750,1334.webp;周杰伦@http://s.qdcdn.com/c/10289639,750,1334.webp;黄晓明@http://s.qdcdn.com/c/11056869,750,1334.webp;陈学冬@http://s.qdcdn.com/c/13331236,750,1334.webp;马天宇@http://s.qdcdn.com/c/11174720,750,1334.webp;吴秀波@http://s.qdcdn.com/c/13004060,750,1334.webp"];
    NSMutableArray *suggestionArray = [NSMutableArray array];
    for (NSString *suggestion in abc) {
        SWSearchSuggestDO *suggest = [[SWSearchSuggestDO alloc] init];
        if ([suggestion rangeOfString:@"#"].location != NSNotFound) {
            suggest.type = [suggestion substringToIndex:[suggestion rangeOfString:@"#"].location];
            NSMutableArray *array = [NSMutableArray array];
            if ([suggestion rangeOfString:@"#"].location<=suggestion.length) {
                NSString *itemsString = [suggestion substringFromIndex:[suggestion rangeOfString:@"#"].location+1];
                NSArray *items = [itemsString componentsSeparatedByString:@";"];
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
