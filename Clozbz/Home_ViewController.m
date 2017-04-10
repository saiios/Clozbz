//
//  Home_ViewController.m
//  Clozbz
//
//  Created by INDOBYTES on 24/03/17.
//  Copyright © 2017 sai. All rights reserved.
//

#import "Home_ViewController.h"
@import Firebase;

@interface Home_ViewController ()
@property (strong, nonatomic) FIRDatabaseReference *ref;

@end

@implementation Home_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    leftMenuArray = @[@"Home",@"Chat",@"My Offers",@"Settings"];
    leftMenu_imgs = @[@"240_male.png",@"240_male.png",@"240_male.png",@"240_male.png"];
    leftMenu_imgs_1 = @[@"240_male.png",@"240_male.png"];
    
    menu_ary=@[@"Share",@"Help"];
    _leftMenuTable.delegate =self;
    [_leftMenuTable createView:_leftMenuTable.frame];
    
    self.ref = [[FIRDatabase database] reference];

    _leftMenuBgView.frame = [UIScreen mainScreen].bounds;
    leftmenuRect = _leftMenuContentView.frame;

     [_collection_view registerNib:[UINib nibWithNibName:@"Pic_Cell" bundle:nil] forCellWithReuseIdentifier:@"Pic_Cell_id"];
    [_collection_view reloadData];
    user_data=[NSUserDefaults standardUserDefaults];
    [user_data setValue:@"home" forKey:@"page"];

    NSString *name=[user_data valueForKey:@"name"];
    NSString *email=[user_data valueForKey:@"email"];
    NSString *photo=[user_data valueForKey:@"photo"];
    user_id=[user_data valueForKey:@"id"];
    
    if ([email isEqual:[NSNull null]]|| [email isEqualToString:@""]|| [email isEqualToString:@"(null)"])
    {
        _username.text=@"";
    }
    else
    {
    _username.text=email;
    }
    if ([photo isEqual:[NSNull null]]|| [photo isEqualToString:@""]|| [photo isEqualToString:@"(null)"])
    {
    }
    else
    {
        NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",photo]];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            dispatch_async(dispatch_get_main_queue(),
                           ^{
                               _profileImageVIew.image = [UIImage imageWithData:imageData];
                               _profileImageVIew.contentMode = UIViewContentModeScaleToFill;
                           });
        });
    }
    
    [[_ref child:@"AdPost"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot)
     {
         NSDictionary *Dict = snapshot.value;
         user_ids_ary =[Dict allKeys];
         adds_imgs=[[NSMutableArray alloc]init];
         
         for (int d=0; d<Dict.count; d++)
         {
           //  NSMutableArray *post_ids_ary=[[NSMutableArray alloc]init];
             if ([[user_ids_ary objectAtIndex:d] isEqualToString:user_id])
             {
             }
             else
             {
                NSArray *ids_ary =[[Dict valueForKey:[user_ids_ary objectAtIndex:d]] allKeys];
                NSDictionary *U_Dict=[Dict valueForKey:[user_ids_ary objectAtIndex:d]];

                 for (int d=0; d<U_Dict.count; d++)
                 {
                     NSDictionary *add_Dict=[U_Dict valueForKey:[ids_ary objectAtIndex:d]];
                     [adds_imgs addObject:[add_Dict valueForKey:@"profile_Url"]];
                 }
             }
         }
         
      //   usersDict=[Dict valueForKey:@"cuK54W0BtLRGwllLI5dJMiPbHEO2"];
       //  adpost_keys=[usersDict allKeys];
         [_collection_view reloadData];

         //        [self configure:[user_data objectForKey:@"username"]];
     }];
    /*
     //Data Getting & Sending
     //    [[[_ref child:@"users"] child:@"123456"]
     //     setValue:@{@"username": @"sai"}];
     
     [[_ref child:@"users"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot)
     {
     NSDictionary *usersDict = snapshot.value;
     NSDictionary *user_data=[usersDict valueForKey:@"user_id1"];
     NSLog(@"%@",user_data);
     //        [self configure:[user_data objectForKey:@"username"]];
     _username.text = [user_data objectForKey:@"username"];
     _password.text = [user_data objectForKey:@"password"];
     
     }];
     */
    //    [[[[_ref child:@"users"] child:@"23124"] child:@"username"] setValue:username];

    /*
     //status
     NSError *signOutError;
     BOOL status = [[FIRAuth auth] signOut:&signOutError];
     if (!status)
     {
     NSLog(@"Error signing out: %@", signOutError);
     return;
     }
     */


}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return adds_imgs.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Adjust cell size for orientation
    return CGSizeMake(_collection_view.frame.size.width/3-20, _collection_view.frame.size.width/3-20);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"Pic_Cell_id";
    
    Pic_Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
   // NSString *img_str=[[usersDict valueForKey:[adpost_keys objectAtIndex:indexPath.row]]valueForKey:@"profile_Url"];
    
    NSString *img_str=[adds_imgs objectAtIndex:indexPath.row];
    if ([img_str isEqual:[NSNull null]]|| [img_str isEqualToString:@""])
    {
    }
    else
    {
        NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",img_str]];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            dispatch_async(dispatch_get_main_queue(),
                           ^{
                               cell.img.image = [UIImage imageWithData:imageData];
                               cell.img.contentMode = UIViewContentModeScaleToFill;
                           });
        });
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
}

