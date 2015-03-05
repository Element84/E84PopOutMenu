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

@property (nonatomic, strong) NSMutableDictionary *menuItemInfo;

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
- (void)addPopOutMenuItem:(UIView *)menuItem forIdentifier:(NSString *)identifier {
    // If we have no other items this is the selected item.
    if ([self.menuItems count] == 0) {
        _selectedIdentifier = identifier;
    }
    
    [self.menuItems addObject:menuItem];
    [self.menuItemInfo setObject:menuItem forKey:identifier];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuItemSelected:)];
    [menuItem addGestureRecognizer:tapGesture];
    
    menuItem.frame = self.bounds;
    [self addSubview:menuItem];
    [self sendSubviewToBack:menuItem];
}

/* */
- (void)setOpen:(BOOL)open {
    [self setOpen:open animated:YES];
}

/* */
- (void)setOpen:(BOOL)open animated:(BOOL)animated {
    if (_open == open) {
        return;
    }
    
    CGFloat duration = animated ? 0.4 : 0.f;
    [self.menuItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *menuItem = (UIView *)obj;
        
        CGFloat delay = animated ? 0.06 * idx : 0.f;
        [UIView animateWithDuration:duration
                              delay:delay
             usingSpringWithDamping:0.7
              initialSpringVelocity:0.4
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             CGAffineTransform transform;
                             if (_open) {
                                 transform = CGAffineTransformIdentity;
                             } else {
                                 CGFloat deltaX = 100.f * idx;
                                 transform = CGAffineTransformMakeTranslation(deltaX, 0.f);
                             }

                             menuItem.transform = transform;
                         } completion:^(BOOL finished) {
                             if (finished) {
                                 _open = !_open;
                             }
                         }];
    }];
}

/* */
- (void)setSelectedIdentifier:(NSString *)selectedIdentifier {
    if ([_selectedIdentifier isEqualToString:selectedIdentifier]) {
        return;
    }
    
    // Make sure we're getting passed a valid identifier.
    UIView *menuItem = self.menuItemInfo[selectedIdentifier];
    if (menuItem != nil) {
        // Move the item to the front of our queue.
        [self.menuItems removeObject:menuItem];
        [self.menuItems insertObject:menuItem atIndex:0];
        
        // Bring it to the front so that it lays over the other items when closed.
        [self bringSubviewToFront:menuItem];
        
        _selectedIdentifier = selectedIdentifier;
    }
}

#pragma mark -
#pragma mark Private

/* */
- (void)baseInit {
    self.backgroundColor = [UIColor clearColor];
   
    _menuItemInfo = [NSMutableDictionary dictionary];
    _menuItems = [NSMutableArray array];
    _open = NO;
}

/* */
- (void)menuItemSelected:(UITapGestureRecognizer *)tapGesture {
    UIView *menuItem = tapGesture.view;
    NSString *identifier = [[self.menuItemInfo allKeysForObject:menuItem] firstObject];
    
    if (![identifier isEqualToString:self.selectedIdentifier]) {
        // Update our selected identifier.
        self.selectedIdentifier = identifier;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }

    // Toggle the menu.
    self.open = !self.open;
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
