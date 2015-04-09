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
        if (self.theme.uppercased) {
            attrText = [[NSMutableAttributedString alloc] initWithString:attributedText.string.uppercaseString];
        } else {
            attrText =  attributedText.mutableCopy;
        }
        NSRange strRange = NSMakeRange(0, attrText.length);
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing              = self.theme.lineSpacing;
        style.alignment                = self.theme.textAlignment;
        
        UIFont *font = [UIFont fontWithName:PAYStyle.theme.fontName size:self.theme.fontSize];
        
        [attrText addAttribute:NSParagraphStyleAttributeName value:style range:strRange];
        [attrText addAttribute:NSFontAttributeName value:font range:strRange];
        [attrText addAttribute:NSKernAttributeName value:@(self.theme.kerning) range:strRange];
        [attrText addAttribute:NSForegroundColorAttributeName value:self.theme.textColor range:strRange];
    }
    
    super.attributedText = attrText;
    [self sizeToFit];
}

- (void)updateAttributedText {
    self.text = self.attributedText.string;
}

#pragma mark - positioning

- (UIEdgeInsets)textInsets {
    return self.theme.insets;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.textInsets)];
}

- (CGSize)sizeThatFits:(CGSize)size {
    UIEdgeInsets insets = self.textInsets;
    CGFloat textWidth = size.width - insets.left - insets.right;
    size.height = [self preferredHeightForWidth:textWidth] + insets.top + insets.bottom;
    return size;
}

- (CGSize)preferredSizeConstrainedToSize:(CGSize)constrainedSize {
    NSStringDrawingContext *context = [NSStringDrawingContext new];
    context.minimumScaleFactor      = 10 / self.font.pointSize;
    
    CGSize rectSize;
    if (self.attributedText) {
        rectSize = [self.attributedText boundingRectWithSize:constrainedSize
                                                     options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                     context:context].size;
    } else {
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineBreakMode            = self.lineBreakMode;
        NSDictionary *attributes                = @{NSFontAttributeName : self.font,NSParagraphStyleAttributeName : paragraphStyle};
        
        rectSize = [self.text boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:context].size;
    }
    
    rectSize.height = ceil(rectSize.height);
    rectSize.width  = ceil(rectSize.width);
    
    return rectSize;
}

- (CGFloat)preferredHeightForWidth:(CGFloat)width {
    return [self preferredSizeConstrainedToSize:CGSizeMake(width, 10000)].height;
}

@end
