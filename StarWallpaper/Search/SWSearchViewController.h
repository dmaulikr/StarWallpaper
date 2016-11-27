//
//  SWSearchViewController.h
//  StarWallpaper
//
//  Created by Fnoz on 16/4/4.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWViewController.h"

typedef void (^SWSelectedKeywordBlock)(NSString *keyword);

@interface SWSearchViewController : SWViewController

@property (nonatomic, copy) NSString *keyword;

+ (void)presentWithKeyword:(NSString *)keyword selectedKeywordBlock:(SWSelectedKeywordBlock)block;

@end
