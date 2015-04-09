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

@property (nonatomic, retain) PAYDefaultLabelTheme *simpleTheme;
@property (nonatomic, retain) PAYDefaultLabelTheme *descriptionTheme;
@property (nonatomic, retain) PAYDefaultLabelTheme *descriptionWideTheme;
@property (nonatomic, retain) PAYDefaultLabelTheme *headerTitleTheme;
@property (nonatomic, retain) PAYDefaultLabelTheme *headerSubtitleTheme;

@end

@implementation PAYDefaultLabelThemeContainer

- (id<PAYLabelTheme>)forStyle:(PAYFormTableLabelStyle)style {
    switch (style) {
        case PAYFormTableLabelStyleSimple:
            return self.simpleTheme;
        case PAYFormTableLabelStyleDescription:
            return self.descriptionTheme;
        case PAYFormTableLabelStyleDescriptionWide:
            return self.descriptionWideTheme;
        case PAYFormTableLabelStyleHeaderTitle:
            return self.headerTitleTheme;
        case PAYFormTableLabelStyleHeaderSubTitle:
            return self.headerSubtitleTheme;
        default:
            return nil;
    }
}

- (PAYDefaultLabelTheme *)simpleTheme {
    if (!_simpleTheme) {
        _simpleTheme = [PAYDefaultLabelTheme new];
        _simpleTheme.insets         = UIEdgeInsetsMake(32, 15, 8, 0);
        _simpleTheme.fontSize       = 14;
        _simpleTheme.kerning        = 0.0f;
        _simpleTheme.lineSpacing    = 1.0f;
        _simpleTheme.textColor      = [UIColor colorFromHex:0xFF6D6D72];
        _simpleTheme.uppercased     = YES;
        _simpleTheme.textAlignment  = NSTextAlignmentNatural;
    }
    return _simpleTheme;
}

- (PAYDefaultLabelTheme *)descriptionTheme {
    if (!_descriptionTheme) {
        _descriptionTheme = [PAYDefaultLabelTheme new];
        _descriptionTheme.insets        = UIEdgeInsetsMake(36, 21, 8, 21);
        _descriptionTheme.fontSize      = 13;
        _descriptionTheme.kerning       = 0.15f;
        _descriptionTheme.lineSpacing   = 4.0f;
        _descriptionTheme.textColor     = [UIColor colorFromHex:0xFF6A6A6A];
        _descriptionTheme.uppercased    = NO;
        _descriptionTheme.textAlignment = NSTextAlignmentCenter;
    }
    return _descriptionTheme;
}

- (PAYDefaultLabelTheme *)descriptionWideTheme {
    if (!_descriptionWideTheme) {
        _descriptionWideTheme = [PAYDefaultLabelTheme new];
        _descriptionWideTheme.insets        = UIEdgeInsetsMake(36, 21, 8, 36);
        _descriptionWideTheme.fontSize      = self.descriptionTheme.fontSize;
        _descriptionWideTheme.kerning       = self.descriptionTheme.kerning;
        _descriptionWideTheme.lineSpacing   = self.descriptionTheme.lineSpacing;
        _descriptionWideTheme.textColor     = self.descriptionTheme.textColor;
        _descriptionWideTheme.uppercased    = self.descriptionTheme.uppercased;
        _descriptionWideTheme.textAlignment = self.descriptionTheme.textAlignment;
    }
    return _descriptionWideTheme;
}

- (PAYDefaultLabelTheme *)headerTitleTheme {
    if (!_headerTitleTheme) {
        _headerTitleTheme = [PAYDefaultLabelTheme new];
        _headerTitleTheme.insets        = UIEdgeInsetsMake(0, 21, 0, 21);
        _headerTitleTheme.fontSize      = 24;
        _headerTitleTheme.kerning       = 1.05f;
        _headerTitleTheme.lineSpacing   = self.simpleTheme.lineSpacing;
        _headerTitleTheme.textColor     = self.simpleTheme.textColor;
        _headerTitleTheme.uppercased    = NO;
        _headerTitleTheme.textAlignment = NSTextAlignmentCenter;
    }
    return _headerTitleTheme;
}

- (PAYDefaultLabelTheme *)headerSubtitleTheme {
    if (!_headerSubtitleTheme) {
        _headerSubtitleTheme = [PAYDefaultLabelTheme new];
        _headerSubtitleTheme.insets         = self.headerTitleTheme.insets;
        _headerSubtitleTheme.fontSize       = 13;
        _headerSubtitleTheme.kerning        = 1.15f;
        _headerSubtitleTheme.lineSpacing    = self.simpleTheme.lineSpacing;
        _headerSubtitleTheme.textColor      = self.simpleTheme.textColor;
        _headerSubtitleTheme.uppercased     = self.headerTitleTheme.uppercased;
        _headerSubtitleTheme.textAlignment  = self.headerTitleTheme.textAlignment;
    }
    return _headerSubtitleTheme;
}

@end