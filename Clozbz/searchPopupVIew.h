//
//  searchPopupVIew.h
//  SteelonCall
//
//  Created by Venkat on 02/12/16.
//  Copyright © 2016 com.way2online. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMOTableViewCell.h"
@protocol searchTableViewDelegate <NSObject>
@required

-(float)setHeighForSearchTable:(UITableView *)tableView;
-(NSInteger )numberOffRowsInSearchTableView:(UITableView *)tableView;
-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView;

- (JMOTableViewCell *)cellforRowAtSearchINdex:(UITableView*)tableVIew viewAtIndex:(NSIndexPath *)index;

@optional
-(void)searchTableViewSelected:(UITableView *)table IndexPath:(NSIndexPath * )indexPath ;

@end


@interface searchPopupVIew : UIView<UITableViewDelegate ,UITableViewDataSource>
{
    UITableView *searchTableView;
}


-(void)createView:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame ;
@property (nonatomic, weak) id <searchTableViewDelegate> delegate;
-(void)relaodSearchTable;
-(void)updateInstaceFrame:(CGRect)frame;

@end
