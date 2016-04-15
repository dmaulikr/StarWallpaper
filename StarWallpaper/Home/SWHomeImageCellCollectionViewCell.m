//
//  SWHomeImageCellCollectionViewCell.m
//  StarWallpaper
//
//  Created by Fnoz on 16/4/10.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import "SWHomeImageCellCollectionViewCell.h"
#import "UIImageView+SWPlaceHolder.h"

@implementation SWHomeImageCellCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-4)];
        _imageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_imageView];
    }
    return self;
}

- (void)setImageUrl:(NSString *)imageUrl {
    [_imageView sw_setImageUrl:imageUrl progress:nil completed:nil];
}

@end
