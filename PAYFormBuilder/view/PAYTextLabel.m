//
//  PAYFormLabel.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 14.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYTextLabel.h"
#import "UIColor+PAYHex.h"
#import "PAYStyle.h"

@interface PAYTextLabel ()

@property (nonatomic, retain) id<PAYLabelTheme> theme;

@end

@implementation PAYTextLabel

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeVars];
    }
    return self;
}

- (instancetype)initWithStyle:(PAYFormTableLabelStyle)style {
    self = [super init];
    if (self) {
        [self initializeVars];
        self.style = style;
    }
    return self;
}

- (void)initializeVars {
    self.backgroundColor = UIColor.clearColor;
    self.numberOfLines = 0;
    self.adjustsFontSizeToFitWidth = NO;
    self.lineBreakMode = NSLineBreakByWordWrapping;
}

- (void)setStyle:(PAYFormTableLabelStyle)style {
    _style = style;
    self.theme = [PAYStyle.labelTheme forStyle:self.style];
    [self updateAttributedText];
}

# pragma mark - text handling

- (void)setText:(NSString *)text {
    self.attributedText = text ? [[NSAttributedString alloc] initWithString:text] : nil;
}

- (NSString *)text {
    return self.attributedText.string;
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    NSMutableAttributedString *attrText;
    if(attributedText){
        if (self.theme.capitalize) {
            attrText = [[NSMutableAttributedString alloc] initWithString:attributedText.string.uppercaseString];
        } else {
            attrText =  attributedText.mutableCopy;
        }
        NSRange strRange = NSMakeRange(0, attrText.length);
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing              = self.theme.lineSpacing;
        style.alignment                = self.theme.textAlignment;
        
        [attrText addAttribute:NSParagraphStyleAttributeName value:style range:strRange];
        [attrText addAttribute:NSFontAttributeName value:self.theme.font range:strRange];
        [attrText addAttribute:NSKernAttributeName value:@(self.theme.kerning) range:strRange];
        [attrText addAttribute:NSForegroundColorAttributeName value:self.theme.textColor range:strRange];
    }
    
    super.attributedText = attrText;
    [self invalidateIntrinsicContentSize];
}

- (void)updateAttributedText {
    self.text = self.attributedText.string;
}

#pragma mark - layouting

- (UIEdgeInsets)textInsets {
    return self.theme.insets;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.textInsets)];
}

- (CGSize) intrinsicContentSize {
    CGSize superSize = [super intrinsicContentSize] ;
    superSize.height += self.textInsets.top + self.textInsets.bottom;
    superSize.width += self.textInsets.left + self.textInsets.right;
    return superSize;
}

- (void)layoutSubviews {
    self.preferredMaxLayoutWidth = self.frame.size.width;
    [super layoutSubviews];
}

@end
