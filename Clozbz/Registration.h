//
//  Registration.h
//  Clozbz
//
//  Created by sai on 3/16/17.
//  Copyright © 2017 sai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFloatLabelTextField.h"
#import "ViewController.h"
#import "CRToastView.h"
#import "YLGIFImage.h"
#import "YLImageView.h"
@import Firebase;

@interface Registration : UIViewController
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *username;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *email;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *phone;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *password;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *confirm_password;
- (IBAction)submit_click:(id)sender;
- (IBAction)login_click:(id)sender;
@property (strong, nonatomic) IBOutlet YLImageView *Loading;

@end
