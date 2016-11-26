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
                     @"国内男星#杨洋@http://s.qdcdn.com/c/13599901,160,280.webp;邓超@http://s.qdcdn.com/c/10018799,160,280.webp;钟汉良@http://s.qdcdn.com/c/11266020,160,280.webp;李易峰@http://s.qdcdn.com/c/13377814,160,280.webp;张翰@http://s.qdcdn.com/c/12513369,160,280.webp;马天宇@http://s.qdcdn.com/c/11174727,160,280.webp;周杰伦@http://s.qdcdn.com/c/10289639,160,280.webp;吴秀波@http://s.qdcdn.com/c/10289639,160,280.webp;王力宏@http://s.qdcdn.com/c/10289639,160,280.webp;吴奇隆@http://s.qdcdn.com/c/10289639,160,280.webp;成毅@http://s.qdcdn.com/c/10289639,160,280.webp;陈学冬@http://s.qdcdn.com/c/10289639,160,280.webp;霍建华@http://s.qdcdn.com/c/10289639,160,280.webp;刘恺威@http://s.qdcdn.com/c/10289639,160,280.webp;刘德华@http://s.qdcdn.com/c/10289639,160,280.webp;乔任梁@http://s.qdcdn.com/c/10289639,160,280.webp;张杰@http://s.qdcdn.com/c/10289639,160,280.webp;谢霆锋@http://s.qdcdn.com/c/10289639,160,280.webp;井柏然@http://s.qdcdn.com/c/12060402,160,280.webp;陈伟霆@http://s.qdcdn.com/c/12060444,160,280.webp;黄晓明@http://s.qdcdn.com/c/11056869,160,280.webp",
                     @"国内女星#Angelababy@http://s.qdcdn.com/c/13237858,160,280.webp;刘诗诗@http://s.qdcdn.com/c/10287180,160,280.webp;刘亦菲@http://s.qdcdn.com/c/12499441,160,280.webp;郭采洁@http://s.qdcdn.com/c/10314016,160,280.webp;陈意涵@http://s.qdcdn.com/c/12932369,160,280.webp;唐嫣@http://s.qdcdn.com/c/13447990,160,280.webp;周冬雨@http://s.qdcdn.com/c/10422302,160,280.webp;张歆艺@http://s.qdcdn.com/c/13004285,160,280.webp;高圆圆@http://s.qdcdn.com/c/11674319,160,280.webp;杨幂@http://s.qdcdn.com/c/11674319,160,280.webp;范冰冰@http://s.qdcdn.com/c/11674319,160,280.webp;贾青@http://s.qdcdn.com/c/11674319,160,280.webp;陈乔恩@http://s.qdcdn.com/c/11674319,160,280.webp;赵薇@http://s.qdcdn.com/c/11674319,160,280.webp;田馥甄@http://s.qdcdn.com/c/11674319,160,280.webp;宋茜@http://s.qdcdn.com/c/11674319,160,280.webp;佟丽娅@http://s.qdcdn.com/c/11674319,160,280.webp;张馨予@http://s.qdcdn.com/c/11674319,160,280.webp;林志玲@http://s.qdcdn.com/c/11674319,160,280.webp;周韦彤@http://s.qdcdn.com/c/11674319,160,280.webp",
                     @"日韩明星#宋仲基@http://s.qdcdn.com/c/11990652,160,280.webp;李敏镐@http://s.qdcdn.com/c/11953165,160,280.webp;权志龙@http://s.qdcdn.com/c/11975476,160,280.webp;EXO@http://s.qdcdn.com/c/11321992,160,280.webp;李钟硕@http://s.qdcdn.com/c/10130677,160,280.webp;朴信惠@http://s.qdcdn.com/c/12071414,160,280.webp;少女时代@http://s.qdcdn.com/c/11982902,160,280.webp;AOA@http://s.qdcdn.com/c/12354130,160,280.webp;宋慧乔@http://s.qdcdn.com/c/10031246,160,280.webp;金秀贤@http://s.qdcdn.com/c/12059910,160,280.webp;全智贤@http://s.qdcdn.com/c/12059910,160,280.webp;林允儿@http://s.qdcdn.com/c/12059910,160,280.webp;BigBang@http://s.qdcdn.com/c/12059910,160,280.webp;Rain@http://s.qdcdn.com/c/12059910,160,280.webp;李准基@http://s.qdcdn.com/c/12059910,160,280.webp;防弹少年团@http://s.qdcdn.com/c/12059910,160,280.webp;After School@http://s.qdcdn.com/c/12059910,160,280.webp;KARA@http://s.qdcdn.com/c/12059910,160,280.webp;张根硕@http://s.qdcdn.com/c/12059910,160,280.webp",
                     @"欧美明星#斯威夫特@http://s.qdcdn.com/c/10215513,160,280.webp;斯嘉丽·约翰逊@http://s.qdcdn.com/c/10409109,160,280.webp;梅根·福克斯@http://s.qdcdn.com/c/12240309,160,280.webp;Lady Gaga@http://s.qdcdn.com/c/10646014,160,280.webp;希拉里@http://s.qdcdn.com/c/10646014,160,280.webp;艾薇儿@http://s.qdcdn.com/c/10646014,160,280.webp;布兰妮@http://s.qdcdn.com/c/10646014,160,280.webp;碧昂丝@http://s.qdcdn.com/c/10646014,160,280.webp;蕾哈娜@http://s.qdcdn.com/c/10646014,160,280.webp",
                     @"体育明星#詹姆斯@http://s.qdcdn.com/c/10240010,160,280.webp;科比@http://s.qdcdn.com/c/10823313,160,280.webp;麦迪@http://s.qdcdn.com/c/10089788,160,280.webp;贝克汉姆@http://s.qdcdn.com/c/10979411,160,280.webp;罗纳尔多@http://s.qdcdn.com/c/11116767,160,280.webp;妮娜·杜波夫@http://s.qdcdn.com/c/12217877,160,280.webp;莎拉波娃@http://s.qdcdn.com/c/10742230,160,280.webp;罗杰·费德勒@http://s.qdcdn.com/c/10622618,160,280.webp;乔丹@http://s.qdcdn.com/c/10823313,160,280.webp;杜兰特@http://s.qdcdn.com/c/10823313,160,280.webp;韦德@http://s.qdcdn.com/c/10823313,160,280.webp;罗斯@http://s.qdcdn.com/c/10823313,160,280.webp;安东尼@http://s.qdcdn.com/c/10823313,160,280.webp;林书豪@http://s.qdcdn.com/c/10823313,160,280.webp",
                     @"动漫明星#路飞@http://s.qdcdn.com/c/10240010,160,280.webp;喜羊羊@http://s.qdcdn.com/c/10823313,160,280.webp;柯南@http://s.qdcdn.com/c/10089788,160,280.webp;流川枫@http://s.qdcdn.com/c/10979411,160,280.webp;哆啦A梦@http://s.qdcdn.com/c/11116767,160,280.webp;高达@http://s.qdcdn.com/c/12217877,160,280.webp;鲁鲁修@http://s.qdcdn.com/c/10742230,160,280.webp"];
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
