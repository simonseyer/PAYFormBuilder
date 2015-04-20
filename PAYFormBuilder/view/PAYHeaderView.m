//
//  PAYHeaderView.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 28.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYHeaderView.h"
#import "UIColor+PAYHex.h"

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
    self.titleLabel = [[PAYTextLabel alloc]initWithFrame:self.frame];
    self.titleLabel.style = PAYFormTableLabelStyleHeaderTitle;
    self.subTitleLabel = [[PAYTextLabel alloc]initWithFrame:self.frame];
    self.subTitleLabel.style = PAYFormTableLabelStyleHeaderSubTitle;
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.subTitleLabel];
    [self addSubview:self.iconView];
    
    self.iconTopMargin = 32;
    self.titleTopMargin = 21;
    self.subTitleTopMargin = 14;
    
    self.tintColor = [UIColor colorFromHex:0xFF008D79];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger y = 0;
    if (self.iconImage) {
        CGSize iconImageSize = self.iconView.image.size;
        self.iconView.frame = CGRectMake((self.frame.size.width - iconImageSize.width) / 2, self.iconTopMargin,
                                         iconImageSize.width, iconImageSize.height);
        y = CGRectGetMaxY(self.iconView.frame);
    } else {
        self.iconView.frame = CGRectZero;
    }
    
    if (self.titleLabel.text) {
        self.titleLabel.frame = CGRectMake(0, y + self.titleTopMargin,
                                           self.frame.size.width, 0);
        [self.titleLabel sizeToFit];
        y = CGRectGetMaxY(self.titleLabel.frame);
    } else {
        self.titleLabel.frame = CGRectZero;
    }
    
    if (self.subTitleLabel.text) {
        self.subTitleLabel.frame = CGRectMake(0, y + self.subTitleTopMargin,
                                              self.frame.size.width, 0);
        [self.subTitleLabel sizeToFit];
    } else {
        self.subTitleLabel.frame = CGRectZero;
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
    [self sizeToFit];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
    [self sizeToFit];
}

- (void)setSubTitle:(NSString *)subTitle {
    _subTitle = subTitle;
    self.subTitleLabel.text = subTitle;
    [self sizeToFit];
}

- (void)tintColorDidChange {
    self.subTitleLabel.textColor = self.tintColor;
}

@end
