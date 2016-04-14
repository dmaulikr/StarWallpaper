//
//  SWSettingTableViewCell.h
//  StarWallpaper
//
//  Created by Fnoz on 16/4/14.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const kSWSettingTableViewCell = @"kSWSettingTableViewCell";


@interface SWSettingTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIButton *rightBtn;

@end
