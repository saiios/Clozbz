 //
//  Dashboard_page.m
//  Clozbz
//
//  Created by sai on 3/18/17.
//  Copyright © 2017 sai. All rights reserved.
//

#import "Dashboard_page.h"

@interface Dashboard_page ()
@end

@implementation Dashboard_page
- (void)viewDidLoad
{
    [super viewDidLoad];
    map_bool=NO;
    // Do any additional setup after loading the view from its nib.
//    self.navigationItem.hidesBackButton = YES;
//    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(back:)];
//    self.navigationItem.leftBarButtonItem = newBackButton;
    
    //sign out
    NSError *signOutError;

    BOOL status = [[FIRAuth auth] signOut:&signOutError];
    if (!status)
    {
        NSLog(@"Error signing out: %@", signOutError);
        return;
    }
    else
    {
        NSLog(@"Logout Success");
        [[GIDSignIn sharedInstance] signOut];
    }
    user_data=[NSUserDefaults standardUserDefaults];
    [user_data setValue:@"zipcode" forKey:@"page"];
    
    //fb
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    
    //The setup code (in viewDidLoad in your view controller)
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.location_view addGestureRecognizer:singleFingerTap];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    _Loading.hidden=NO;

    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    map_bool=YES;

    //Do stuff here...
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [locationManager requestWhenInUseAuthorization];
    
    [locationManager startUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (map_bool == YES)
    {
        map_bool=NO;
    currentLocation = [locations objectAtIndex:0];
    [locationManager stopUpdatingLocation];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!(error))
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             NSLog(@"\nCurrent Location Detected\n");
             NSLog(@"placemark %@",placemark);
             NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
             
             NSString *Address = [[NSString alloc]initWithString:locatedAt];
             NSString *Zipcode = [[NSString alloc]initWithString:placemark.postalCode];
             NSLog(@"%@",Zipcode);
             _zipcode_tf.text=Zipcode;
             _Loading.hidden=YES;
         }
         else
         {
             NSLog(@"Geocode failed with error %@", error); // Error handling must required
         }
     }];
    }
}

- (void) back:(UIBarButtonItem *)sender
{
    ViewController *menuController  =[[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    [self.navigationController pushViewController:menuController animated:YES];}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([_zipcode_tf isFirstResponder])
    {
        [_zipcode_tf resignFirstResponder];
    }
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
- (IBAction)submit_click:(id)sender
{
    if (![_zipcode_tf.text isEqualToString:@""])
    {
        Home_ViewController *menuController  =[[Home_ViewController alloc]initWithNibName:@"Home_ViewController" bundle:nil];
        [self.navigationController pushViewController:menuController animated:YES];
    }
    else
        [self Alert:@"Enter ZipCode!"];
}
@end
