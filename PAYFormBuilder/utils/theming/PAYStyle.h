//
//  PAYStyle.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 11.11.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYSectionTheme.h"
#import "PAYTableTheme.h"
#import "PAYLabelTheme.h"

/*
 * Manager for the styles used by the FormBuilder.
 *
 * Modify the default ones or replace them completly by calling the setter
 * of this class. All styles are applied globally across all forms.
 *
 * Check out the PAY*Theme protocols to see, which styles attributes are
 * available. To see the default values, check out the classes in the 
 * defaults group.
 */
@interface PAYStyle : NSObject

/*
 * Get the section theme. By default, the PAYDefaultSectionTheme
 * is returned.
 *
 * @return the section theme
 */
+ (nonnull id<PAYSectionTheme>)sectionTheme;

/*
 * Set a new section theme
 *
 * @param theme the new theme
 */
+ (void)setSectionTheme:(nonnull id<PAYSectionTheme>)theme;

/*
 * Get the table theme. By default, the PAYDefaultTableTheme
 * is returned.
 *
 * @return the table theme
 */
+ (nonnull id<PAYTableTheme>)tableTheme;

/*
 * Set a new table theme
 *
 * @param theme the new theme
 */
+ (void)setTableTheme:(nonnull id<PAYTableTheme>)theme;

/*
 * Get the label theme. By default, the PAYDefaultLabelThemeContainer
 * is returned.
 *
 * Because there are different style groups (`PAYFormTableLabelStyle`),
 * this theme is returned as an container. To get the actual themes, call
 * `forStyle:` on the theme object.
 *
 * @return the label theme container
 */
+ (nonnull id<PAYLabelThemeContainer>)labelTheme;

/*
 * Set a new label theme container
 *
 * @param theme the new theme container
 */
+ (void)setLabelTheme:(nonnull id<PAYLabelThemeContainer>)theme;

@end
