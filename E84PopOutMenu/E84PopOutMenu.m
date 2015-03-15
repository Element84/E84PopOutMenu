//
//  E84PopOutMenu.m
//  Example
//
//  Created by Paul Pilone on 3/5/15.
//  Copyright (c) 2015 Element 84. All rights reserved.
//

#import "E84PopOutMenu.h"

@interface E84PopOutMenu () < UIGestureRecognizerDelegate >

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
    if ([self.subviews count] == 0) {
        _selectedIdentifier = identifier;
        [self forwardSelected:YES toMenuItem:menuItem];
    } else {
        menuItem.alpha = self.open ? 1.f : 0.f;
        menuItem.hidden = !self.open;
    }
    
    [self.menuItemInfo setObject:menuItem forKey:identifier];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuItemSelected:)];
    tapGesture.delegate = self;
    [menuItem addGestureRecognizer:tapGesture];
    
    [self insertSubview:menuItem atIndex:0];
    NSDictionary *views = NSDictionaryOfVariableBindings(menuItem);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[menuItem]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[menuItem]|" options:0 metrics:nil views:views]];
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

    // If opening:
    if (!_open) {
        CGFloat duration = animated ? 0.25 : 0.f;
        [UIView animateWithDuration:duration animations:^{
            for (NSInteger i = 0; i < [self.subviews count]; i++) {
                UIView *menuItem = self.subviews[i];
                menuItem.hidden = NO;
                menuItem.alpha = 1.f;
            }
        }];
    }
    
    CGFloat duration = animated ? self.animationDuration : 0.f;
    for (NSInteger i = 0; i < [self.subviews count]; i++) {
        UIView *menuItem = _open ? self.subviews[[self.subviews count] - (i + 1)] : self.subviews[i];
        
        CGFloat delay = animated ? self.itemAnimationDelay * i : 0.f;
        [UIView animateWithDuration:duration delay:delay usingSpringWithDamping:self.dampingRatio initialSpringVelocity:self.velocity
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             CGAffineTransform transform;
                             if (_open) {
                                 transform = CGAffineTransformIdentity;
                             } else {
                                 CGFloat deltaX = self.interitemSpacing * ([self.subviews count] - (i + 1));
                                 transform = CGAffineTransformMakeTranslation(deltaX, 0.f);
                             }
                             
                             menuItem.transform = transform;
                         } completion:^(BOOL finished) {
                             // Finally, after all animations have finished,
                             // toggle the open flag.
                            if (finished && i == [self.subviews count] - 1) {
                                 if (_open) {
                                     CGFloat duration = animated ? 0.25 : 0.f;
                                     [UIView animateWithDuration:duration animations:^{
                                         for (NSInteger j = 0; j < [self.subviews count] - 1; j++) {
                                            ((UIView *)self.subviews[j]).alpha = 0.f;
                                         }
                                     } completion:^(BOOL finished) {
                                         if (finished) {
                                             for (NSInteger j = 0; j < [self.subviews count] - 1; j++) {
                                                 ((UIView *)self.subviews[j]).hidden = YES;
                                             }
                                         }
                                         
                                     }];
                                 }
                                 
                                 _open = !_open;
                             }
                         }];
    }
}

/* */
- (void)setSelectedIdentifier:(NSString *)selectedIdentifier {
    if ([_selectedIdentifier isEqualToString:selectedIdentifier]) {
        return;
    }

    // Make sure we're getting passed a valid identifier.
    if (self.menuItemInfo[selectedIdentifier]) {
        // Get the previously selected menu item.
        UIView *oldMenuItem = self.menuItemInfo[_selectedIdentifier];
        if (oldMenuItem) {
            [self forwardSelected:NO toMenuItem:oldMenuItem];
        }
        
        // Bring it to the front so that it lays over the other items when closed.
        UIView *menuItem = self.menuItemInfo[selectedIdentifier];
        [self bringSubviewToFront:menuItem];
        [self forwardSelected:YES toMenuItem:menuItem];
        
        _selectedIdentifier = selectedIdentifier;
    }
}

#pragma mark -
#pragma mark Private

/* */
- (void)baseInit {
    self.backgroundColor = [UIColor clearColor];
   
    _menuItemInfo = [NSMutableDictionary dictionary];
    _open = NO;
    
    _animationDuration = 0.4;
    _dampingRatio = 0.85;
    _itemAnimationDelay = 0.06;
    _interitemSpacing = 75.f;
    _velocity = 0.4;
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

/* Not implemented (nothing calls this yet). */
- (void)forwardHighlighted:(BOOL)highlighted toMenuItem:(UIView *)menuItem {
    if ([menuItem respondsToSelector:@selector(setSelected:)]) {
        NSMethodSignature *methodSignature = [[menuItem class] instanceMethodSignatureForSelector:@selector(setHighlighted:)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        [invocation setTarget:menuItem];
        [invocation setSelector:@selector(setHighlighted:)];
        [invocation setArgument:&highlighted atIndex:2];
        [invocation invoke];
    }
}

/* */
- (void)forwardSelected:(BOOL)selected toMenuItem:(UIView *)menuItem {
    if ([menuItem respondsToSelector:@selector(setSelected:)]) {
        NSMethodSignature *methodSignature = [[menuItem class] instanceMethodSignatureForSelector:@selector(setSelected:)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        [invocation setTarget:menuItem];
        [invocation setSelector:@selector(setSelected:)];
        [invocation setArgument:&selected atIndex:2];
        [invocation invoke];
    }
}

#pragma mark -
#pragma mark UIView

/* */
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIView *menuItem in self.subviews) {
        if (CGRectContainsPoint(menuItem.frame, point)) {
            return YES;
        }
    }
    
    return [super pointInside:point withEvent:event];
}

@end
