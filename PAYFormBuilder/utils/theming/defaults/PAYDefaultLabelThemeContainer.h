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
@property (nonatomic, assign) UIFont           *font;
@property (nonatomic, assign) CGFloat           kerning;
@property (nonatomic, assign) CGFloat           lineSpacing;
@property (nonatomic, retain) UIColor           *textColor;
@property (nonatomic, assign) BOOL              capitalize;
@property (nonatomic, assign) NSTextAlignment   textAlignment;

+ (PAYDefaultLabelTheme *)simpleTheme;
+ (PAYDefaultLabelTheme *)descriptionTheme;
+ (PAYDefaultLabelTheme *)descriptionWideTheme;
+ (PAYDefaultLabelTheme *)headerTitleTheme;
+ (PAYDefaultLabelTheme *)headerSubTitleTheme;

@end

@interface PAYDefaultLabelThemeContainer : NSObject <PAYLabelThemeContainer>

@end
