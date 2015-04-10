//
//  PAYSectionTheme.h
//  Pods
//
//  Created by COBI on 09.04.15.
//
//

#import <Foundation/Foundation.h>
#import "PAYSectionTheme.h"

@interface PAYDefaultSectionTheme : NSObject <PAYSectionTheme>

@property (nonatomic, assign) CGFloat       horizontalMargin;
@property (nonatomic, assign) CGFloat       labelWidth;
@property (nonatomic, assign) CGFloat       labelFieldSpacing;
@property (nonatomic, assign) CGFloat       disclosureMarginRight;
@property (nonatomic, assign) CGFloat       iconSize;
@property (nonatomic, assign) CGFloat       iconMargin;
@property (nonatomic, assign) CGFloat       iconMarginLeft;
@property (nonatomic, assign) NSUInteger    textViewLineCount;
@property (nonatomic, retain) UIColor      *textColor;
@property (nonatomic, retain) UIColor      *placeholderColor;
@property (nonatomic, retain) UIColor      *buttonPrimaryTextColor;
@property (nonatomic, retain) UIColor      *buttonHilightTextColor;
@property (nonatomic, retain) UIColor      *buttonDisabledTextColor;
@property (nonatomic, retain) UIColor      *buttonDetailTextColor;

@end
