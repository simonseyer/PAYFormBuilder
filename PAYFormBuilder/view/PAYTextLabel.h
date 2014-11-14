//
//  PAYFormLabel.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 14.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYTextLabel.h"


typedef enum {
    PAYFormTableLabelStyleSimple,
    PAYFormTableLabelStyleDescription,
    PAYFormTableLabelStyleDescriptionWide,
    PAYFormTableLabelStyleHeaderTitle,
    PAYFormTableLabelStyleHeaderSubTitle,
    PAYFormTableLabelStyleEmpty,
    PAYFormTableLabelStyleNone
} PAYFormTableLabelStyle;


/**
 *  A text label that changes it's appearence based on a style.
 */
@interface PAYTextLabel : UILabel

/**
 *  The style of the text label
 */
@property (nonatomic, assign) PAYFormTableLabelStyle style;

@property (nonatomic, assign) UIEdgeInsets simpleStyleInsets          UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) UIEdgeInsets descriptionStyleInsets     UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) UIEdgeInsets wideDescriptionStyleInsets UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) UIEdgeInsets headerStyleInsets          UI_APPEARANCE_SELECTOR;

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

/**
 *  The preferred height based on the given width and the content.
 *
 *  @param width the maximum width
 *
 *  @return the preferred height
 */
- (CGFloat)preferredHeightForWidth:(CGFloat)width;

@end
