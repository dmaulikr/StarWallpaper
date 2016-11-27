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
                     @"国内男星#杨洋@http://s.qdcdn.com/c/13599901,750,1334.webp;邓超@http://s.qdcdn.com/c/10018799,160,280.webp;钟汉良@http://s.qdcdn.com/c/10278245,750,1334.webp;李易峰@http://s.qdcdn.com/c/13377814,160,280.webp;张翰@http://s.qdcdn.com/c/12513369,160,280.webp;马天宇@http://s.qdcdn.com/c/11174860,750,1334.webp;周杰伦@http://s.qdcdn.com/c/10289639,160,280.webp;吴秀波@http://s.qdcdn.com/c/13004060,750,1334.webp;王力宏@http://s.qdcdn.com/c/10480841,750,1334.webp;吴奇隆@http://s.qdcdn.com/c/10046968,750,1334.webp;成毅@http://s.qdcdn.com/c/14109744,750,1334.webp;陈学冬@http://s.qdcdn.com/c/13331236,750,1334.webp;霍建华@http://s.qdcdn.com/c/14001427,750,1334.webp;刘恺威@http://s.qdcdn.com/c/10041306,750,1334.webp;刘德华@http://s.qdcdn.com/c/11182372,750,1334.webp;乔任梁@http://s.qdcdn.com/c/13129739,750,1334.webp;张杰@http://s.qdcdn.com/c/12486029,750,1334.webp;谢霆锋@http://s.qdcdn.com/c/10050195,750,1334.webp;井柏然@http://s.qdcdn.com/c/14055891,750,1334.webp;陈伟霆@http://s.qdcdn.com/c/13040491,750,1334.webp;黄晓明@http://s.qdcdn.com/c/13064728,750,1334.webp",
                     @"国内女星#Angelababy@http://s.qdcdn.com/c/13237872,750,1334.webp;刘诗诗@http://s.qdcdn.com/c/12254659,750,1334.webp;刘亦菲@http://s.qdcdn.com/c/10005272,750,1334.webp;郭采洁@http://s.qdcdn.com/c/10313952,750,1334.webp;陈意涵@http://s.qdcdn.com/c/12932369,160,280.webp;唐嫣@http://s.qdcdn.com/c/13726233,750,1334.webp;周冬雨@http://s.qdcdn.com/c/10422302,160,280.webp;张歆艺@http://s.qdcdn.com/c/13004285,160,280.webp;高圆圆@http://s.qdcdn.com/c/11674368,750,1334.webp;杨幂@http://s.qdcdn.com/c/12274835,750,1334.webp;范冰冰@http://s.qdcdn.com/c/10129204,750,1334.webp;贾青@http://s.qdcdn.com/c/10384071,750,1334.webp;陈乔恩@http://s.qdcdn.com/c/13665281,750,1334.webp;赵薇@http://s.qdcdn.com/c/13180290,750,1334.webp;田馥甄@http://s.qdcdn.com/c/10324308,750,1334.webp;宋茜@http://s.qdcdn.com/c/10545150,750,1334.webp;佟丽娅@http://s.qdcdn.com/c/11413491,750,1334.webp;张馨予@http://s.qdcdn.com/c/14059611,750,1334.webp;林志玲@http://s.qdcdn.com/c/14059611,750,1334.webp;周韦彤@http://s.qdcdn.com/c/10505291,750,1334.webp",
                     @"日韩明星#宋仲基@http://s.qdcdn.com/c/11990586,750,1334.webp;李敏镐@http://s.qdcdn.com/c/10026980,750,1334.webp;权志龙@http://s.qdcdn.com/c/11975306,750,1334.webp;EXO@http://s.qdcdn.com/c/13286451,750,1334.webp;李钟硕@http://s.qdcdn.com/c/10130677,160,280.webp;朴信惠@http://s.qdcdn.com/c/12071414,160,280.webp;少女时代@http://s.qdcdn.com/c/11982902,160,280.webp;AOA@http://s.qdcdn.com/c/12354130,160,280.webp;宋慧乔@http://s.qdcdn.com/c/10985167,750,1334.webp;金秀贤@http://s.qdcdn.com/c/12059910,160,280.webp;全智贤@http://s.qdcdn.com/c/10055093,750,1334.webp;林允儿@http://s.qdcdn.com/c/10056943,750,1334.webp;BigBang@http://s.qdcdn.com/c/11380736,750,1334.webp;李准基@http://s.qdcdn.com/c/10426408,750,1334.webp;防弹少年团@http://s.qdcdn.com/c/12046251,750,1334.webp;After School@http://s.qdcdn.com/c/11332635,750,1334.webp;KARA@http://s.qdcdn.com/c/10043551,750,1334.webp;张根硕@http://s.qdcdn.com/c/10100381,750,1334.webp",
                     @"欧美明星#斯威夫特@http://s.qdcdn.com/c/13443929,750,1334.webp;斯嘉丽·约翰逊@http://s.qdcdn.com/c/12812236,750,1334.webp;梅根·福克斯@http://s.qdcdn.com/c/12240309,160,280.webp;Lady Gaga@http://s.qdcdn.com/c/10646014,160,280.webp;艾薇儿@http://s.qdcdn.com/c/10204340,750,1334.webp;布兰妮@http://s.qdcdn.com/c/10212536,750,1334.webp;碧昂丝@http://s.qdcdn.com/c/10383854,750,1334.webp;蕾哈娜@http://s.qdcdn.com/c/12470172,750,1334.webp",
                     @"体育明星#詹姆斯@http://s.qdcdn.com/c/10240010,160,280.webp;科比@http://s.qdcdn.com/c/10823313,160,280.webp;麦迪@http://s.qdcdn.com/c/10089788,160,280.webp;贝克汉姆@http://s.qdcdn.com/c/10979411,160,280.webp;罗纳尔多@http://s.qdcdn.com/c/11116767,160,280.webp;妮娜·杜波夫@http://s.qdcdn.com/c/12217877,160,280.webp;莎拉波娃@http://s.qdcdn.com/c/10742230,160,280.webp;罗杰·费德勒@http://s.qdcdn.com/c/10622618,160,280.webp;乔丹@http://s.qdcdn.com/c/10186072,750,1334.webp;杜兰特@http://s.qdcdn.com/c/11810567,750,1334.webp;韦德@http://s.qdcdn.com/c/11827472,750,1334.webp;安东尼@http://s.qdcdn.com/c/10156438,750,1334.webp;林书豪@http://s.qdcdn.com/c/10067633,750,1334.webp",
                     @"动漫明星#路飞@http://s.qdcdn.com/c/12989216,750,1334.webp;喜羊羊@http://s.qdcdn.com/c/10170672,750,1334.webp;柯南@http://s.qdcdn.com/c/13773699,750,1334.webp;流川枫@http://s.qdcdn.com/c/10062654,750,1334.webp;哆啦A梦@http://s.qdcdn.com/c/10223161,750,1334.webp;鲁鲁修@http://s.qdcdn.com/c/10890303,750,1334.webp"];
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
