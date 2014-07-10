//
//  PAYButtonGroupBuilder.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 10.07.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormButton.h"



@protocol PAYButtonGroupBuilder <NSObject>

@optional
- (void)select:(id)value;

@required
- (PAYFormButton *)addOption:(id)value withText:(NSString *)text;
- (PAYFormButton *)addOption:(id)value withText:(NSString *)text icon:(UIImage *)icon;
- (PAYFormButton *)addOption:(id)value withText:(NSString *)text icon:(UIImage *)icon selectionBlock:(PAYFormButtonSelectionBlock)selectionBlock;

@end