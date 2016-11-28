//
//  SWSettingViewController.m
//  StarWallpaper
//
//  Created by Fnoz on 16/4/14.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import "SWSettingViewController.h"
#import "SWSettingTableViewCell.h"

@interface SWSettingViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SWSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 140) / 2, 95, 140, 140)];
    logoImageView.image = [UIImage imageNamed:@"icon_shadow"];
    [self.view addSubview:logoImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, logoImageView.frame.origin.y + logoImageView.frame.size.height + 20, kScreenWidth, 30)];
    titleLabel.text = @"明星壁纸";
    titleLabel.font = SWFontOfSize(20);
    titleLabel.textColor = kSWIconWhite;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    self.view.backgroundColor = kSWBackGroundGray;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kScreenHeight / 2, kScreenWidth, 240) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = NO;
    _tableView.allowsSelection = NO;
    [_tableView registerClass:[SWSettingTableViewCell class] forCellReuseIdentifier:kSWSettingTableViewCell];
    _tableView.backgroundColor = kSWBackGroundGray;
    [self.view addSubview:_tableView];
    
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    homeBtn.frame = CGRectMake((self.view.frame.size.width - 50) * 0.5, self.view.frame.size.height - 50, 50, 50);
    homeBtn.tintColor = kSWIconWhite;
    homeBtn.imageEdgeInsets = UIEdgeInsetsMake(13, 13, 13, 13);
    [homeBtn setImage:[UIImage imageNamed:@"backDown"] forState:UIControlStateNormal];
    [homeBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homeBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWSettingTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kSWSettingTableViewCell];
    if (!cell) {
        cell = [[SWSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSWSettingTableViewCell];
    }
    switch (indexPath.row) {
        case 1:
            cell.leftImageView.image = [UIImage imageNamed:@"mail.jpg"];
            [cell.rightBtn setTitle:@"发邮件反馈 >" forState:UIControlStateNormal];
            [cell.rightBtn addTarget:self action:@selector(gotoMail) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 2:
            cell.leftImageView.image = [UIImage imageNamed:@"appStore"];
            [cell.rightBtn setTitle:@"赞美或吐槽 >" forState:UIControlStateNormal];
            [cell.rightBtn addTarget:self action:@selector(gotoStore) forControlEvents:UIControlEventTouchUpInside];
            break;
        default:
            cell.leftImageView.image = [UIImage imageNamed:@"weibo.jpg"];
            [cell.rightBtn setTitle:@"去微博反馈 >" forState:UIControlStateNormal];
            [cell.rightBtn addTarget:self action:@selector(gotoWeibo) forControlEvents:UIControlEventTouchUpInside];
            break;
    }
    return cell;
}

- (void)gotoWeibo {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://weibo.com/fnoz"]];
}

- (void)gotoMail {
    NSString *email = @"mailto:fnoz@sina.com?subject=Feedback For StarWallpaper";
    email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

- (void)gotoStore {
    NSString  *nsStringToOpen = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", @"1104673142"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:nsStringToOpen]];
}

@end
