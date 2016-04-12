//
//  SWSearchSuggestTableViewCell.h
//  StarWallpaper
//
//  Created by Fnoz on 16/4/12.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWSearchSuggestTableViewCell : UITableViewCell

@property (nonatomic, strong) UICollectionView *collectionView;

- (void)setData:(id)data;

@end
