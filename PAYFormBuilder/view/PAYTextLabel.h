//
//  PAYFormLabel.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 14.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYTextLabel.h"
#import "PAYFormBuilder.h"


@interface PAYTextLabel : UILabel

@property (nonatomic, assign) PAYFormTableLabelStyle style;

@property (nonatomic, assign) UIEdgeInsets simpleStyleInsets          UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) UIEdgeInsets descriptionStyleInsets     UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) UIEdgeInsets wideDescriptionStyleInsets UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign) CGFloat simpleStyleFontSize           UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat descriptionStyleFontSize      UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat headerTitleStyleFontSize      UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat headerSubTitleStyleFontSize   UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign) CGFloat descriptionStyleKerning     UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat headerTitleStyleKerning     UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat headerSubTitleStyleKerning  UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign) CGFloat descriptionStyleLineSpacing UI_APPEARANCE_SELECTOR;

@property (nonatomic, retain) UIColor *simpleStyleTextColor      UI_APPEARANCE_SELECTOR;
@property (nonatomic, retain) UIColor *descriptionStyleTextColor UI_APPEARANCE_SELECTOR;


- (CGFloat)preferredHeightForWidth:(CGFloat)width;

@end
