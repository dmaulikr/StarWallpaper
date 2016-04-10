//
//  SWHomeImageCellCollectionViewCell.h
//  StarWallpaper
//
//  Created by Fnoz on 16/4/10.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWHomeImageCellCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *loadingView;
@property (nonatomic, strong) UIImageView *animationView;

- (void)setImageUrl:(NSString *)imageUrl;

@end
