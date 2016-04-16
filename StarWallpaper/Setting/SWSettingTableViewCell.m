//
//  SWSettingTableViewCell.m
//  StarWallpaper
//
//  Created by Fnoz on 16/4/14.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import "SWSettingTableViewCell.h"
#import "SWCommonUtil.h"

@implementation SWSettingTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = kSWBackGroundGray;
        
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake([SWCommonUtil is5OrLater]?70:90, 10, 60, 60)];
        _leftImageView.backgroundColor = [UIColor clearColor];
        _leftImageView.layer.cornerRadius = 30;
        _leftImageView.clipsToBounds = YES;
        [self.contentView addSubview:_leftImageView];
        
        _rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-([SWCommonUtil is5OrLater]?165:185), 25, 100, 30)];
        _rightBtn.backgroundColor = [UIColor clearColor];
        _rightBtn.titleLabel.font = SWFontOfSize(18);
        [self.contentView addSubview:_rightBtn];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
