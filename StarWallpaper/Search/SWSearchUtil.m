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
                      @"内地男星#宋仲基@http://s.qdcdn.com/cl/11990610,250,444.webp;陈学冬@http://s.qdcdn.com/cl/11297613,250,444.webp"];
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
