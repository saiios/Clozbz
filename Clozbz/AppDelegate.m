//
//  AppDelegate.m
//  Clozbz
//
//  Created by sai on 3/16/17.
//  Copyright © 2017 sai. All rights reserved.
//

#import "AppDelegate.h"
@import Firebase;
@import GoogleSignIn;

@interface AppDelegate ()

@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    tag=YES;
    [FIRApp configure];
    
    [GIDSignIn sharedInstance].clientID = [FIRApp defaultApp].options.clientID;
    [GIDSignIn sharedInstance].delegate = self;
    // Return successful Facebook SDK Install
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
    return YES;
}

- (BOOL)application:(nonnull UIApplication *)application
            openURL:(nonnull NSURL *)url
            options:(nonnull NSDictionary<NSString *, id> *)options
{
    NSString *url_str=[NSString stringWithFormat:@"%@",url];
    if ([url_str containsString:@"fb"])
    {
        return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                              openURL:url
                                                    sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                           annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
      
    }
    else
        return [[GIDSignIn sharedInstance] handleURL:url
                                   sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                          annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
}

//For your app to run on iOS 8 and older, also implement the deprecated application:openURL:sourceApplication:annotation: method.
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    NSString *url_str=[NSString stringWithFormat:@"%@",url];
    if ([url_str containsString:@"fb"])
    {
        BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                      openURL:url
                                                            sourceApplication:sourceApplication
                                                                   annotation:annotation
                        ];
        // Add any custom logic here.
        return handled;
    }
    else
    return [[GIDSignIn sharedInstance] handleURL:url
                               sourceApplication:sourceApplication
                                      annotation:annotation];
}

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error
{
    if (error == nil)
    {
        if (tag ==YES)
        {
            tag=NO;
            [[GIDSignIn sharedInstance] signIn];
        }
        else
        {
            GIDAuthentication *authentication = user.authentication;
            FIRAuthCredential *credential =
            [FIRGoogleAuthProvider credentialWithIDToken:authentication.idToken
                                             accessToken:authentication.accessToken];
            
            // ...
            // Perform any operations on signed in user here.
            NSString *userId = user.userID;
            // For client-side use only!
            NSString *idToken = user.authentication.idToken;
            // Safe to send to the server
            NSString *fullName = user.profile.name;
            NSString *givenName = user.profile.givenName;
            NSString *familyName = user.profile.familyName;
            NSString *email = user.profile.email;
            
            [[FIRAuth auth] signInWithCredential:credential
                                      completion:^(FIRUser *user, NSError *error)
             {
                 // ...
                 if (error)
                 {
                     // ...
                     NSLog(@"%@",error);
                 }
                 else
                 {
                     NSLog(@"%@",user.uid);
                     
                     NSString *name=[NSString stringWithFormat:@"%@",user.displayName];
                     NSString *email=[NSString stringWithFormat:@"%@",user.email];
                     NSString *photo=[NSString stringWithFormat:@"%@",user.photoURL];
                     NSString *user_id=[NSString stringWithFormat:@"%@",user.uid];
                     
                     user_data=[NSUserDefaults standardUserDefaults];
                     [user_data setValue:name forKey:@"name"];
                     [user_data setValue:email forKey:@"email"];
                     [user_data setValue:photo forKey:@"photo"];
                     [user_data setValue:user_id forKey:@"id"];
                     
                     Dashboard_page *menuController  =[[Dashboard_page alloc]initWithNibName:@"Dashboard_page" bundle:nil];
                     UINavigationController *navigationController=[[UINavigationController alloc] initWithRootViewController:menuController];
                     self.window.rootViewController =nil;
                     self.window.rootViewController = navigationController;
                     [self.window makeKeyAndVisible];

                 }
             }];

        }
    }
    
}

- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error
{
    // Perform any operations when the user disconnects from app here.
    // ...
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Clozbz"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
