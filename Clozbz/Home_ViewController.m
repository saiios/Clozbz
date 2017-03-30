//
//  Home_ViewController.m
//  Clozbz
//
//  Created by INDOBYTES on 24/03/17.
//  Copyright © 2017 sai. All rights reserved.
//

#import "Home_ViewController.h"

@interface Home_ViewController ()

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
    

    _leftMenuBgView.frame = [UIScreen mainScreen].bounds;
    leftmenuRect = _leftMenuContentView.frame;

    user_data=[NSUserDefaults standardUserDefaults];
    [user_data setValue:@"home" forKey:@"page"];

    NSString *name=[user_data valueForKey:@"name"];
    NSString *email=[user_data valueForKey:@"email"];
    NSString *photo=[user_data valueForKey:@"photo"];
    NSString *user_id=[user_data valueForKey:@"id"];
    
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

}
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
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
