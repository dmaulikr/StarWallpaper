//
//  SWSearchSuggestCollectionViewCell.h
//  StarWallpaper
//
//  Created by Fnoz on 16/4/12.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWSearchSuggestCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *mainImageView;
@property (nonatomic, strong) UILabel *titleLabel;

- (void)setData:(id)data;

@end
