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
@property (weak, nonatomic) IBOutlet UILabel *selectedIdentifierLabel;

@end

@implementation ViewController

- (IBAction)addPlayMenuItem:(id)sender {
    UIButton *menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
    menuItem.translatesAutoresizingMaskIntoConstraints = NO;
    [menuItem setBackgroundColor:[UIColor whiteColor]];
    [menuItem setImage:[UIImage imageNamed:@"E84PlayMenuItem"] forState:UIControlStateNormal];
    [self.popOutMenu addPopOutMenuItem:menuItem forIdentifier:@"Play"];
}

- (IBAction)removePlayMenuItem:(id)sender {
    [self.popOutMenu removeMenuItemWithIdentifier:@"Play"];
}

- (IBAction)directionValueChanged:(id)sender {
    self.popOutMenu.menuDirection = ((UISegmentedControl *)sender).selectedSegmentIndex;
}

- (IBAction)maskValueChanged:(id)sender {
    self.popOutMenu.maskType = ((UISegmentedControl *)sender).selectedSegmentIndex;
}

- (IBAction)modeValueChanged:(id)sender {
    self.popOutMenu.mode = ((UISegmentedControl *)sender).selectedSegmentIndex;
}

- (IBAction)toggleMenu:(id)sender {
    [self.popOutMenu setOpen:!self.popOutMenu.open animated:YES];
}

- (void)popOutMenuValueChanged:(id)sender {
    self.selectedIdentifierLabel.text = [NSString stringWithFormat:@"Selected menu item: %@", self.popOutMenu.selectedIdentifier];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.popOutMenu.interitemSpacing = 100.f;
    [self.popOutMenu addTarget:self action:@selector(popOutMenuValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    UIColor *menuItemBackgroundColor = self.view.backgroundColor;
    
    UIButton *menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
    menuItem.translatesAutoresizingMaskIntoConstraints = NO;
    [menuItem setBackgroundColor:menuItemBackgroundColor];
    [menuItem setImage:[UIImage imageNamed:@"E84SingleScreenMenuItem"] forState:UIControlStateNormal];
    [self.popOutMenu addPopOutMenuItem:menuItem forIdentifier:@"SingleScreen"];
    
    menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
    menuItem.translatesAutoresizingMaskIntoConstraints = NO;
    [menuItem setBackgroundColor:menuItemBackgroundColor];
    [menuItem setImage:[UIImage imageNamed:@"E84SplitScreenMenuItem"] forState:UIControlStateNormal];
    [self.popOutMenu addPopOutMenuItem:menuItem forIdentifier:@"SplitScreen"];

    menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
    menuItem.translatesAutoresizingMaskIntoConstraints = NO;
    [menuItem setBackgroundColor:menuItemBackgroundColor];
    [menuItem setImage:[UIImage imageNamed:@"E84PlayMenuItem"] forState:UIControlStateNormal];
    [self.popOutMenu addPopOutMenuItem:menuItem forIdentifier:@"Play"];

    menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
    menuItem.translatesAutoresizingMaskIntoConstraints = NO;
    [menuItem setBackgroundColor:menuItemBackgroundColor];
    [menuItem setImage:[UIImage imageNamed:@"E84AdjustmentMenuItem"] forState:UIControlStateNormal];
    [self.popOutMenu addPopOutMenuItem:menuItem forIdentifier:@"Adjustment"];
    
    self.selectedIdentifierLabel.text = [NSString stringWithFormat:@"Selected menu item: %@", self.popOutMenu.selectedIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
