//
//  E84PopOutMenu.m
//  Example
//
//  Created by Paul Pilone on 3/5/15.
//  Copyright (c) 2015 Element 84. All rights reserved.
//

#import "E84PopOutMenu.h"

@interface E84PopOutMenu ()

@property (nonatomic, strong) NSMutableArray *menuItems;

@end

@implementation E84PopOutMenu

/* */
- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

/* */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self baseInit];
    }
    
    return self;
}

/* */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    
    return self;
}

/* */
- (void)addPopOutMenuItem:(UIView *)menuItem {
    [self.menuItems addObject:menuItem];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuItemSelected:)];
    [menuItem addGestureRecognizer:tapGesture];
    
    menuItem.frame = self.bounds;
    [self addSubview:menuItem];
    [self sendSubviewToBack:menuItem];
}

/* */
- (void)openMenuAnimated:(BOOL)animated {
    [self.menuItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *menuItem = (UIView *)obj;
        [UIView animateWithDuration:0.4
                              delay:0.06 * idx
             usingSpringWithDamping:0.7
              initialSpringVelocity:0.4
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             CGFloat deltaX = 100.f * idx;
                             menuItem.transform = CGAffineTransformMakeTranslation(deltaX, 0.f);
                         } completion:^(BOOL finished) {
                             NSLog(@"Finished open animation.");
                             self.open = YES;
                         }];
    }];
}

/* */
- (void)closeMenuAnimated:(BOOL)animated {
    [self.menuItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *menuItem = (UIView *)obj;
        [UIView animateWithDuration:0.4
                              delay:0.06 * idx
             usingSpringWithDamping:0.7
              initialSpringVelocity:0.4
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             menuItem.transform = CGAffineTransformIdentity;
                         } completion:^(BOOL finished) {
                             NSLog(@"Finished open animation.");
                             self.open = NO;
                         }];
    }];
}

#pragma mark -
#pragma mark Private

/* */
- (void)baseInit {
    _menuItems = [NSMutableArray array];
    _open = NO;
}

/* */
- (void)menuItemSelected:(UITapGestureRecognizer *)tapGesture {
    NSLog(@"Tapped item at index: %ld", (unsigned long)[self.menuItems indexOfObject:tapGesture.view]);
    
    if ([self.menuItems indexOfObject:tapGesture.view] == 0) {
        if (!self.open) {
            [self openMenuAnimated:YES];
        } else {
            [self closeMenuAnimated:YES];
        }
    }
}

#pragma mark -
#pragma mark UIView

/* */
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIView *menuItem in self.menuItems) {
        if (CGRectContainsPoint(menuItem.frame, point)) {
            return YES;
        }
    }
    
    return [super pointInside:point withEvent:event];
}

@end
