//
//  PAYFormButtonGroupBuilder.m
//  PAYFormBuilder
//
//  Created by Simon Seyer on 11.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormButtonGroupBuilder_protected.h"
#import "PAYFormButtonGroup_protected.h"
#import "PAYFormButtonGroup.h"
#import "PAYFormButton.h"
#import "PAYFormSectionBuilder.h"
#import <BlocksKit/BlocksKit.h>

@implementation PAYFormButtonGroupBuilder

@dynamic required;

- (PAYFormButton *)addOption:(id)value
                    withText:(NSString *)text {
    return [self addOption:value withText:text icon:nil selectionBlock:nil];
}

- (PAYFormButton *)addOption:(id)value
                    withText:(NSString *)text
                        icon:(UIImage *)icon {
    return [self addOption:value withText:text icon:icon selectionBlock:nil];
}

- (PAYFormButton *)addOption:(id)value
                    withText:(NSString *)text
                        icon:(UIImage *)icon
              selectionBlock:(PAYFormButtonSelectionBlock)selectionBlock {
    __block PAYFormButtonSelectionBlock selectionBlockForBlock = selectionBlock;
    __weak PAYFormButtonGroup *blockButtonGroup = self.buttonGroup;
    PAYFormButton *button = [self.sectionBuilder addButtonWithText:text
                                                             style:PAYFormButtonStyleDefault
                                                    selectionBlock:^(PAYFormButton *formButton) {
                                                        __strong PAYFormButtonGroup *buttonGroup = blockButtonGroup;
                                                        [buttonGroup optionStateChanged:value];
                                                        if (selectionBlockForBlock) {
                                                            selectionBlockForBlock(formButton);
                                                        }
                                                    }
                                                    configureBlock:^(PAYFormButton *formButton) {
                                                        if (icon) {
                                                            formButton.iconView.image = icon;
                                                        }
                                                    }];
    [self.buttonGroup addButton:button forValue:value];
    return button;
}

- (void)select:(id)value {
    [self.buttonGroup select:value];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([self.buttonGroup respondsToSelector:aSelector]) {
        return self.buttonGroup;
    }
    return [super forwardingTargetForSelector:aSelector];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([self.buttonGroup respondsToSelector:aSelector]) {
        return YES;
    }
    return [super respondsToSelector:aSelector];
}

@end
