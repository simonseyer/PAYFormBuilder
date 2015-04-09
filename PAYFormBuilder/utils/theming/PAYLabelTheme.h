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

@protocol PAYLabelTheme <NSObject>

- (UIEdgeInsets)insets;
- (CGFloat)fontSize;
- (CGFloat)kerning;
- (CGFloat)lineSpacing;
- (UIColor *)textColor;
- (BOOL)uppercased;
- (NSTextAlignment)textAlignment;

@end

@protocol PAYLabelThemeContainer <NSObject>

- (id<PAYLabelTheme>)forStyle:(PAYFormTableLabelStyle)style;

@end

