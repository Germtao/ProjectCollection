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

@interface TTFindRecommendViewController () <UITableViewDelegate, UITableViewDataSource, TTFindBaseCellDelegate>

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
    Log(@"find recommend view did load.");
    [self bindViewModel];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[TTStopWatchTool sharedInstance] splitWithDescription:@"第一个页面渲染耗时"];
    [[TTStopWatchTool sharedInstance] stopAndPresentResultsThenReset:self];
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
        cell.delegate = self;
        cell.recommendAlbum = self.viewModel.recommendModel.editorRecommendAlbums;
        return cell;
    } else if (indexPath.section == TTFindRecommendSection_GuessULike) {
        TTFindFeeCell *cell = (TTFindFeeCell *)[TTFindCellFactory createCell:tableView style:TTFindCellStyle_Fee];
        cell.delegate = self;
        cell.guessULike = self.viewModel.hotGuessModel.guess;
        return cell;
    } else if (indexPath.section == TTFindRecommendSection_CityColumn) {
        TTFindFeeCell *cell = (TTFindFeeCell *)[TTFindCellFactory createCell:tableView style:TTFindCellStyle_Fee];
        cell.delegate = self;
        cell.cityColumn = self.viewModel.hotGuessModel.cityColumn;
        return cell;
    } else if (indexPath.section == TTFindRecommendSection_Hot) {
        TTFindFeeCell *cell = (TTFindFeeCell *)[TTFindCellFactory createCell:tableView style:TTFindCellStyle_Fee];
        cell.hotRecommendItem = [self.viewModel.hotGuessModel.hotRecommends.list objectAtIndex:indexPath.row];
        cell.delegate = self;
        return cell;
    } else if (indexPath.section == TTFindRecommendSection_Live) {
        TTFindLiveCell *cell = (TTFindLiveCell *)[TTFindCellFactory createCell:tableView style:TTFindCellStyle_Live];
        cell.liveModel = self.viewModel.liveModel;
        cell.delegate = self;
        return cell;
    } else if (indexPath.section == TTFindRecommendSection_Special) {
        TTFindSpecialCell *cell = (TTFindSpecialCell *)[TTFindCellFactory createCell:tableView style:TTFindCellStyle_Special];
        cell.specialColumn = self.viewModel.recommendModel.specialColumn;
        cell.delegate = self;
        return cell;
    } else if (indexPath.section == TTFindRecommendSection_More) {
        TTFindMoreCell *cell = (TTFindMoreCell *)[TTFindCellFactory createCell:tableView style:TTFindCellStyle_More];
        return cell;
    } else {
        return [TTFindBaseCell findCell:tableView];
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel heightForRowAtIndexPath:indexPath];
}

#pragma mark - TTFindBaseCellDelegate
- (void)findCellStyleFeeDidMoreClicked:(TTFindFeeCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    switch (indexPath.section) {
        case TTFindRecommendSection_Recommend:
            break;
        default:
            break;
    }
}

- (void)findCellStyleLive:(TTFindLiveCell *)cell didMoreClickedWithModel:(TTFindLiveModel *)model {
    
}

- (void)findCellStyleSpecial:(TTFindSpecialCell *)cell didMoreClickedWithModel:(TTFindSpecialColumnModel *)model {
    
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
