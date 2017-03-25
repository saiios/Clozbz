//
//  ViewController.h
//  Clozbz
//
//  Created by sai ios on 3/16/17.
//  Copyright © 2017 sai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFloatLabelTextField.h"
#import "Registration.h"
#import "Dashboard_page.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "YLImageView.h"
#import "YLGIFImage.h"
@import GoogleSignIn;

@interface ViewController : UIViewController<GIDSignInUIDelegate,FBSDKLoginButtonDelegate>
@property(weak, nonatomic) IBOutlet GIDSignInButton *signInButton;
@property(weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;

@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *email_tf;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *pwd_tf;
- (IBAction)sign_in_click:(id)sender;
- (IBAction)register_click:(id)sender;
- (IBAction)fb_click:(id)sender;
-(void)Go_To_Dashboard_page;
@property (strong, nonatomic) IBOutlet YLImageView *Loading;

@end

