//
//  Registration.m
//  Clozbz
//
//  Created by sai on 3/16/17.
//  Copyright © 2017 sai. All rights reserved.
//

#import "Registration.h"

@interface Registration ()
@property (strong, nonatomic) FIRDatabaseReference *ref;

@end

@implementation Registration

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _Loading.image = [YLGIFImage imageNamed:@"loading_players.gif"];
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
}
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    [self.view endEditing:YES];
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

- (IBAction)submit_click:(id)sender
{
    _Loading.hidden=NO;
    
    [self.view endEditing:YES];
    
    if ([self valide_Data] == YES)
    { // checking if the either of the string is empty and other validations
        [self User_Registration];
    }
    else
        _Loading.hidden=YES;
    
}

-(void)User_Registration
{
    [[FIRAuth auth]
     createUserWithEmail:_email.text
     password:_password.text
     completion:^(FIRUser *_Nullable user,
                  NSError *_Nullable error)
     {
         if(user)
         {
             NSLog(@"user data %@",user);
             [self Alert:@"Registration Success!"];
             [self.navigationController popViewControllerAnimated:YES];
         }
         else
         {
             [self Alert:@"Registration Failed!"];
             NSLog(@"%@",error);
         }
         _Loading.hidden=YES;

     }];
}

-(BOOL)valide_Data
{
    NSString *email_str = [_email.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *pwd_str=_password.text;
    NSString *Cpwd_str=_confirm_password.text;
    NSString *Name_str=_username.text;
    
    if  ( [Name_str length]==0)
    {
        [self Alert :@"Username should not be empty."];
        return NO;
    }
    else if  ( [email_str length]==0)
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
    else if ([pwd_str length] == 0||[Cpwd_str length]==0)
    {
        [self Alert :@"New Password should not be empty."];
        return NO;
    }
    else  if (![pwd_str isEqualToString:Cpwd_str])
    {
        [self Alert :@"Password mismatched."];
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
    if([_username isFirstResponder])
    {
        [_email becomeFirstResponder];
    }
    else if([_email isFirstResponder])
    {
        [_phone becomeFirstResponder];
    }
    else if([_phone isFirstResponder])
    {
        [_password becomeFirstResponder];
    }
    else if([_password isFirstResponder])
    {
        [_confirm_password becomeFirstResponder];
    }
    else if([_confirm_password isFirstResponder])
    {
        [_confirm_password resignFirstResponder];
    }
    return YES;
}
- (IBAction)login_click:(id)sender
{
    ViewController *menuController  =[[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    [self.navigationController pushViewController:menuController animated:YES];
}
@end
