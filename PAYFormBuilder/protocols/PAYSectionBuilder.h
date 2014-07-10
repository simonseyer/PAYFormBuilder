//
//  PAYSectionBuilder.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 10.07.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYFormButton.h"
#import "PAYButtonGroupBuilder.h"

@class PAYFormSingleLineTextField;
@class PAYFormMultiLineTextField;
@class PAYFormButton;
@class PAYFormSwitch;
@class SZTextView;
@class PAYFormButtonGroup;

@protocol PAYSectionBuilder <NSObject>

- (PAYFormSingleLineTextField *)addFieldWithPlaceholder:(NSString *)placeholder;
- (PAYFormSingleLineTextField *)addFieldWithPlaceholder:(NSString *)placeholder configureBlock:(void(^)(PAYFormSingleLineTextField *))configureBlock;
- (PAYFormSingleLineTextField *)addFieldWithName:(NSString *)name placeholder:(NSString *)placeholder;
- (PAYFormSingleLineTextField *)addFieldWithName:(NSString *)name placeholder:(NSString *)placeholder configureBlock:(void(^)(PAYFormSingleLineTextField *))configureBlock;

- (PAYFormMultiLineTextField *)addTextViewWithPlaceholder:(NSString *)placeholder;
- (PAYFormMultiLineTextField *)addTextViewWithPlaceholder:(NSString *)placeholder configureBlock:(void(^)(PAYFormMultiLineTextField *))configureBlock;

- (PAYFormButton *)addButtonWithText:(NSString *)text style:(PAYFormButtonStyle)style selectionBlock:(PAYFormButtonSelectionBlock)selectionBlock;
- (PAYFormButton *)addButtonWithText:(NSString *)text style:(PAYFormButtonStyle)style icon:(UIImage *)icon selectionBlock:(PAYFormButtonSelectionBlock)selectionBlock;
- (PAYFormButton *)addButtonWithText:(NSString *)text style:(PAYFormButtonStyle)style selectionBlock:(PAYFormButtonSelectionBlock)selectionBlock configureBlock:(void(^)(PAYFormButton *))configureBlock;

- (PAYFormButtonGroup *)addButtonGroupWithMutliSelection:(BOOL)multiSelection contentBlock:(void(^)(id<PAYButtonGroupBuilder>))contentBlock;

- (PAYFormSwitch *)addSwitchWithName:(NSString *)name;
- (PAYFormSwitch *)addSwitchWithName:(NSString *)name configureBlock:(void(^)(PAYFormSwitch *))configureBlock;

- (void)addView:(void(^)(PAYFormView *))configureBlock;

- (UILabel *)defaultLabelInRect:(CGRect)defaultBounds;
- (UITextField *)defaultTextField;
- (SZTextView *)defaultTextView;

@end
