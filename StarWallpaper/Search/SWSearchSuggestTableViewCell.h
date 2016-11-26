//
//  SWSearchSuggestTableViewCell.h
//  StarWallpaper
//
//  Created by Fnoz on 16/4/12.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import <UIKit/UIKit.h>

#define  kSWSearchSuggestTableViewCellSize  100

@protocol SWSearchSuggestTableViewCellDelegate <NSObject>

- (void)clickWithKeyword:(NSString *)keyword;

@end

@interface SWSearchSuggestTableViewCell : UITableViewCell

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, weak) id<SWSearchSuggestTableViewCellDelegate> delegate;

- (void)setData:(id)data;

@end
