//
//  TTDeleteCellView.m
//  TTNews_OC
//
//  Created by QDSG on 2021/3/25.
//

#import "TTDeleteCellView.h"
#import "TTScreen.h"

@interface TTDeleteCellView ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIButton *deleteButton;

@property (nonatomic, copy) dispatch_block_t deleteBlock;

@end

@implementation TTDeleteCellView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        
        [self addSubview:self.backgroundView];
        [self addSubview:self.deleteButton];
    }
    return self;
}

- (void)showFromPoint:(CGPoint)point clickDeleteBlock:(dispatch_block_t)deleteBlock {
//    self.deleteButton.frame = CGRectMake(point.x, point.y, 0, 0);
    self.deleteButton.frame = CGRectMake(point.x - 40, point.y + 20, 100, 0);
    self.deleteBlock = [deleteBlock copy];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:1.f delay:0.f usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.deleteButton.frame = CGRectMake((self.bounds.size.width - 100) / 2, (self.bounds.size.height - 50) / 2, 100, 50);
        self.deleteButton.frame = CGRectMake(point.x - 40, point.y + 20, 100, 50);
    } completion:^(BOOL finished) {
        // 动画结束
    }];
}

- (void)dismissDeleteView {
    [self removeFromSuperview];
}

#pragma mark - action

- (void)deleteButtonClicked {
    if (self.deleteBlock) {
        self.deleteBlock();
    }
    [self dismissDeleteView];
}

#pragma mark - getter

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        _backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [_backgroundView addGestureRecognizer:({
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDeleteView)];
            tapGesture;
        })];
    }
    return _backgroundView;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.backgroundColor = [UIColor lightGrayColor];
        [_deleteButton setTitle:@"确认删除" forState:UIControlStateNormal];
        _deleteButton.layer.cornerRadius = UI(25);
        [_deleteButton addTarget:self action:@selector(deleteButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

@end
