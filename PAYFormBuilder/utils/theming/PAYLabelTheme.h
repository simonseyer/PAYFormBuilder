//
//  PAYLabelTheme.h
//  Pods
//
//  Created by COBI on 09.04.15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PAYTextLabel.h"

/*
 * The label theme definition, that is used in the PAYTextLabel
 * to provide default styles used to style the text.
 */
@protocol PAYLabelTheme <NSObject>

- (UIEdgeInsets)insets;
- (UIFont *)font;
- (CGFloat)kerning;
- (CGFloat)lineSpacing;
- (UIColor *)textColor;
- (BOOL)capitalize;
- (NSTextAlignment)textAlignment;

@end

/*
 * The label theme container definition, that is used to store
 * the different styles of the PAYTextLabel.
 */
@protocol PAYLabelThemeContainer <NSObject>

/*
 * Get the theme for the given label style. By default, the defintions 
 * in the PAYDefaultLabelThemeContainer class are returned.
 *
 * @param style the label style (`PAYFormTableLabelStyleEmpty` and
 *                                `PAYFormTableLabelStyleNone` are not supported)
 *
 * @return the label theme
 */
- (id<PAYLabelTheme>)forStyle:(PAYFormTableLabelStyle)style;

/*
 * Set the theme for the given label style.
 *
 * @param theme the theme to set
 * @param style the label style (`PAYFormTableLabelStyleEmpty` and
 *                                `PAYFormTableLabelStyleNone` are not supported)
 *
 * @return the label theme
 */
- (void)setTheme:(id<PAYLabelTheme>) theme forStyle:(PAYFormTableLabelStyle)style;

@end

