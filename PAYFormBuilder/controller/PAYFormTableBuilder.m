//
//  PAYFormTableBuilder.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 01.11.13.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormTableBuilder.h"
#import "PAYFormSection.h"
#import "PAYFormSectionBuilder.h"
#import "PAYFormHeader.h"
#import "PAYFormHeader_protected.h"
#import "PAYTextLabel.h"

@implementation PAYFormTableBuilder

- (id)init {
    self = [super init];
    if (self) {
        self.table = [PAYFormTable new];
        
        self.labelStyleNoneDefaultHeight = 32.0f;
        self.labelStylEmptyDefaultHeight = 36.0f;
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

- (void)addSectionWithContentBlock:(void(^)(id<PAYSectionBuilder>))contentBlock {
    [self addSectionWithLabelStyle:PAYFormTableLabelStyleEmpty
                      contentBlock:contentBlock];
}

- (void)addSectionWithLabelStyle:(PAYFormTableLabelStyle)style
                    contentBlock:(void(^)(id<PAYSectionBuilder>))contentBlock {
    [self addSectionWithName:nil
                  labelStyle:style
                 headerBlock:nil
                contentBlock:contentBlock];
}

- (void)addSectionWithHeaderBlock:(void(^)(PAYFormHeader *))headerBlock
                     contentBlock:(void(^)(id<PAYSectionBuilder>))contentBlock {
    [self addSectionWithName:nil
                  labelStyle:PAYFormTableLabelStyleEmpty
                 headerBlock:headerBlock
                contentBlock:contentBlock];
}

- (void)addSectionWithName:(NSString *)name
              contentBlock:(void(^)(id<PAYSectionBuilder>))contentBlock {
    [self addSectionWithName:name
                  labelStyle:PAYFormTableLabelStyleSimple
                contentBlock:contentBlock];
}

- (void)addSectionWithName:(NSString *)name
                labelStyle:(PAYFormTableLabelStyle)style
              contentBlock:(void(^)(id<PAYSectionBuilder>))contentBlock {
    [self addSectionWithName:name
                  labelStyle:style
                 headerBlock:nil
                contentBlock:contentBlock];
}

- (void)addSectionWithName:(NSString *)name
                labelStyle:(PAYFormTableLabelStyle)style
               headerBlock:(void(^)(PAYFormHeader *))headerBlock
              contentBlock:(void(^)(id<PAYSectionBuilder>))contentBlock {
    PAYFormSection *formSection = [PAYFormSection new];
    formSection.name = name;
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
        [headerView addSubview:textLabel];
        
        headerRect.size.height = CGRectGetMaxY(textLabel.frame);
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
