//
//  PAYHeaderView.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 28.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYHeaderView.h"
#import "PAYStyle.h"

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
    self.titleLabel = [[PAYTextLabel alloc]initWithStyle:PAYFormTableLabelStyleHeaderTitle];
    self.subTitleLabel = [[PAYTextLabel alloc]initWithStyle:PAYFormTableLabelStyleHeaderSubTitle];
    
    self.iconView.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.subTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.subTitleLabel];
    [self addSubview:self.iconView];
    
    self.tintColor = PAYStyle.tableTheme.headerTintColor;

    [self addConstraints:@[[self.iconView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
                           [self.iconView.topAnchor constraintEqualToAnchor:self.topAnchor constant:PAYStyle.tableTheme.headerIconTopMargin],
                           [self.titleLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
                           [self.titleLabel.topAnchor constraintEqualToAnchor:self.iconView.bottomAnchor constant:PAYStyle.tableTheme.headerTitleTopMargin],
                           [self.subTitleLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor],
                           [self.subTitleLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor],
                           [self.subTitleLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:PAYStyle.tableTheme.headerSubTitleTopMargin],
                           [self.subTitleLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:PAYStyle.tableTheme.headerBottomMargin]]];
}

- (void)setIconImage:(UIImage *)iconImage {
    _iconImage = iconImage;
    self.iconView.image = iconImage;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setSubTitle:(NSString *)subTitle {
    _subTitle = subTitle;
    self.subTitleLabel.text = subTitle;
}

- (void)tintColorDidChange {
    self.subTitleLabel.textColor = self.tintColor;
}

@end
