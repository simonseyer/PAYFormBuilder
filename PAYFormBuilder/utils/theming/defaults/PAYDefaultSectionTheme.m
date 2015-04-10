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
        self.labelFieldSpacing       = 6.0f;
        self.disclosureMarginRight   = 36.0f;
        self.iconSize                = 21.0f;
        self.iconMargin              = 17.0f;
        self.iconMarginLeft          = 59.0f;
        self.textViewLineCount       = 3;
        self.textColor               = [UIColor colorFromHex:0xFF323232];
        self.disabledTextColor       = self.textColor;
        self.placeholderColor        = [UIColor colorFromHex:0xFFCACACA];
        self.buttonPrimaryTextColor  = [UIColor colorFromHex:0xFF214889];
        self.buttonHilightTextColor  = [UIColor colorFromHex:0xFFE87E18];
        self.buttonDisabledTextColor = [UIColor colorFromHex:0xFF898989];
        self.buttonDetailTextColor   = [UIColor colorFromHex:0xFFCCCCCC];
    }
    return self;
}

@end
