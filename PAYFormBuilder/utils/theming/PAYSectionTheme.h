//
//  PAYSectionTheme.h
//  Pods
//
//  Created by COBI on 09.04.15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PAYFormButton.h"

/*
 * The section theme definition, that is used in the SectionBuilder
 * to provide default styles used to layout the elements inside of one
 * row.
 */
@protocol PAYSectionTheme <NSObject>

- (CGFloat)horizontalMargin;
- (BOOL)fixedLabelWidth;
- (CGFloat)labelWidth;
- (NSTextAlignment)fieldTextAlignment;
- (BOOL)fixedSeperatorInset;
- (UIEdgeInsets)seperatorInset;
- (CGFloat)labelFieldSpacing;
- (CGFloat)disclosureMarginRight;
- (CGFloat)iconSize;
- (CGFloat)iconMargin;
- (CGFloat)iconMarginLeft;
- (NSUInteger)textViewLineCount;
- (NSUInteger)textViewMaxLineCount;
- (UIColor *)textColor;
- (UIColor *)errorTextColor;
- (UIColor *)disabledTextColor;
- (UIColor *)placeholderColor;
- (UIColor *)buttonTextColorForStyle:(PAYFormButtonStyle)style;
- (UIColor *)buttonDetailTextColor;

@end
