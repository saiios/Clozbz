//
//  Post_Add.m
//  Clozbz
//
//  Created by sai on 4/5/17.
//  Copyright © 2017 sai. All rights reserved.

#import "Post_Add.h"
@import Firebase;
@import Photos;
@import FirebaseStorage;

@interface Post_Add ()
{
    FIRStorage *storage;
}
@end

@implementation Post_Add
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //gallary
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
    
    /*
     //cam
     if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
     
     UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
     message:@"Device has no camera"
     delegate:nil
     cancelButtonTitle:@"OK"
     otherButtonTitles: nil];
     
     [myAlertView show];
     
     } else {
     
     UIImagePickerController *picker = [[UIImagePickerController alloc] init];
     picker.delegate = self;
     picker.allowsEditing = YES;
     picker.sourceType = UIImagePickerControllerSourceTypeCamera;
     [self presentViewController:picker animated:YES completion:NULL];
     }
     */
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
     _img.image = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    // Data in memory
    CGDataProviderRef provider = CGImageGetDataProvider(_img.image.CGImage);
    NSData* data = (id)CFBridgingRelease(CGDataProviderCopyData(provider));
    
    FIRStorageReference *storageRef = [storage reference];
    FIRStorageReference *mountainImagesRef = [storageRef child:@"images/sai.jpg"];

    // Create a reference to the file you want to upload
    FIRStorageReference *riversRef = [storageRef child:@"images/sai.jpg"];
    
    // Upload the file to the path "images/rivers.jpg"
    FIRStorageUploadTask *uploadTask = [riversRef putData:data
                                                 metadata:nil
                                               completion:^(FIRStorageMetadata *metadata,
                                                            NSError *error)
                                        {
                                                   if (error != nil)
                                                   {
                                                       // Uh-oh, an error occurred!
                                                   }
                                                   
                                                   else
                                                   {
                                                       // Metadata contains file metadata such as size, content-type, and download URL.
                                                       NSURL *downloadURL = metadata.downloadURL;
                                                   }
                                               }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
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

@end
