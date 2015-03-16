//
//  E84PopOutMenu.h
//  Example
//
//  Created by Paul Pilone on 3/5/15.
//  Copyright (c) 2015 Element 84. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, E84PopOutMenuMaskType) {
    E84PopOutMenuMaskTypeNone = 0,  // no background when open; allows user interaction while displayed
    E84PopOutMenuMaskTypeClear,     // clear background behind menu; closes if tap occurs outside of menu
    E84PopOutMenuMaskTypeBlack      // dims UI behind menu; closes if tap occurs outside of menu
};

typedef NS_ENUM(NSInteger, E84PopOutMenuDirection) {
    E84PopOutMenuDirectionLeft = 0,
    E84PopOutMenuDirectionUp,
    E84PopOutMenuDirectionRight,
    E84PopOutMenuDirectionDown
};

@interface E84PopOutMenu : UIControl

/** 
 The identifier for the currently selected item. Manually setting this will
 show the menu item but will not open or close the menu.
*/
@property (nonatomic, copy) NSString *selectedIdentifier;

/** 
 Indicates whether or not the menu is currently open.
*/
@property (nonatomic, getter=isOpen) BOOL open;

/**
 Mask type to use when the menu is open. See E84PopOutMenuMaskType for descriptions.
 */
@property (nonatomic) enum E84PopOutMenuMaskType maskType;

/** 
 Opening direction of the menu. Default is E84PopOutMenuDirectionRight.
 */
@property (nonatomic) enum E84PopOutMenuDirection menuDirection;

/**
 The duration of the animation used to open or close the menu. Defaults to 0.4.
 */
@property (nonatomic) CGFloat animationDuration;

/**
 The delay used between opening animations for each item. Defaults to 0.06.
 */
@property (nonatomic) CGFloat itemAnimationDelay;

/** 
 The number of points used to separate each item of the menu when open. Defaults to 75.
 */
@property (nonatomic) CGFloat interitemSpacing;

/**
 The damping ratio used to control the elasticity of the open/close animation. Values range
 between 0 and 1, where 1 is no oscillation at the end of the animation. Defaults to 0.85.
 */
@property (nonatomic) CGFloat dampingRatio;

/**
 The initial velocity of the open/close animation. Defaults to 0.4.
 */
@property (nonatomic) CGFloat velocity;

/**
 Adds the given view as an item to the menu. Menu items are resized to
 fit the frame of the menu itself. Items are inserted as a subview below any existing
 menu items. 
 
 If the menu item responds to setSelected: E84PopoutMenu will call forward
 selection status to the item.
 
 @param menuItem The item to add to the menu
 @param identifier The unique identifier associated with this menu item
 */
- (void)addPopOutMenuItem:(UIView *)menuItem forIdentifier:(NSString *)identifier;

/**
 Removes a menu item from the menu. Does not recalculate item position
 if open. Recommend ensuring the menu is closed before calling this
 method.
 
 @param identifier The unique identifier of the menu item to remove
 */
- (void)removeMenuItemWithIdentifier:(NSString *)identifier;

/**
 Manually open or close the menu with an option to animate.
 
 @param open Whether or not the menu should be opened
 @param animated Whether or not opening/closing is animated
 */
- (void)setOpen:(BOOL)open animated:(BOOL)animated;

@end
