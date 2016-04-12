//
//  SWSearchSuggestCollectionViewCell.m
//  StarWallpaper
//
//  Created by Fnoz on 16/4/12.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import "SWSearchSuggestCollectionViewCell.h"
#import "SWSearchSuggestSubDO.h"
#import "UIImageView+SWPlaceHolder.h"

@implementation SWSearchSuggestCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _mainImageView.backgroundColor = [UIColor clearColor];
        _mainImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_mainImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-20, frame.size.width, 20)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = SWFontOfSize(16);
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

- (void)setData:(id)data {
    SWSearchSuggestSubDO *item = data;
    [_mainImageView sw_setImageUrl:item.imageUrl progress:nil completed:nil];
    _titleLabel.text = item.keyword;
}

@end
