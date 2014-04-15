//
//  PAYFormLabel.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 14.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYTextLabel.h"
#import "UIColor+PAYHex.h"

@implementation PAYTextLabel

- (id)init {
    self = [super init];
    if (self) {
        [self initializeVars];
    }
    return self;
}

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
    
    CGRect textFrame = self.frame;
    switch (self.style) {
        case PAYFormTableLabelStyleDescription:
        case PAYFormTableLabelStyleDescriptionWide:
            textFrame.origin.x = (style == PAYFormTableLabelStyleDescription) ? 40 : 21;
            textFrame.origin.y = 36;
            
            self.textColor = [UIColor colorFromHex:0xFF6A6A6A];
            break;
        case PAYFormTableLabelStyleSimple: {
            textFrame.origin = CGPointMake(15, 32);
            self.textColor = [UIColor colorFromHex:0xFF6D6D72];
            break;
        }
        default:
            break;
    }
    self.frame = textFrame;
    
    self.attributedText = self.attributedText;
}

- (void)setText:(NSString *)text {
    self.attributedText = text ? [[NSAttributedString alloc] initWithString:text] : nil;
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    NSMutableAttributedString *attrText;
    if(attributedText){
        if (self.style == PAYFormTableLabelStyleSimple) {
            attrText = [[NSMutableAttributedString alloc] initWithString:attributedText.string.uppercaseString];
        } else {
            attrText = [[NSMutableAttributedString alloc] initWithAttributedString:attributedText];
        }
        NSInteger strLength = [attrText length];
        
        switch (self.style) {
            case PAYFormTableLabelStyleDescription:
            case PAYFormTableLabelStyleDescriptionWide: {
                NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                style.lineSpacing              = 4;
                style.alignment                = NSTextAlignmentCenter;
                
                UIFont *font = [UIFont fontWithName:self.font.fontName size:13];
                
                [attrText addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, strLength)];
                [attrText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, strLength)];
                [attrText addAttribute:NSKernAttributeName value:@0.15 range:NSMakeRange(0, strLength)];
                break;
            }
            case PAYFormTableLabelStyleSimple: {
                UIFont *font = [UIFont fontWithName:self.font.fontName size:14];
                [attrText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, strLength)];
                break;
            }
            default:
                break;
        }
    }
    
    super.attributedText = attrText;
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize textSize;
    switch (self.style) {
        case PAYFormTableLabelStyleDescription:
        case PAYFormTableLabelStyleDescriptionWide:
            textSize.width = size.width - (2 * self.frame.origin.x);
            break;
        case PAYFormTableLabelStyleSimple:
            textSize.width = size.width - self.frame.origin.x;
            break;
        default:
            break;
    }
    textSize.height = [self preferredHeightForWidth:textSize.width];
    
    return textSize;
}

- (CGSize)preferredSize {
    return [self.text sizeWithAttributes: @{NSFontAttributeName: self.font}];
}

- (CGSize)preferredSizeConstrainedToSize:(CGSize)constrainedSize {
    NSStringDrawingContext *context         = [NSStringDrawingContext new];
    context.minimumScaleFactor              = 10 / self.font.pointSize;
    
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