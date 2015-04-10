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
                        @(PAYFormTableLabelStyleSimple): [PAYDefaultLabelTheme new],
                        @(PAYFormTableLabelStyleDescription): [PAYDefaultLabelTheme new],
                        @(PAYFormTableLabelStyleDescriptionWide): [PAYDefaultLabelTheme new],
                        @(PAYFormTableLabelStyleHeaderTitle): [PAYDefaultLabelTheme new],
                        @(PAYFormTableLabelStyleHeaderSubTitle): [PAYDefaultLabelTheme new]
                        }.mutableCopy;
        [self loadSimpleTheme];
    }
    return self;
}

- (id<PAYLabelTheme>)forStyle:(PAYFormTableLabelStyle)style {
    return self.themes[@(style)];
}

- (void)setTheme:(id<PAYLabelTheme>)theme forStyle:(PAYFormTableLabelStyle)style {
    self.themes[@(style)] = theme;
}

- (void)loadSimpleTheme {
    PAYDefaultLabelTheme *theme = self.themes[@(PAYFormTableLabelStyleSimple)];
    theme.insets         = UIEdgeInsetsMake(32, 15, 8, 0);
    theme.fontSize       = 14;
    theme.kerning        = 0.0f;
    theme.lineSpacing    = 1.0f;
    theme.textColor      = [UIColor colorFromHex:0xFF6D6D72];
    theme.uppercased     = YES;
    theme.textAlignment  = NSTextAlignmentNatural;
}

- (void)loadDescriptionTheme {
    PAYDefaultLabelTheme *theme = self.themes[@(PAYFormTableLabelStyleDescription)];
    theme.insets        = UIEdgeInsetsMake(36, 21, 8, 21);
    theme.fontSize      = 13;
    theme.kerning       = 0.15f;
    theme.lineSpacing   = 4.0f;
    theme.textColor     = [UIColor colorFromHex:0xFF6A6A6A];
    theme.uppercased    = NO;
    theme.textAlignment = NSTextAlignmentCenter;
}

- (void)loadDescriptionWideTheme {
    PAYDefaultLabelTheme *descriptionTheme = self.themes[@(PAYFormTableLabelStyleDescription)];
    PAYDefaultLabelTheme *theme = self.themes[@(PAYFormTableLabelStyleDescriptionWide)];
    theme.insets        = UIEdgeInsetsMake(36, 21, 8, 36);
    theme.fontSize      = descriptionTheme.fontSize;
    theme.kerning       = descriptionTheme.kerning;
    theme.lineSpacing   = descriptionTheme.lineSpacing;
    theme.textColor     = descriptionTheme.textColor;
    theme.uppercased    = descriptionTheme.uppercased;
    theme.textAlignment = descriptionTheme.textAlignment;
}

- (void)loadHeaderTitleTheme {
    PAYDefaultLabelTheme *simpleTheme = self.themes[@(PAYFormTableLabelStyleSimple)];
    PAYDefaultLabelTheme *theme = self.themes[@(PAYFormTableLabelStyleHeaderTitle)];
    theme.insets        = UIEdgeInsetsMake(0, 21, 0, 21);
    theme.fontSize      = 24;
    theme.kerning       = 1.05f;
    theme.lineSpacing   = simpleTheme.lineSpacing;
    theme.textColor     = simpleTheme.textColor;
    theme.uppercased    = NO;
    theme.textAlignment = NSTextAlignmentCenter;
}

- (void)loadHeaderSubTitleTheme {
    PAYDefaultLabelTheme *headerTitleTheme = self.themes[@(PAYFormTableLabelStyleHeaderTitle)];
    PAYDefaultLabelTheme *theme = self.themes[@(PAYFormTableLabelStyleHeaderSubTitle)];
    theme.insets         = headerTitleTheme.insets;
    theme.fontSize       = 13;
    theme.kerning        = 1.15f;
    theme.lineSpacing    = headerTitleTheme.lineSpacing;
    theme.textColor      = headerTitleTheme.textColor;
    theme.uppercased     = headerTitleTheme.uppercased;
    theme.textAlignment  = headerTitleTheme.textAlignment;
}

@end