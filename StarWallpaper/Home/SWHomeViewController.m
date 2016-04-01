//
//  SWHomeViewController.m
//  StarWallpaper
//
//  Created by Fnoz on 16/4/1.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import "SWHomeViewController.h"
#import "ASCollectionView.h"
#import "SWHomeCollectionViewLayout.h"
#import "SWHomeImageCellNode.h"

@interface SWHomeViewController () <ASCollectionViewDataSource, SWHomeCollectionViewLayoutDelegate>

@property (nonatomic, strong) ASCollectionView *collectionView;
@property (nonatomic, strong) SWHomeCollectionViewLayoutInspector *layoutInspector;

@end

@implementation SWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWHomeCollectionViewLayout *layout = [[SWHomeCollectionViewLayout alloc] init];
    layout.numberOfColumns = 3;
    layout.headerHeight = 44.0;
    
    _layoutInspector = [[SWHomeCollectionViewLayoutInspector alloc] init];
    
    _collectionView = [[ASCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.asyncDataSource = self;
    _collectionView.asyncDelegate = self;
    _collectionView.layoutInspector = _layoutInspector;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [_collectionView registerSupplementaryNodeOfKind:UICollectionElementKindSectionHeader];
    [self.view addSubview:_collectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (ASCellNodeBlock)collectionView:(ASCollectionView *)collectionView nodeBlockForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *image = [UIImage imageNamed:@"test"];
    return ^{
        return [[SWHomeImageCellNode alloc] initWithImage:image];
    };
}


- (ASCellNode *)collectionView:(ASCollectionView *)collectionView nodeForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline],
                                     NSForegroundColorAttributeName: [UIColor grayColor]
                                     };
    UIEdgeInsets textInsets = UIEdgeInsetsMake(11.0, 0, 11.0, 0);
    ASTextCellNode *textCellNode = [[ASTextCellNode alloc] initWithAttributes:textAttributes insets:textInsets];
    textCellNode.text = [NSString stringWithFormat:@"Section %zd", indexPath.section + 1];
    return textCellNode;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout originalItemSizeAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 200);
}

@end
