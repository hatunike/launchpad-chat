//
//  UIAvaterViewController.m
//  Launchpad-chat
//
//  Created by STUDENT #5 on 3/17/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import "UIAvaterViewController.h"

@interface UIAvaterViewController ()

@end

@implementation UIAvaterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Confirm:(id)sender
{
    UIImagePickerController *pickerLibrary = [[UIImagePickerController alloc] init];
    pickerLibrary.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerLibrary.delegate = self;
    [self presentModalViewController:pickerLibrary animated:YES];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    UIImage *myImage = image;
    
    [User setAvatar:myImage forUser:<#(User *)#> inContext:<#(NSManagedObjectContext *)#>]
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
