//
//  TTIconButtonView.m
//  TTXMLY_OC
//
//  Created by QDSG on 2021/3/10.
//

#import "TTIconButtonView.h"
#import <UIImageView+YYWebImage.h>

@interface TTIconButtonView ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@end

@implementation TTIconButtonView

+ (instancetype)iconButtonView {
    NSString *identifier = NSStringFromClass([self class]);
    return [[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil].firstObject;
}

- (void)configWithTitle:(NSString *)title localImageName:(NSString *)imageName {
    self.titleLabel.text = title;
    self.imageView.image = kIMAGE(imageName);
}

- (void)setDetailModel:(TTFindDiscoverDetailModel *)detailModel {
    _detailModel = detailModel;
    
    self.titleLabel.text = detailModel.title;
    
    [self.imageView yy_setImageWithURL:[NSURL URLWithString:detailModel.coverPath] options:YYWebImageOptionSetImageWithFadeAnimation];
}

@end
