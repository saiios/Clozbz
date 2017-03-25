//
//  AppDelegate.h
//  Clozbz
//
//  Created by sai on 3/16/17.
//  Copyright © 2017 sai. All rights reserved.
//sai

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Dashboard_page.h"
#import "ViewController.h"

@import GoogleSignIn;

@interface AppDelegate : UIResponder <UIApplicationDelegate,GIDSignInDelegate>
{
    BOOL tag;
}
@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

