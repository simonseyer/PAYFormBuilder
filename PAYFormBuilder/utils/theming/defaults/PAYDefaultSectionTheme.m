//
//  PAYDefaultSectionTheme.m
//  Pods
//
//  Created by COBI on 09.04.15.
//
//

#import "PAYDefaultSectionTheme.h"
#import "UIColor+PAYHex.h"

@implementation PAYDefaultSectionTheme

- (instancetype)init {
    self = [super init];
    if (self) {
        self.horizontalMargin        = 14.0f;
        self.fieldTextAlignment      = NSTextAlignmentNatural;
        self.labelWidth              = 91.0f;
        self.fixedLabelWidth         = YES;
        self.fixedSeperatorInset     = NO;
        self.labelFieldSpacing       = 6.0f;
        self.detailLabelMarginRight  = self.horizontalMargin;
        self.disclosureMarginRight   = 36.0f;
        self.iconSize                = 21.0f;
        self.iconMargin              = 17.0f;
        self.iconMarginLeft          = 59.0f;
        self.textViewLineCount       = 3;
        self.textViewMaxLineCount    = 5;
        self.textColor               = [UIColor colorFromHex:0xFF323232];
        self.errorTextColor = [UIColor colorFromHex:0xFFFF3B30];
        self.disabledTextColor       = self.textColor;
        self.placeholderColor        = [UIColor colorFromHex:0xFFCACACA];
        self.buttonTextColors = @{
                                  @(PAYFormButtonStyleCentered) : self.textColor,
                                  @(PAYFormButtonStyleDefault) : self.textColor,
                                  @(PAYFormButtonStyleDisclosure) : self.textColor,
                                  @(PAYFormButtonStyleHilighted) : [UIColor colorFromHex:0xFFE87E18],
                                  @(PAYFormButtonStylePrimary) : [UIColor colorFromHex:0xFF214889],
                                  @(PAYFormButtonStyleSelection) : self.textColor,
                                  }.mutableCopy;
        self.buttonDetailTextColor   = [UIColor colorFromHex:0xFFCCCCCC];
    }
    return self;
}

- (UIColor *)buttonTextColorForStyle:(PAYFormButtonStyle)style
{
    return self.buttonTextColors[@(style)];
}

@end
