//
//  searchPopupVIew.m
//  SteelonCall
//
//  Created by Venkat on 02/12/16.
//  Copyright © 2016 com.way2online. All rights reserved.
//

#import "searchPopupVIew.h"
#import "JMOTableViewCell.h"

@interface searchPopupVIew () <UITableViewDelegate,UITableViewDataSource>
@end

@implementation searchPopupVIew 

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        // the coverImage has a 5 pixels margin from its frame
        searchTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStyleGrouped];
       // searchTableView.frame = CGRectMake(0, 0,frame.size.width,frame.size.height);
        
        searchTableView.delegate =self;
        searchTableView.dataSource =self;
        searchTableView.showsVerticalScrollIndicator =YES;
        [self addSubview:searchTableView];
        [searchTableView reloadData];
        searchTableView.backgroundColor =[UIColor clearColor];
    }
    return self;
}
-(void)createView:(CGRect)frame{
    self.backgroundColor = [UIColor whiteColor];
    // the coverImage has a 5 pixels margin from its frame
    searchTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
    // searchTableView.frame = CGRectMake(0, 0,frame.size.width,frame.size.height);
    searchTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    searchTableView.delegate =self;
    searchTableView.dataSource =self;
    searchTableView.showsVerticalScrollIndicator =YES;
    [self addSubview:searchTableView];
    [searchTableView reloadData];
    searchTableView.backgroundColor =[UIColor clearColor];
}
-(void)updateInstaceFrame:(CGRect)frame{
    
    searchTableView.frame = CGRectMake(0, 0,frame.size.width,frame.size.height);
    
    [self needsUpdateConstraints];
    [self setNeedsDisplay];
    [self layoutIfNeeded];
}
#pragma mark TableView Delegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    return [_delegate setHeighForSearchTable:tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0)
    {
        return [_delegate numberOffRowsInSearchTableView:tableView];
    }
    else
        return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if(section == CUSTOM_SECTION)
//    {
//        return CUSTOM_VALUE;
//    }
    return 30;;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    /* Section header is in 0th index... */
    if (section==0)
    {
        [label setText:@""];
    }
    else
        [label setText:@"Communicate"];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor clearColor]]; //your background color...
    return view;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_delegate numberOfSectionsInTableView:tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // JMOTableViewCell *cell = [searchTableView dequeueReusableCellWithIdentifier:@"JMOTableViewCell"];
   // JMOTableViewCell *cell = ;
    
    return [_delegate cellforRowAtSearchINdex:tableView viewAtIndex:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_delegate searchTableViewSelected:tableView IndexPath:indexPath];
    
}



-(void)relaodSearchTable{

    [searchTableView reloadData];
}



@end
