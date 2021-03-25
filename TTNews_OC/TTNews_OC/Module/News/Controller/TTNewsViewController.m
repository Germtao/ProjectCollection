//
//  TTNewsViewController.m
//  TTNews_OC
//
//  Created by QDSG on 2021/3/24.
//

#import "TTNewsViewController.h"
#import "TTListLoader.h"
#import "TTNewsNormalCell.h"
#import "TTDeleteCellView.h"

@interface TTNewsViewController () <UITableViewDataSource, UITableViewDelegate, TTNewsNormalCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) TTListLoader *listLoader;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation TTNewsViewController

#pragma mark - Life Cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"新闻";
        self.tabBarItem.image = [UIImage imageNamed:@"home"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"home_selected"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    self.listLoader = [[TTListLoader alloc] init];
    __weak typeof(self) weakSelf = self;
    [self.listLoader loadListDataWithFinishBlock:^(BOOL success, NSArray<TTListItem *> * _Nonnull dataArray) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.dataArray = dataArray;
        [strongSelf.tableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TTNewsNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsNormalCell"];
    if (!cell) {
        cell = [[TTNewsNormalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"newsNormalCell"];
        cell.delegate = self;
    }
    [cell layoutUIWithItem:self.dataArray[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - TTNewsNormalCellDelegate

- (void)newsNormalCell:(TTNewsNormalCell *)cell clickDeleteButton:(UIButton *)deleteButton {
    TTDeleteCellView *deleteCellView = [[TTDeleteCellView alloc] initWithFrame:self.view.bounds];
    
    CGRect rect = [cell convertRect:deleteButton.frame toView:self.view];
    
    __weak typeof(self) weakSelf = self;
    [deleteCellView showFromPoint:rect.origin clickDeleteBlock:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSIndexPath *deleteIndexPath = [strongSelf.tableView indexPathForCell:cell];
        if (strongSelf.dataArray.count > deleteIndexPath.row) {
            // 删除数据
            NSMutableArray *tempArray = [strongSelf.dataArray mutableCopy];
            [tempArray removeObjectAtIndex:deleteIndexPath.row];
            strongSelf.dataArray = tempArray;
            
            // 删除 cell
            [strongSelf.tableView deleteRowsAtIndexPaths:@[deleteIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }];
}

#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
