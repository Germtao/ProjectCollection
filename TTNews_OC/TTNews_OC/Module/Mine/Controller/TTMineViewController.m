//
//  TTMineViewController.m
//  TTNews_OC
//
//  Created by QDSG on 2021/3/30.
//

#import "TTMineViewController.h"
#import <SDWebImage/SDWebImage.h>
#import "TTLogin.h"

@interface TTMineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) UIImageView *headerImageView;

@end

@implementation TTMineViewController

#pragma mark - Life Cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"我的";
        self.tabBarItem.image = [UIImage imageNamed:@"home"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"home_selected"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeUI];
}

#pragma mark - private

- (void)makeUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
}

- (void)_tapImage {
    __weak typeof(self) weakSelf = self;
    if (![TTLogin sharedLogin].isLogin) {
        [[TTLogin sharedLogin] loginWithFinishBlock:^(BOOL isLogin) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            // SDK流程之后判断是否登录成功
            if (isLogin) {
                [strongSelf.tableView reloadData];
            }
        }];
    } else {
        [[TTLogin sharedLogin] logout];
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mineCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mineCell"];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        cell.textLabel.text = [TTLogin sharedLogin].isLogin ? [TTLogin sharedLogin].nickname : @"昵称";
    } else {
        cell.textLabel.text = [TTLogin sharedLogin].isLogin ? [TTLogin sharedLogin].address : @"地区";
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    [self.tableHeaderView addSubview:self.headerImageView];
    return self.tableHeaderView;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (![TTLogin sharedLogin].isLogin) {
        self.headerImageView.image = [UIImage imageNamed:@"icon"];
    } else {
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[TTLogin sharedLogin].avatarUrl]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 200;
}

#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIView *)tableHeaderView {
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        _tableHeaderView.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapImage)];
        [_tableHeaderView addGestureRecognizer:tapGesture];
    }
    return _tableHeaderView;
}

- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, 140)];
        _headerImageView.contentMode = UIViewContentModeScaleAspectFit;
        _headerImageView.clipsToBounds = YES;
    }
    return _headerImageView;
}

@end
