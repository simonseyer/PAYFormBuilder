//
//  PAYFormTableBuilder.m
//  paij
//
//  Created by Simon Seyer on 01.11.13.
//  Copyright (c) 2013 redpixtec. GmbH. All rights reserved.
//

#import "PAYFormTableBuilder.h"
#import "PAYFormSection.h"
#import "PAYFormSectionBuilder.h"
#import "PAYFormHeader.h"
#import "PAYTextLabel.h"

@implementation PAYFormTableBuilder

- (id)init {
    self = [super init];
    if (self) {
        self.table = [PAYFormTable new];
        
        self.labelStyleNoneDefaultHeight = 32.0f;
        self.labelStylEmptyDefaultHeight = 36.0f;
        self.labelDefaultBottomMargin    = 8.0f;
    }
    return self;
}

- (id)initWithFormTable:(PAYFormTable *)table {
    self = [super init];
    if (self) {
        self.table = table;
    }
    return self;
}

- (PAYFormSection *)addSectionWithContentBlock:(void(^)(id<PAYSectionBuilder>))contentBlock {
    return [self addSectionWithContentBlock:contentBlock labelStyle:PAYFormTableLabelStyleEmpty];
}

- (PAYFormSection *)addSectionWithContentBlock:(void(^)(id<PAYSectionBuilder>))contentBlock
                                    labelStyle:(PAYFormTableLabelStyle)style {
    return [self addSectionWithName:nil labelStyle:style headerBlock:NULL contentBlock:contentBlock];
}

- (PAYFormSection *)addSectionWithHeaderBlock:(void(^)(PAYFormHeader *))headerBlock
                                 contentBlock:(void(^)(id<PAYSectionBuilder>))contentBlock {
    return [self addSectionWithName:nil
                         labelStyle:PAYFormTableLabelStyleEmpty
                        headerBlock:headerBlock
                       contentBlock:contentBlock];
}

- (PAYFormSection *)addSectionWithName:(NSString *)name
                            labelStyle:(PAYFormTableLabelStyle)style
                          contentBlock:(void(^)(id<PAYSectionBuilder>))contentBlock {
    return [self addSectionWithName:name labelStyle:style headerBlock:NULL contentBlock:contentBlock];
}

- (PAYFormSection *)addSectionWithName:(NSString *)name
                            labelStyle:(PAYFormTableLabelStyle)style
                           headerBlock:(void(^)(PAYFormHeader *))headerBlock
                          contentBlock:(void(^)(id<PAYSectionBuilder>))contentBlock {
    PAYFormSection *formSection = [PAYFormSection new];
    
    formSection.header = [self headerViewWithStyle:style name:name];
    if (headerBlock) {
        headerBlock(formSection.header);
    }
    
    if (contentBlock) {
        PAYFormSectionBuilder *builder = [[PAYFormSectionBuilder alloc] initWithFormSection:formSection
                                                                        defaultCellBounds:self.defaultBounds];
        contentBlock(builder);
    }
    
    [self.table.sections addObject:formSection];
    
    return formSection;
}

- (PAYFormHeader *)headerViewWithStyle:(PAYFormTableLabelStyle)style
                                  name:(NSString *)name {
    UIView *headerView         = [[UIView alloc] initWithFrame:self.defaultBounds];
    headerView.backgroundColor = UIColor.clearColor;
    
    PAYTextLabel *textLabel = nil;
    CGRect headerRect = headerView.frame;
    if (style == PAYFormTableLabelStyleNone) {
        headerRect.size.height = self.labelStyleNoneDefaultHeight;
    } else if (style == PAYFormTableLabelStyleEmpty) {
        headerRect.size.height = self.labelStylEmptyDefaultHeight;
    } else {
        textLabel       = [[PAYTextLabel alloc] initWithFrame:self.defaultBounds];
        textLabel.style = style;
        textLabel.text  = name;
        [textLabel sizeToFit];
        [headerView addSubview:textLabel];
        
        headerRect.size.height = CGRectGetMaxY(textLabel.frame) + self.labelDefaultBottomMargin;
    }
    headerView.frame       = headerRect;

    PAYFormHeader *formHeader    = [PAYFormHeader new];
    formHeader.view             = headerView;
    formHeader.label            = textLabel;
    
    return formHeader;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([self.table respondsToSelector:aSelector]) {
        return self.table;
    }
    return [super forwardingTargetForSelector:aSelector];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([self.table respondsToSelector:aSelector]) {
        return YES;
    }
    return [super respondsToSelector:aSelector];
}

@end
