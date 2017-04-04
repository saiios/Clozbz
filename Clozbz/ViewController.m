//
//  ViewController.m
//  Clozbz
//
//  Created by sai on 3/16/17.
//  Copyright © 2017 sai. All rights reserved.
//

#import "ViewController.h"
@import Firebase;

@interface ViewController ()
@property (strong, nonatomic) FIRDatabaseReference *ref;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    user_data=[NSUserDefaults standardUserDefaults];
    NSString *page=[user_data valueForKey:@"page"];
    [self.navigationController setNavigationBarHidden:YES animated:animated];

    if ([page isEqualToString:@"home"])
    {
        Home_ViewController *menuController  =[[Home_ViewController alloc]initWithNibName:@"Home_ViewController" bundle:nil];
        [self.navigationController pushViewController:menuController animated:YES];
    }
    else if ([page isEqualToString:@"zipcode"])
    {
        [self Go_To_Dashboard_page];
    }
    
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.ref = [[FIRDatabase database] reference];
    _Loading.image = [YLGIFImage imageNamed:@"loading_players.gif"];

    [self.email_tf setValue:[UIFont fontWithName: @"Arial" size: 18] forKeyPath:@"_placeholderLabel.font"];
    [self.pwd_tf setValue:[UIFont fontWithName: @"Arial" size: 18] forKeyPath:@"_placeholderLabel.font"];
    user_dict=[[NSMutableDictionary alloc]init];
    //gmail
   
    //signin
     [GIDSignIn sharedInstance].uiDelegate = self;
    // [[GIDSignIn sharedInstance] signIn];
    
    //FB
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.delegate = self;
    loginButton.readPermissions =
    @[@"public_profile", @"email", @"user_friends"];
    
    FIRAuthCredential *credential = [FIRFacebookAuthProvider
                                     credentialWithAccessToken:[FBSDKAccessToken currentAccessToken]
                                     .tokenString];
    
    
}

- (void)loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
              error:(NSError *)error
{
    _Loading.hidden=NO;

    if (error == nil)
    {
        FIRAuthCredential *credential = [FIRFacebookAuthProvider
                                         credentialWithAccessToken:[FBSDKAccessToken currentAccessToken]
                                         .tokenString];
        
        [[FIRAuth auth] signInWithCredential:credential
                                  completion:^(FIRUser *user, NSError *error)
         {
                                      if (error)
                                      {
                                          NSLog(@"error %@",error);
                                      }
             else
             {
                 NSLog(@"%@",result);

                 NSLog(@"%@",user.uid);
                 NSLog(@"%@",user.email);
                 _Loading.hidden=YES;

                 NSString *name=[NSString stringWithFormat:@"%@",user.displayName];
                 NSString *email=[NSString stringWithFormat:@"%@",user.email];
                 NSString *photo=[NSString stringWithFormat:@"%@",user.photoURL];
                 NSString *user_id=[NSString stringWithFormat:@"%@",user.uid];

                 user_data=[NSUserDefaults standardUserDefaults];
                 [user_data setValue:name forKey:@"name"];
                 [user_data setValue:email forKey:@"email"];
                 [user_data setValue:photo forKey:@"photo"];
                 [user_data setValue:user_id forKey:@"id"];

                 [self Go_To_Dashboard_page];
             }
         }];
    }
         else
         {
          NSLog(error.localizedDescription);
             _Loading.hidden=YES;

         }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sign_in_click:(id)sender
{
    _Loading.hidden=NO;
    
    [self.view endEditing:YES];
    
    if ([self valide_Data] == YES)
    { // checking if the either of the string is empty and other validations
        [self User_Login];
    }
    else
        _Loading.hidden=YES;
}

-(BOOL)valide_Data
{
    NSString *email_str = [_email_tf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *pwd_str=_pwd_tf.text;
    
    if  ( [email_str length]==0)
    {
        [self Alert :@"Email should not be empty."];
        return NO;
    }
    else if ([self NSStringIsValidEmail:email_str]== NO)
    {
        [self Alert :@"Email should be valid."];
        return NO;
    }
    else if ([pwd_str length] == 0)
    {
        [self Alert :@"Password should not be empty."];
        return NO;
    }
       return YES;
}

-(BOOL)NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(void)Alert:(NSString *)Msg
{
    NSDictionary *options = @{kCRToastNotificationTypeKey:@(CRToastTypeNavigationBar),
                              
                              kCRToastTextKey : Msg,
                              
                              kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                              
                              kCRToastBackgroundColorKey : [UIColor colorWithRed:13.0/255.0 green:147.0/255.0 blue:68.0/255.0 alpha:1],
                              kCRToastTimeIntervalKey: @(2),
                              //                              kCRToastFontKey:[UIFont fontWithName:@"PT Sans Narrow" size:23],
                              kCRToastInteractionRespondersKey:@[[CRToastInteractionResponder interactionResponderWithInteractionType:CRToastInteractionTypeSwipeUp
                                                                  
                                                                                                                 automaticallyDismiss:YES
                                                                  
                                                                                                                                block:^(CRToastInteractionType interactionType){
                                                                                                                                    
                                                                                                                                    NSLog(@"Dismissed with %@ interaction", NSStringFromCRToastInteractionType(interactionType));
                                                                                                                                }]],
                              kCRToastAnimationInTypeKey : @(CRToastAnimationTypeGravity),
                              
                              kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeGravity),
                              
                              kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                              
                              kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop)
                              };
    
    [CRToastManager showNotificationWithOptions:options
                                completionBlock:^{
                                    NSLog(@"Completed");
                                }];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([_email_tf isFirstResponder])
    {
        [_pwd_tf becomeFirstResponder];
    }
    else if([_pwd_tf isFirstResponder])
    {
        [_pwd_tf resignFirstResponder];
    }
    return YES;
}
-(void)User_Login
{
    [[FIRAuth auth]
                    signInWithEmail:_email_tf.text
                            password:_pwd_tf.text
     completion:^(FIRUser *_Nullable user,
                  NSError *_Nullable error)
     {
         if(user)
         {
             NSLog(@"user data %@",user);
             [self Alert:@"Login Success!"];
             
             NSString *name=[NSString stringWithFormat:@"%@",user.displayName];
             NSString *email=[NSString stringWithFormat:@"%@",user.email];
             NSString *photo=[NSString stringWithFormat:@"%@",user.photoURL];
             NSString *user_id=[NSString stringWithFormat:@"%@",user.uid];
             
             user_data=[NSUserDefaults standardUserDefaults];
             [user_data setValue:name forKey:@"name"];
             [user_data setValue:email forKey:@"email"];
             [user_data setValue:photo forKey:@"photo"];
             [user_data setValue:user_id forKey:@"id"];
             
             [self Go_To_Dashboard_page];
         }
         else
         {
             [self Alert:@"Login Failed!"];
             NSLog(@"%@",error);
         }
         _Loading.hidden=YES;
     }];
}

-(void)Go_To_Dashboard_page
{
    Dashboard_page *menuController  =[[Dashboard_page alloc]initWithNibName:@"Dashboard_page" bundle:nil];
    [self.navigationController pushViewController:menuController animated:YES];
}

- (IBAction)register_click:(id)sender
{
    Registration *menuController  =[[Registration alloc]initWithNibName:@"Registration" bundle:nil];
    [self.navigationController pushViewController:menuController animated:YES];
}

- (IBAction)fb_click:(id)sender
{
   
}

@end
