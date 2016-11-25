//
//  SWSearchViewController.m
//  StarWallpaper
//
//  Created by Fnoz on 16/4/4.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import "SWSearchViewController.h"
#import "SWConstDef.h"
#import "SWCommonUtil.h"
#import "SWSearchSuggestTableViewCell.h"
#import "SWSearchUtil.h"
#import "SWSearchSuggestDO.h"

#define kSearchFieldHeight 52.0f
static NSString *const kSWSearchSuggestTableViewCell = @"SWSearchSuggestTableViewCell";

@interface SWSearchViewController () <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, SWSearchSuggestTableViewCellDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) SWSelectedKeywordBlock block;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *suggestArray;

@end

@implementation SWSearchViewController

+ (void)presentWithKeyword:(NSString *)keyword selectedKeywordBlock:(SWSelectedKeywordBlock)block {
    SWSearchViewController *vc = [SWSearchViewController sharedInstance];
    vc.keyword = keyword;
    vc.block = block;
    [SWCurrentVC presentViewController:vc animated:YES completion:nil];
}

+ (SWSearchViewController *)sharedInstance {
    static SWSearchViewController *_sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[SWSearchViewController alloc] init];
    });
    return _sharedInstance;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kSWBackGroundGray;
    
    _suggestArray = [SWSearchUtil getSuggestionArray];
    
//    UIView *inputAngBtnBgView = [[UIView alloc] initWithFrame:CGRectMake(10 + (kSearchFieldHeight - 16), 8, self.view.frame.size.width - 20 - (kSearchFieldHeight - 16) * 2, kSearchFieldHeight - 16)];
//    inputAngBtnBgView.backgroundColor = [UIColor clearColor];
//    inputAngBtnBgView.layer.cornerRadius = 5.0f;
//    [self.view addSubview:inputAngBtnBgView];
//    
//    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(11, 9, inputAngBtnBgView.frame.size.height - 2, inputAngBtnBgView.frame.size.height - 2)];
//    logoView.image = [UIImage imageNamed:@"Launch"];
//    logoView.layer.shadowColor = [UIColor lightGrayColor].CGColor;//shadowColor阴影颜色
//    logoView.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
//    logoView.layer.shadowOpacity = 1;//阴影透明度，默认0
//    logoView.layer.shadowRadius = 3;//阴影半径，默认3
//    [self.view addSubview:logoView];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(12, 6, self.view.frame.size.width - kSearchFieldHeight - 12, kSearchFieldHeight - 6 * 2)];
    self.textField.backgroundColor = kSWIconWhite;
    self.textField.placeholder = @"你的明星壁纸，偶像在身边";
    self.textField.font = SWFontOfSize(20);
    _textField.textColor = kSWFontGreen;
    self.textField.delegate = self;
    _textField.text = _keyword;
    _textField.layer.cornerRadius = 10;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    self.textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, self.textField.frame.size.height)];
    self.textField.returnKeyType = UIReturnKeySearch;
    [self.view addSubview:self.textField];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    searchBtn.frame = CGRectMake(self.view.frame.size.width - kSearchFieldHeight + 3, 6, kSearchFieldHeight - 6 * 2, kSearchFieldHeight - 6 * 2);
    searchBtn.tintColor = kSWIconWhite;
    [searchBtn setImage:[UIImage imageNamed:@"goToSearch"] forState:UIControlStateNormal];
    searchBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 4, 3, 4);
    [searchBtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kSearchFieldHeight, self.view.frame.size.width, self.view.frame.size.height - (0 + kSearchFieldHeight) - 8) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = NO;
    [_tableView registerClass:[SWSearchSuggestTableViewCell class] forCellReuseIdentifier:kSWSearchSuggestTableViewCell];
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    homeBtn.frame = CGRectMake((self.view.frame.size.width-50) * 0.5, self.view.frame.size.height - 50, 50, 50);
    homeBtn.tintColor = kSWIconWhite;
    homeBtn.imageEdgeInsets = UIEdgeInsetsMake(13, 13, 13, 13);
    [homeBtn setImage:[UIImage imageNamed:@"backDown"] forState:UIControlStateNormal];
    [homeBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homeBtn];
    
    self.view.backgroundColor = kSWBackGroundGray;
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)search {
    SWSelectedKeywordBlock block = _block;
    block(_textField.text);
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark SWSearchSuggestTableViewCellDelegate
- (void)clickWithKeyword:(NSString *)keyword
{
    _textField.text = keyword;
    [self search];
}

#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (![self.textField.text isEqualToString:@""])
    {
        [self search];
    }
    else
    {
        [self.textField endEditing:YES];
    }
    return YES;
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _suggestArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 25)];
    SWSearchSuggestDO *item = [_suggestArray objectAtIndex:section];
    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, self.view.frame.size.width, 18)];
    typeLabel.text = item.type;
    typeLabel.textColor = kSWFontGreen;
    typeLabel.font = SWFontOfSize(18);
    [header addSubview:typeLabel];
    return header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWSearchSuggestTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kSWSearchSuggestTableViewCell];
    if (!cell) {
        cell = [[SWSearchSuggestTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSWSearchSuggestTableViewCell];
    }
    [cell setData:[_suggestArray objectAtIndex:indexPath.section]];
    cell.delegate = self;
    return cell;
}

@end
