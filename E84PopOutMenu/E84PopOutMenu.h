//
//  E84PopOutMenu.h
//  Example
//
//  Created by Paul Pilone on 3/5/15.
//  Copyright (c) 2015 Element 84. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface E84PopOutMenu : UIControl

@property (nonatomic, copy) NSString *selectedIdentifier;

@property (nonatomic, getter=isOpen) BOOL open;

/* */
- (void)addPopOutMenuItem:(UIView *)menuItem forIdentifier:(NSString *)identifier;

/* */
- (void)setOpen:(BOOL)open animated:(BOOL)animated;

@end
