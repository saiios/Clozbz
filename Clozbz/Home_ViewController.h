//
//  Home_ViewController.h
//  Clozbz
//
//  Created by INDOBYTES on 24/03/17.
//  Copyright © 2017 sai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMOTableViewCell.h"
#import "searchPopupVIew.h"

@interface Home_ViewController : UIViewController<searchTableViewDelegate>
{
    BOOL isMenuActive;
    NSArray *leftMenuArray,*menu_ary,*leftMenu_imgs,*leftMenu_imgs_1;
    CGRect leftmenuRect;
    NSIndexPath *path;
    int presentIndex;
    NSUserDefaults *user_data;
}
- (IBAction)back_click:(id)sender;

//
@property (strong, nonatomic) IBOutlet UIImageView *profileImageVIew;
@property (strong, nonatomic) IBOutlet NSString *user_name_str;

@property (strong, nonatomic) IBOutlet UIView *leftMenuContentView;
@property (strong, nonatomic) IBOutlet UIView *leftMenuBgView;
@property (strong, nonatomic) IBOutlet searchPopupVIew *leftMenuTable;
- (IBAction)profile_click:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *mat_id;
@end
