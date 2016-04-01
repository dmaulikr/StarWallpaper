//
//  SWHomeCollectionViewLayout.h
//  StarWallpaper
//
//  Created by Fnoz on 16/4/1.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface SWHomeCollectionViewLayout : UICollectionViewLayout

@property (assign, nonatomic) NSUInteger numberOfColumns;
@property (assign, nonatomic) CGFloat columnSpacing;
@property (assign, nonatomic) UIEdgeInsets sectionInset;
@property (assign, nonatomic) UIEdgeInsets interItemSpacing;
@property (assign, nonatomic) CGFloat headerHeight;

@end

@protocol SWHomeCollectionViewLayoutDelegate <ASCollectionViewDelegate>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(SWHomeCollectionViewLayout *)layout originalItemSizeAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface SWHomeCollectionViewLayoutInspector : NSObject <ASCollectionViewLayoutInspecting>

@end