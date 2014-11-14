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
    
    _simpleStyleInsets          = UIEdgeInsetsMake(32, 15, 8, 0);
    _descriptionStyleInsets     = UIEdgeInsetsMake(36, 21, 8, 21);
    _wideDescriptionStyleInsets = UIEdgeInsetsMake(36, 21, 8, 36);
    _headerStyleInsets          = UIEdgeInsetsMake(0, 21, 0, 21);
    
    _simpleStyleFontSize      = 14;
    _descriptionStyleFontSize = 13;
    _headerTitleStyleFontSize = 24;
    _headerSubTitleStyleFontSize = 13;
    
    _descriptionStyleKerning     = 0.15f;
    _headerTitleStyleKerning    = 1.05f;
    _headerSubTitleStyleKerning = 1.15f;
    
    _descriptionStyleLineSpacing = 4.0f;
    
    _simpleStyleTextColor       = [UIColor colorFromHex:0xFF6D6D72];
    _descriptionStyleTextColor  = [UIColor colorFromHex:0xFF6A6A6A];
}

- (void)setStyle:(PAYFormTableLabelStyle)style {
    _style = style;
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
        if (self.style == PAYFormTableLabelStyleSimple) {
            attrText = [[NSMutableAttributedString alloc] initWithString:attributedText.string.uppercaseString];
        } else {
            attrText =  attributedText.mutableCopy;
        }
        NSRange strRange = NSMakeRange(0, attrText.length);
        
        switch (self.style) {
            case PAYFormTableLabelStyleDescription:
            case PAYFormTableLabelStyleDescriptionWide: {
                NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                style.lineSpacing              = self.descriptionStyleLineSpacing;
                style.alignment                = NSTextAlignmentCenter;
                
                UIFont *font = [UIFont fontWithName:PAYStyle.theme.fontName size:self.descriptionStyleFontSize];
                
                [attrText addAttribute:NSParagraphStyleAttributeName value:style range:strRange];
                [attrText addAttribute:NSFontAttributeName value:font range:strRange];
                [attrText addAttribute:NSKernAttributeName value:@(self.descriptionStyleKerning) range:strRange];
                [attrText addAttribute:NSForegroundColorAttributeName value:self.descriptionStyleTextColor range:strRange];
                break;
            }
            case PAYFormTableLabelStyleSimple: {
                UIFont *font = [UIFont fontWithName:PAYStyle.theme.fontName size:self.simpleStyleFontSize];
                [attrText addAttribute:NSFontAttributeName value:font range:strRange];
                [attrText addAttribute:NSForegroundColorAttributeName value:self.simpleStyleTextColor range:strRange];
                break;
            }
            case PAYFormTableLabelStyleHeaderTitle:
            case PAYFormTableLabelStyleHeaderSubTitle: {
                NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                style.alignment                = NSTextAlignmentCenter;
                
                NSUInteger fontSize = self.headerTitleStyleFontSize;
                NSUInteger fontKern = self.headerTitleStyleKerning;
                NSString  *fontName = PAYStyle.theme.fontName;
                if (self.style == PAYFormTableLabelStyleHeaderSubTitle) {
                    fontSize = self.headerSubTitleStyleFontSize;
                    fontKern = self.headerSubTitleStyleKerning;
                    fontName = PAYStyle.theme.subTitleFontName;
                }
                
                UIFont *font = [UIFont fontWithName:fontName size:fontSize];
                
                [attrText addAttribute:NSParagraphStyleAttributeName value:style range:strRange];
                [attrText addAttribute:NSFontAttributeName value:font range:strRange];
                [attrText addAttribute:NSKernAttributeName value:@(fontKern) range:strRange];
                break;
            }
            default:
                break;
        }
    }
    
    super.attributedText = attrText;
    [self sizeToFit];
}

- (void)updateAttributedText {
    self.text = self.attributedText.string;
}

#pragma mark - positioning

- (UIEdgeInsets)textInsets {
    switch (self.style) {
        case PAYFormTableLabelStyleDescription:
            return self.descriptionStyleInsets;
        case PAYFormTableLabelStyleDescriptionWide:
            return self.wideDescriptionStyleInsets;
        case PAYFormTableLabelStyleSimple:
            return self.simpleStyleInsets;
        case PAYFormTableLabelStyleHeaderTitle:
        case PAYFormTableLabelStyleHeaderSubTitle:
            return self.headerStyleInsets;
        default:
            return UIEdgeInsetsZero;
    }
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
