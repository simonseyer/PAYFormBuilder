//
//  PAYSectionTheme.h
//  Pods
//
//  Created by COBI on 09.04.15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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