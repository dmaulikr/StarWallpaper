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
                     @"国内男星#杨洋@http://s.qdcdn.com/c/13599901,200,350.webp;邓超@http://s.qdcdn.com/c/10018799,200,350.webp;钟汉良@http://s.qdcdn.com/c/10278245,200,350.webp;李易峰@http://s.qdcdn.com/c/13377814,200,350.webp;张翰@http://s.qdcdn.com/c/12513369,200,350.webp;马天宇@http://s.qdcdn.com/c/11174860,200,350.webp;周杰伦@http://s.qdcdn.com/c/10289639,200,350.webp;吴秀波@http://s.qdcdn.com/c/13004060,200,350.webp;王力宏@http://s.qdcdn.com/c/10480841,200,350.webp;吴奇隆@http://s.qdcdn.com/c/10046968,200,350.webp;成毅@http://s.qdcdn.com/c/14109744,200,350.webp;陈学冬@http://s.qdcdn.com/c/13331236,200,350.webp;霍建华@http://s.qdcdn.com/c/14001427,200,350.webp;刘恺威@http://s.qdcdn.com/c/10041306,200,350.webp;刘德华@http://s.qdcdn.com/c/11182372,200,350.webp;乔任梁@http://s.qdcdn.com/c/13129739,200,350.webp;张杰@http://s.qdcdn.com/c/12486029,200,350.webp;谢霆锋@http://s.qdcdn.com/c/10050195,200,350.webp;井柏然@http://s.qdcdn.com/c/14055891,200,350.webp;陈伟霆@http://s.qdcdn.com/c/13040491,200,350.webp;黄晓明@http://s.qdcdn.com/c/13064728,200,350.webp",
                     @"国内女星#Angelababy@http://s.qdcdn.com/c/13237872,200,350.webp;刘诗诗@http://s.qdcdn.com/c/12254659,200,350.webp;刘亦菲@http://s.qdcdn.com/c/10005272,200,350.webp;郭采洁@http://s.qdcdn.com/c/10313952,200,350.webp;陈意涵@http://s.qdcdn.com/c/12932369,200,350.webp;唐嫣@http://s.qdcdn.com/c/13726233,200,350.webp;周冬雨@http://s.qdcdn.com/c/10422302,200,350.webp;张歆艺@http://s.qdcdn.com/c/13004285,200,350.webp;高圆圆@http://s.qdcdn.com/c/11674368,200,350.webp;杨幂@http://s.qdcdn.com/c/12274835,200,350.webp;范冰冰@http://s.qdcdn.com/c/10129204,200,350.webp;贾青@http://s.qdcdn.com/c/10384071,200,350.webp;陈乔恩@http://s.qdcdn.com/c/13665281,200,350.webp;赵薇@http://s.qdcdn.com/c/13180290,200,350.webp;田馥甄@http://s.qdcdn.com/c/10324308,200,350.webp;宋茜@http://s.qdcdn.com/c/10545150,200,350.webp;佟丽娅@http://s.qdcdn.com/c/11413491,200,350.webp;张馨予@http://s.qdcdn.com/c/14059611,200,350.webp;林志玲@http://s.qdcdn.com/c/14059611,200,350.webp;周韦彤@http://s.qdcdn.com/c/10505291,200,350.webp",
                     @"日韩明星#宋仲基@http://s.qdcdn.com/c/11990586,200,350.webp;李敏镐@http://s.qdcdn.com/c/10026980,200,350.webp;权志龙@http://s.qdcdn.com/c/11975306,200,350.webp;EXO@http://s.qdcdn.com/c/13286451,200,350.webp;李钟硕@http://s.qdcdn.com/c/10130677,200,350.webp;朴信惠@http://s.qdcdn.com/c/12071414,200,350.webp;少女时代@http://s.qdcdn.com/c/11982902,200,350.webp;AOA@http://s.qdcdn.com/c/12354130,200,350.webp;宋慧乔@http://s.qdcdn.com/c/10985167,200,350.webp;金秀贤@http://s.qdcdn.com/c/12059910,200,350.webp;全智贤@http://s.qdcdn.com/c/10055093,200,350.webp;林允儿@http://s.qdcdn.com/c/10056943,200,350.webp;BigBang@http://s.qdcdn.com/c/11380736,200,350.webp;李准基@http://s.qdcdn.com/c/10426408,200,350.webp;防弹少年团@http://s.qdcdn.com/c/12046251,200,350.webp;After School@http://s.qdcdn.com/c/11332635,200,350.webp;KARA@http://s.qdcdn.com/c/10043551,200,350.webp;张根硕@http://s.qdcdn.com/c/10100381,200,350.webp",
                     @"欧美明星#斯威夫特@http://s.qdcdn.com/c/13443929,200,350.webp;斯嘉丽·约翰逊@http://s.qdcdn.com/c/12812236,200,350.webp;梅根·福克斯@http://s.qdcdn.com/c/12240309,200,350.webp;Lady Gaga@http://s.qdcdn.com/c/10646014,200,350.webp;艾薇儿@http://s.qdcdn.com/c/10204340,200,350.webp;布兰妮@http://s.qdcdn.com/c/10212536,200,350.webp;碧昂丝@http://s.qdcdn.com/c/10383854,200,350.webp;蕾哈娜@http://s.qdcdn.com/c/12470172,200,350.webp",
                     @"体育明星#詹姆斯@http://s.qdcdn.com/c/10240010,200,350.webp;科比@http://s.qdcdn.com/c/10823313,200,350.webp;麦迪@http://s.qdcdn.com/c/10089788,200,350.webp;贝克汉姆@http://s.qdcdn.com/c/10979411,200,350.webp;罗纳尔多@http://s.qdcdn.com/c/11116767,200,350.webp;妮娜·杜波夫@http://s.qdcdn.com/c/12217877,200,350.webp;莎拉波娃@http://s.qdcdn.com/c/10742230,200,350.webp;罗杰·费德勒@http://s.qdcdn.com/c/10622618,200,350.webp;乔丹@http://s.qdcdn.com/c/10186072,200,350.webp;杜兰特@http://s.qdcdn.com/c/11810567,200,350.webp;韦德@http://s.qdcdn.com/c/11827472,200,350.webp;安东尼@http://s.qdcdn.com/c/10156438,200,350.webp;林书豪@http://s.qdcdn.com/c/10067633,200,350.webp",
                     @"动漫明星#路飞@http://s.qdcdn.com/c/12989216,200,350.webp;喜羊羊@http://s.qdcdn.com/c/10170672,200,350.webp;柯南@http://s.qdcdn.com/c/13773699,200,350.webp;流川枫@http://s.qdcdn.com/c/10062654,200,350.webp;哆啦A梦@http://s.qdcdn.com/c/10223161,200,350.webp;鲁鲁修@http://s.qdcdn.com/c/10890303,200,350.webp"];
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
