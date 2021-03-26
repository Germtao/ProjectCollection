//
//  TTVideoViewController.m
//  TTNews_OC
//
//  Created by QDSG on 2021/3/26.
//

#import "TTVideoViewController.h"
#import "TTVideoCoverCell.h"

@interface TTVideoViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation TTVideoViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"视频";
        self.tabBarItem.image = [UIImage imageNamed:@"video"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"video_selected"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeUI];
}

#pragma mark - setupUI

- (void)makeUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TTVideoCoverCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TTVideoCoverCell" forIndexPath:indexPath];
    [cell layoutWithVideoUrl:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4" videoCover:@"videoCover"];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
#pragma mark - 自定义 itemSize

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.item % 3 == 0) {
//        return CGSizeMake(self.view.frame.size.width, 100);
//    } else {
//        return CGSizeMake((self.view.frame.size.width - 10) / 2, 300);
//    }
//}

#pragma mark - getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.width / 16 * 9 + 60);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        // inset 自动适配
//        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[TTVideoCoverCell class] forCellWithReuseIdentifier:@"TTVideoCoverCell"];
    }
    return _collectionView;
}

@end
