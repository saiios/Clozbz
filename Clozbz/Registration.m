//
//  Registration.m
//  Clozbz
//
//  Created by sai on 3/16/17.
//  Copyright © 2017 sai. All rights reserved.
//

#import "Registration.h"

@interface Registration ()

@end

@implementation Registration

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)submit_click:(id)sender {
}

- (IBAction)login_click:(id)sender
{
    ViewController *menuController  =[[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    [self.navigationController pushViewController:menuController animated:YES];
}
@end
