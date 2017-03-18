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

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *email_tf;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *pwd_tf;
- (IBAction)sign_in_click:(id)sender;
- (IBAction)register_click:(id)sender;

@end

