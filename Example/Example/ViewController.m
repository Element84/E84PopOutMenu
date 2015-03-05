//
//  ViewController.m
//  Example
//
//  Created by Paul Pilone on 3/5/15.
//  Copyright (c) 2015 Element 84. All rights reserved.
//

#import "ViewController.h"

#import "E84PopOutMenu.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet E84PopOutMenu *popOutMenu;

@end

@implementation ViewController

- (void)popOutMenuValueChanged:(id)sender {
    NSLog(@"Selected menu item: %@", self.popOutMenu.selectedIdentifier);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.popOutMenu addTarget:self action:@selector(popOutMenuValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    UIView *menuItem = [[UIView alloc] init];
    menuItem.backgroundColor = [UIColor blackColor];
    [self.popOutMenu addPopOutMenuItem:menuItem forIdentifier:@"Foo"];
    
    menuItem = [[UIView alloc] init];
    menuItem.backgroundColor = [UIColor greenColor];
    [self.popOutMenu addPopOutMenuItem:menuItem forIdentifier:@"Bar"];
    
    menuItem = [[UIView alloc] init];
    menuItem.backgroundColor = [UIColor blueColor];
    [self.popOutMenu addPopOutMenuItem:menuItem forIdentifier:@"FooBar"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
