//
//  PAYHeaderView.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 28.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYHeaderView.h"
#import "PAYStyle.h"

@implementation PAYHeaderView {
@private
    BOOL _hasLoadedConstraints;
}

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
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[self]-(<=1)-[iconView]"
                                                                 options:NSLayoutFormatAlignAllCenterX
                                                                 metrics:nil
                                                                   views:@{@"self" : self, @"iconView" : self.iconView}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin@200-[iconView]"
                                                                 options:0
                                                                 metrics:@{@"margin" : @(PAYStyle.tableTheme.headerIconTopMargin)}
                                                                   views:@{@"self" : self, @"iconView" : self.iconView}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[self]-(<=1)-[titleLabel]"
                                                                 options:NSLayoutFormatAlignAllCenterX
                                                                 metrics:nil
                                                                   views:@{@"self" : self, @"titleLabel" : self.titleLabel}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[iconView]-margin@200-[titleLabel]"
                                                                 options:0
                                                                 metrics:@{@"margin" : @(PAYStyle.tableTheme.headerTitleTopMargin)}
                                                                   views:@{@"iconView" : self.iconView, @"titleLabel" : self.titleLabel}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[self]-(<=1)-[subTitleLabel]"
                                                                 options:NSLayoutFormatAlignAllCenterX
                                                                 metrics:nil
                                                                   views:@{@"self" : self, @"subTitleLabel" : self.subTitleLabel}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[titleLabel]-margin@200-[subTitleLabel]"
                                                                 options:0
                                                                 metrics:@{@"margin" : @(PAYStyle.tableTheme.headerSubTitleTopMargin)}
                                                                   views:@{@"titleLabel" : self.titleLabel, @"subTitleLabel" : self.subTitleLabel}]];
}

- (CGSize)sizeThatFits:(CGSize)size {
    return [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
}

- (void)updateConstraints {
    if (!_hasLoadedConstraints) {
        _hasLoadedConstraints = YES;
    }
    [super updateConstraints];
}

- (BOOL)needsUpdateConstraints {
    return YES;
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
