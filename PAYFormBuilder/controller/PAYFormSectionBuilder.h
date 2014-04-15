//
//  PAYFormSectionBuilder.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 31.10.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYFormSection.h"
#import <SZTextView/SZTextView.h>

@interface PAYFormSectionBuilder : NSObject <PAYSectionBuilder>

@property (nonatomic, assign) CGFloat       defaultHorzMargin               UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat       defaultLabelWidth               UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat       defaultLabelFieldSpace          UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat       defaultDisclosureRightMargin    UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat       defaultDisclosureLeftMargin     UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat       defaultIconSize                 UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat       defaultIconMargin               UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat       defaultLeftIconMargin           UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) NSUInteger    defaultFontSize                 UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) NSUInteger    defaultTextViewLineCount        UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) UIColor      *defaultTextColor                UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) UIColor      *defaultPlaceholderColor         UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) UIColor      *defaultButtonPrimaryTextColor   UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) UIColor      *defaultButtonHilightTextColor   UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) UIColor      *defaultButtonDisabledTextColor  UI_APPEARANCE_SELECTOR;


@property (nonatomic, retain) PAYFormSection *section;
@property (nonatomic, assign) CGRect defaultBounds;

- (id)initWithFormSection:(PAYFormSection *)section defaultCellBounds:(CGRect)defaultBounds;

- (UILabel *)defaultLabelInRect:(CGRect)defaultBounds;
- (UITextField *)defaultTextField;
- (SZTextView *)defaultTextView;

@end
