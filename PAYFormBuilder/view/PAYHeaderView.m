//
//  PAYHeaderView.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 28.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYHeaderView.h"

@implementation PAYHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeVars];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initializeVars];
    }
    return self;
}

- (void)initializeVars {
    self.iconView = [UIImageView new];
    
    self.titleLabel = [PAYTextLabel new];
    self.titleLabel.adjustsFontSizeToFitWidth = NO;
    self.titleLabel.textColor                 = UIColor.blackColor;
    
    self.subTitleLabel = [PAYTextLabel new];
    self.subTitleLabel.adjustsFontSizeToFitWidth = NO;
    self.subTitleLabel.textColor                 = self.tintColor;
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.subTitleLabel];
    [self addSubview:self.iconView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    {
        CGSize iconImageSize = self.iconView.image.size;
        self.iconView.frame = CGRectMake((self.frame.size.width - iconImageSize.width) / 2, 32,
                                         iconImageSize.width, iconImageSize.height);
    }
    
    {
        if (self.titleLabel.text) {
            CGRect labelRect         = CGRectMake(0, CGRectGetMaxY(self.iconView.frame) + 21, self.frame.size.width, 0);
            self.titleLabel.frame    = labelRect;
            [self.titleLabel sizeToFit];
        } else {
            self.titleLabel.frame = CGRectZero;
        }
    }
    
    {
        if (self.subTitleLabel.text) {
            CGRect labelRect            = self.subTitleLabel.frame;
            labelRect.origin.y          = CGRectGetMaxY(self.titleLabel.frame) + 14;
            labelRect.size.height       = [self.subTitleLabel preferredHeightForWidth:labelRect.size.width];
            self.subTitleLabel.frame    = labelRect;
        } else {
            self.subTitleLabel.frame = CGRectZero;
        }
    }
}

- (CGSize)sizeThatFits:(CGSize)size {
    [self layoutSubviews];
    CGSize fitSize = size;
    
    if (self.subTitleLabel.frame.size.height > 0) {
        fitSize.height = CGRectGetMaxY(self.subTitleLabel.frame);
    } else if(self.titleLabel.frame.size.height > 0) {
        fitSize.height = CGRectGetMaxY(self.titleLabel.frame);
    } else {
        fitSize.height = CGRectGetMaxY(self.iconView.frame);
    }
    
    return fitSize;
}

- (void)setIconImage:(UIImage *)iconImage {
    _iconImage = iconImage;
    
    self.iconView.image = iconImage;
    [self layoutIfNeeded];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:title];
    
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.alignment                = NSTextAlignmentCenter;
    UIFont *font                   = [UIFont fontWithName:RPDefaultLightFontName size:24];
    
    NSInteger strLength = [attrText length];
    [attrText addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, strLength)];
    [attrText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, strLength)];
    [attrText addAttribute:NSKernAttributeName value:@1.05f range:NSMakeRange(0, strLength)];
    
    self.titleLabel.attributedText = attrText;
    [self layoutIfNeeded];
}

- (void)setSubTitle:(NSString *)subTitle {
    _subTitle = subTitle;
    
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:subTitle];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment                = NSTextAlignmentCenter;
    UIFont *font                   = [UIFont fontWithName:RPDefaultFontName size:13];
    
    NSInteger strLength = [attrText length];
    
    [attrText addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, strLength)];
    [attrText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, strLength)];
    [attrText addAttribute:NSKernAttributeName value:@1.15 range:NSMakeRange(0, strLength)];
    
    self.subTitleLabel.attributedText = attrText;
    [self layoutIfNeeded];
}

@end
