//
//  TTFindRecommendViewController.m
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/8.
//

#import "TTFindRecommendViewController.h"
#import "TTFindRecommendViewModel.h"
#import "TTFindRecommendHeader.h"
#import <Masonry/Masonry.h>
#import "TTFindRecommendHelper.h"

#import "TTFindCellFactory.h"

@interface TTFindRecommendViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) TTFindRecommendViewModel *viewModel;

@property (nonatomic, strong) TTFindRecommendHeader *headerView;

@property (nonatomic, strong) UIView *header;

@end

@implementation TTFindRecommendViewController

- (void)dealloc {
    [[TTFindRecommendHelper sharedInstance] stopAllTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindViewModel];
}

- (void)bindViewModel {
    @weakify(self);
    [self.viewModel.updateContentSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
        
        self.headerView.focusImages = self.viewModel.recommendModel.focusImages;
        self.headerView.discoveryColumns = self.viewModel.hotGuessModel.discoveryColumns;
        
        [[TTFindRecommendHelper sharedInstance] startTimer:TTFindRecommendTimer_Banner];
        [[TTFindRecommendHelper sharedInstance] startTimer:TTFindRecommendTimer_Live];
    }];
    
    [self.viewModel refreshDataSource];
}

// MARK: - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == TTFindRecommendSection_Recommend) {
        TTFindFeeCell *cell = (TTFindFeeCell *)[TTFindCellFactory createCell:tableView style:TTFindCellStyle_Fee];
        cell.recommendAlbum = self.viewModel.recommendModel.editorRecommendAlbums;
        return cell;
    } else if (indexPath.section == TTFindRecommendSection_Live) {
        if (self.viewModel.liveModel.data.count != 0) {
            TTFindLiveCell *cell = (TTFindLiveCell *)[TTFindCellFactory createCell:tableView style:TTFindCellStyle_Live];
            cell.liveModel = self.viewModel.liveModel;
            return cell;
        } else {
            return [TTFindBaseCell findCell:tableView];;
        }
    } else if (indexPath.section == TTFindRecommendSection_Special) {
        if (self.viewModel.recommendModel.specialColumn.list.count != 0) {
            TTFindSpecialCell *cell = (TTFindSpecialCell *)[TTFindCellFactory createCell:tableView style:TTFindCellStyle_Special];
            cell.specialColumn = self.viewModel.recommendModel.specialColumn;
            return cell;
        } else {
            return [TTFindBaseCell findCell:tableView];
        }
    } else if (indexPath.section == TTFindRecommendSection_More) {
        TTFindMoreCell *cell = (TTFindMoreCell *)[TTFindCellFactory createCell:tableView style:TTFindCellStyle_More];
        return cell;
    }
    else {
        return [TTFindBaseCell findCell:tableView];
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel heightForRowAtIndexPath:indexPath];
}


#pragma mark - Getter

- (TTFindRecommendViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[TTFindRecommendViewModel alloc] initWithRACSubjectName:kFindRecommendUpdateSignalName];
    }
    return _viewModel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *table = [[UITableView alloc] init];
        table.delegate = self;
        table.dataSource = self;
        table.separatorStyle = UITableViewCellSeparatorStyleNone;
        table.tableHeaderView = [self header];
        [self.view addSubview:table];
        [table mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        _tableView = table;
    }
    return _tableView;
}

- (UIView *)header {
    if (!_header) {
        _header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
        [_header addSubview:self.headerView];
    }
    return _header;
}

- (TTFindRecommendHeader *)headerView {
    if (!_headerView) {
        _headerView = [TTFindRecommendHeader findRecommendHeader];
        _headerView.frame = CGRectMake(0, 0, kScreenWidth, 250);
    }
    return _headerView;
}

@end
