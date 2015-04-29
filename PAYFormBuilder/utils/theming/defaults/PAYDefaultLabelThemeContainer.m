//
//  PAYDefaultSimpleLabelStyleTheme.m
//  Pods
//
//  Created by COBI on 09.04.15.
//
//

#import "PAYDefaultLabelThemeContainer.h"
#import "UIColor+PAYHex.h"

@implementation PAYDefaultLabelTheme

+ (PAYDefaultLabelTheme *)simpleTheme {
    PAYDefaultLabelTheme *theme = [PAYDefaultLabelTheme new];
    theme.insets         = UIEdgeInsetsMake(32, 15, 8, 0);
    theme.font           = [UIFont fontWithName:@"Helvetica" size:14];
    theme.kerning        = 0.0f;
    theme.lineSpacing    = 1.0f;
    theme.textColor      = [UIColor colorFromHex:0xFF6D6D72];
    theme.capitalize     = YES;
    theme.textAlignment  = NSTextAlignmentNatural;
    return theme;
}

+ (PAYDefaultLabelTheme *)descriptionTheme {
    PAYDefaultLabelTheme *theme = [PAYDefaultLabelTheme new];
    theme.insets        = UIEdgeInsetsMake(36, 21, 8, 21);
    theme.font          = [UIFont fontWithName:theme.font.fontName size:13];;
    theme.kerning       = 0.15f;
    theme.lineSpacing   = 4.0f;
    theme.textColor     = [UIColor colorFromHex:0xFF6A6A6A];
    theme.capitalize    = NO;
    theme.textAlignment = NSTextAlignmentCenter;
    return theme;
}

+ (PAYDefaultLabelTheme *)descriptionWideTheme {
    PAYDefaultLabelTheme *theme = [self descriptionTheme];
    theme.insets = UIEdgeInsetsMake(36, 21, 8, 36);
    return theme;
}

+ (PAYDefaultLabelTheme *)headerTitleTheme {
    PAYDefaultLabelTheme *theme = [self simpleTheme];
    theme.insets        = UIEdgeInsetsMake(0, 21, 0, 21);
    theme.font          = [UIFont fontWithName:theme.font.fontName size:24];
    theme.kerning       = 1.05f;
    theme.capitalize    = NO;
    theme.textAlignment = NSTextAlignmentCenter;
    return theme;
}

+ (PAYDefaultLabelTheme *)headerSubTitleTheme {
    PAYDefaultLabelTheme *theme =[self headerTitleTheme];
    theme.font           = [UIFont fontWithName:theme.font.fontName size:13];
    theme.kerning        = 1.15f;
    return theme;
}

@end

@interface PAYDefaultLabelThemeContainer ()

@property (nonatomic, retain) NSMutableDictionary *themes;

@end

@implementation PAYDefaultLabelThemeContainer

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.themes = @{
                        @(PAYFormTableLabelStyleSimple): [PAYDefaultLabelTheme simpleTheme],
                        @(PAYFormTableLabelStyleDescription): [PAYDefaultLabelTheme descriptionTheme],
                        @(PAYFormTableLabelStyleDescriptionWide): [PAYDefaultLabelTheme descriptionWideTheme],
                        @(PAYFormTableLabelStyleHeaderTitle): [PAYDefaultLabelTheme headerTitleTheme],
                        @(PAYFormTableLabelStyleHeaderSubTitle): [PAYDefaultLabelTheme headerSubTitleTheme]
                        }.mutableCopy;
    }
    return self;
}

- (id<PAYLabelTheme>)forStyle:(PAYFormTableLabelStyle)style {
    return self.themes[@(style)];
}

- (void)setTheme:(id<PAYLabelTheme>)theme forStyle:(PAYFormTableLabelStyle)style {
    self.themes[@(style)] = theme;
}

@end