//
//  PAYSectionTheme.h
//  Pods
//
//  Created by COBI on 09.04.15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 * The section theme definition, that is used in the SectionBuilder
 * to provide default styles used to layout the elements inside of one
 * row.
 */
@protocol PAYSectionTheme <NSObject>

- (CGFloat)horizontalMargin;
- (CGFloat)labelWidth;
- (CGFloat)labelFieldSpacing;
- (CGFloat)disclosureMarginRight;
- (CGFloat)iconSize;
- (CGFloat)iconMargin;
- (CGFloat)iconMarginLeft;
- (NSUInteger)textViewLineCount;
- (UIColor *)textColor;
- (UIColor *)placeholderColor;
- (UIColor *)buttonPrimaryTextColor;
- (UIColor *)buttonHilightTextColor;
- (UIColor *)buttonDisabledTextColor;
- (UIColor *)buttonDetailTextColor;

@end