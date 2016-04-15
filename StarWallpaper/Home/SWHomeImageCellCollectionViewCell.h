//
//  SWHomeImageCellCollectionViewCell.h
//  StarWallpaper
//
//  Created by Fnoz on 16/4/10.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const kSWHomeImageCellCollectionViewCell = @"SWHomeImageCellCollectionViewCell";

@interface SWHomeImageCellCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

- (void)setImageUrl:(NSString *)imageUrl;

@end