- (void)didReceiveMemoryWarning
{
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

- (IBAction)post_ad_click:(id)sender
{
    Post_Add *menuController  =[[Post_Add alloc]initWithNibName:@"Post_Add" bundle:nil];
  //  [self.navigationController pushViewController:menuController animated:YES];
}

- (IBAction)back_click:(id)sender
{
   // [self.navigationController popViewControllerAnimated:YES];
    isMenuActive =YES;
    _leftMenuBgView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:_leftMenuBgView];
    _leftMenuBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    _leftMenuContentView.frame = CGRectMake(-[UIScreen mainScreen].bounds.size.width,0, leftmenuRect.size.width, leftmenuRect.size.height);
    [_leftMenuTable updateInstaceFrame:CGRectMake(_leftMenuTable.frame.origin.x,_leftMenuTable.frame.origin.y,_leftMenuTable.frame.size.width,_leftMenuTable.frame.size.height)];
    
    
    
    [UIView animateWithDuration:0.5 animations:^{
        _leftMenuContentView.frame =CGRectMake(0,0, leftmenuRect.size.width, leftmenuRect.size.height);
        _leftMenuBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        
    } completion:^(BOOL finished) {
        
        
    }];
    

}

//left menu
-(void)viewDidAppear:(BOOL)animated
{
    [_leftMenuTable updateInstaceFrame:CGRectMake(_leftMenuTable.frame.origin.x,_leftMenuTable.frame.origin.y,_leftMenuTable.frame.size.width,_leftMenuTable.frame.size.height)];
}


-(void)closeMenu{
    isMenuActive = NO;
    
    
    [UIView animateWithDuration:0.5 animations:^{
        _leftMenuContentView.frame = CGRectMake(-[UIScreen mainScreen].bounds.size.width,0, leftmenuRect.size.width, leftmenuRect.size.height);
        
        _leftMenuBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        
    } completion:^(BOOL finished) {
        [_leftMenuBgView removeFromSuperview];
        
    }];
    
    
}
- (IBAction)closeLeftMenu:(id)sender {
    [self closeMenu];
    
}

#pragma mark LeftMenu Delegates
-(float)setHeighForSearchTable:(UITableView *)tableView
{
    return 40;
}

-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger )numberOffRowsInSearchTableView:(UITableView *)tableView
{
    return leftMenuArray.count;
}

- (JMOTableViewCell *)cellforRowAtSearchINdex:(UITableView*)tableVIew viewAtIndex:(NSIndexPath *)index
{
    
    JMOTableViewCell *cell = [tableVIew dequeueReusableCellWithIdentifier:@"searchCell"];
    if (cell==nil)
    {
        [tableVIew registerNib:[UINib nibWithNibName:@"JMOTableViewCell" bundle:nil] forCellReuseIdentifier:@"searchCell"];
        cell = [tableVIew dequeueReusableCellWithIdentifier:@"searchCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //text
    if (index.section==1)
    {
        cell.labelName.text =[menu_ary objectAtIndex:index.row];
    }
    else
        cell.labelName.text =[leftMenuArray objectAtIndex:index.row];
    
    //images
    if (index.section==1)
    {
        cell.img.image=[UIImage imageNamed:[leftMenu_imgs_1 objectAtIndex:index.row]];
    }
    else
        cell.img.image=[UIImage imageNamed:[leftMenu_imgs objectAtIndex:index.row]];
    return cell;
}

-(void)searchTableViewSelected:(UITableView *)table IndexPath:(NSIndexPath * )indexPath
{
    if (indexPath.section==1)
    {
        if (indexPath.row==0)
        {
            //[self faq];
        }
        else if (indexPath.row==1)
        {
            //[self contact_us];
        }
    }
    else{
        if (indexPath.row==0)
        {
        }
        else if (indexPath.row==1)
        {
//            Mail *menuController  =[[Mail alloc]initWithNibName:@"Mail" bundle:nil];
//            [self.navigationController pushViewController:menuController animated:YES];
        }
        else if (indexPath.row==2)
        {
            NSLog(@"DailyRecommendations");
//            DailyRecommendations *menuController  =[[DailyRecommendations alloc]initWithNibName:@"DailyRecommendations" bundle:nil];
//            [self.navigationController pushViewController:menuController animated:YES];
        }
        else if (indexPath.row==3)
        {
            NSLog(@"Add Member");
        }
        else if (indexPath.row==4)
        {
            NSLog(@"Update Account");
            //[self upgrade_account];
        }
       
    [self closeMenu];
 }
}
@end
