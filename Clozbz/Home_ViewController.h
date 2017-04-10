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
#import "Pic_Cell.h"
#import "Post_Add.h"

@interface Home_ViewController : UIViewController<searchTableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    BOOL isMenuActive;
    NSArray *leftMenuArray,*menu_ary,*leftMenu_imgs,*leftMenu_imgs_1,*adpost_keys;
    CGRect leftmenuRect;
    NSIndexPath *path;
    int presentIndex;
    NSUserDefaults *user_data;
    NSDictionary *usersDict;
    NSArray *user_ids_ary;
    NSString *user_id;
    NSMutableArray *adds_imgs;
}
- (IBAction)post_ad_click:(id)sender;
- (IBAction)back_click:(id)sender;
@property (strong, nonatomic) IBOutlet UICollectionView *collection_view;

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
