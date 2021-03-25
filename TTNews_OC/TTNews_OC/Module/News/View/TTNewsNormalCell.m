//
//  TTNewsNormalCell.m
//  TTNews_OC
//
//  Created by QDSG on 2021/3/25.
//

#import "TTNewsNormalCell.h"
#import "TTListItem.h"
#import <UIImageView+WebCache.h>

@interface TTNewsNormalCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *sourceLabel;
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIImageView *rightImageView;

@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation TTNewsNormalCell

#pragma mark - life cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self makeUI];
    }
    return self;
}

#pragma mark - setup

- (void)makeUI {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.sourceLabel];
    [self.contentView addSubview:self.commentLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.rightImageView];
    [self.contentView addSubview:self.deleteButton];
}

- (void)layoutUIWithItem:(TTListItem *)item {
    BOOL hasRead = [[NSUserDefaults standardUserDefaults] boolForKey:item.uniqueKey];
    self.titleLabel.textColor = hasRead ? [UIColor lightGrayColor] : [UIColor blackColor];
    
    self.titleLabel.text = item.title;
    
    self.sourceLabel.text = item.authorName;
    [self.sourceLabel sizeToFit];
    
    self.commentLabel.text = item.category;
    [self.commentLabel sizeToFit];
    self.commentLabel.frame = CGRectMake(self.sourceLabel.frame.origin.x + self.sourceLabel.frame.size.width + 15,
                                         self.commentLabel.frame.origin.y,
                                         self.commentLabel.frame.size.width,
                                         self.commentLabel.frame.size.height);
    
    self.timeLabel.text = item.date;
    [self.timeLabel sizeToFit];
    self.timeLabel.frame = CGRectMake(self.commentLabel.frame.origin.x + self.commentLabel.frame.size.width + 15,
                                      self.timeLabel.frame.origin.y,
                                      self.timeLabel.frame.size.width,
                                      self.timeLabel.frame.size.height);
    
    self.deleteButton.frame = CGRectMake(self.timeLabel.frame.origin.x + self.timeLabel.frame.size.width + 15,
                                         self.deleteButton.frame.origin.y,
                                         self.deleteButton.frame.size.width,
                                         self.deleteButton.frame.size.height);
    
    NSThread *downloadImageThread = [[NSThread alloc] initWithBlock:^{
        //
    }];
    
    downloadImageThread.name = @"downloadImageThread";
    [downloadImageThread start];
    
    dispatch_queue_global_t downloadQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_main_t mainQueue = dispatch_get_main_queue();
    
    dispatch_async(downloadQueue, ^{
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:item.picUrl]]];
        dispatch_async(mainQueue, ^{
            self.rightImageView.image = image;
        });
    });
    
//    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:item.picUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        // TODO: 处理业务逻辑，通过 cacheType 判断图片是否命中缓存
//    }];
}

- (void)deleteButtonClicked {
    if (self.delegate && [self.delegate respondsToSelector:@selector(newsNormalCell:clickDeleteButton:)]) {
        [self.delegate newsNormalCell:self clickDeleteButton:self.deleteButton];
    }
}

#pragma mark - getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 270, 50)];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel *)sourceLabel {
    if (!_sourceLabel) {
        _sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 50, 20)];
        _sourceLabel.font = [UIFont systemFontOfSize:12];
        _sourceLabel.textColor = [UIColor grayColor];
    }
    return _sourceLabel;
}

- (UILabel *)commentLabel {
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 70, 50, 20)];
        _commentLabel.font = [UIFont systemFontOfSize:12];
        _commentLabel.textColor = [UIColor grayColor];
    }
    return _commentLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 70, 50, 20)];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor grayColor];
    }
    return _timeLabel;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width - 100 - 15, 15, 100, 70)];
    }
    return _rightImageView;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width - 100 - 15 - 10 - 10, 70, 10, 10)];
        [_deleteButton setTitle:@"X" forState:UIControlStateNormal];
        [_deleteButton setTitle:@"V" forState:UIControlStateHighlighted];
        [_deleteButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

@end
