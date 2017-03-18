//
//  ViewController.m
//  Clozbz
//
//  Created by sai on 3/16/17.
//  Copyright © 2017 sai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.email_tf setValue:[UIFont fontWithName: @"Arial" size: 18] forKeyPath:@"_placeholderLabel.font"];
    [self.pwd_tf setValue:[UIFont fontWithName: @"Arial" size: 18] forKeyPath:@"_placeholderLabel.font"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sign_in_click:(id)sender {
}

- (IBAction)register_click:(id)sender
{
    Registration *menuController  =[[Registration alloc]initWithNibName:@"Registration" bundle:nil];
    [self.navigationController pushViewController:menuController animated:YES];
}
@end
