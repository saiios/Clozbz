//
//  Dashboard_page.h
//  Clozbz
//
//  Created by sai on 3/18/17.
//  Copyright © 2017 sai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "Home_ViewController.h"
#import "CRToastView.h"
#import "YLGIFImage.h"
#import "YLImageView.h"
@interface Dashboard_page : UIViewController<UITextFieldDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    BOOL map_bool;
}
@property (weak, nonatomic) IBOutlet UIView *location_view;
@property (weak, nonatomic) IBOutlet UITextField *zipcode_tf;
- (IBAction)submit_click:(id)sender;
@property (strong, nonatomic) IBOutlet YLImageView *Loading;

@end
