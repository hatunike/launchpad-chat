//
<<<<<<< .merge_file_LL1O2g
//  UINewUserViewController.m
//  Launchpad-chat
//
//  Created by STUDENT #6 on 2/19/15.
=======
//  LoginViewController.m
//  Launchpad-chat
//
//  Created by STUDENT #3 on 2/12/15.
>>>>>>> .merge_file_z9aiRW
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import "UINewUserViewController.h"

@interface UINewUserViewController ()

<<<<<<< .merge_file_LL1O2g
@end

@implementation UINewUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
=======
@property (nonatomic, retain)IBOutlet UITextField *usernameField;
@property (nonatomic, retain)IBOutlet UITextField *passwordField;
@end

@implementation UINewUserViewController
static NSString * const reuseIdentifier = @"Cell";
- (void)viewDidLoad {
    [super viewDidLoad];
>>>>>>> .merge_file_z9aiRW
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

<<<<<<< .merge_file_LL1O2g
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
=======


- (IBAction)btn_login_submit:(id)sender {
    if([self.usernameField.text isEqual:@"Launchpad"] && [self.passwordField.text isEqual:@"Launchpad"]){
        [self performSegueWithIdentifier:@"LoginToUser" sender:nil];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect"
                                                        message:@"Please enter the correct usename and password"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}


>>>>>>> .merge_file_z9aiRW

@end
