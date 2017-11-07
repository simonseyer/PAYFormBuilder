//
//  PAYDefaultSimpleLabelStyleTheme.h
//  Pods
//
//  Created by COBI on 09.04.15.
//
//

#import <Foundation/Foundation.h>
#import "PAYLabelTheme.h"

@interface PAYDefaultLabelTheme : NSObject <PAYLabelTheme>

@property (nonatomic, assign) UIEdgeInsets      insets;
@property (nonatomic, strong, nullable) UIFont  *font;
@property (nonatomic, assign) CGFloat           kerning;
@property (nonatomic, assign) CGFloat           lineSpacing;
@property (nonatomic, retain, nullable) UIColor *textColor;
@property (nonatomic, assign) BOOL              capitalize;
@property (nonatomic, assign) NSTextAlignment   textAlignment;

+ (nonnull PAYDefaultLabelTheme *)simpleTheme;
+ (nonnull PAYDefaultLabelTheme *)descriptionTheme;
+ (nonnull PAYDefaultLabelTheme *)descriptionWideTheme;
+ (nonnull PAYDefaultLabelTheme *)headerTitleTheme;
+ (nonnull PAYDefaultLabelTheme *)headerSubTitleTheme;

@end

@interface PAYDefaultLabelThemeContainer : NSObject <PAYLabelThemeContainer>

@end
