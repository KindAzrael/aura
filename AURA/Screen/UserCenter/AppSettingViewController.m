//
//  AppSettingViewController.m
//  AURA
//
//  Created by MacMiniS on 14-10-13.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "AppSettingViewController.h"
#import "DataManager.h"
#import "ViewControllerContainer.h"
#import "MainToolbar.h"

@interface AppSettingViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation AppSettingViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.scrollView.frame = CGRectMake(0, 0, 320, 504);
  self.scrollView.contentSize = CGSizeMake(320, 600);
  [self initNav];
}

- (void)initNav {
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickBack)];
  self.title = @"应用设置";
}

- (void)onClickBack {
  [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onClickLogout:(id)sender {
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定要退出吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
  [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
    [DataManager logout];
    [ViewControllerContainer showLoginViewController];
  }]];
  [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
    
  }]];
  [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)onClickClearCash:(id)sender {
}

- (IBAction)onClickMessage:(id)sender {
}

- (IBAction)onClickMark:(id)sender {
}

- (IBAction)onClickAbout:(id)sender {
  [ViewControllerContainer showAbout];
}
- (IBAction)onClickLicense:(id)sender {
  [ViewControllerContainer showLicense];
}
- (IBAction)onClickSuggest:(id)sender {
  
}
- (IBAction)onClickWp:(id)sender {
  [ViewControllerContainer showWPViewController];
  [MainToolbar clearToolbar];
}
- (IBAction)onClickNav:(id)sender {
  [ViewControllerContainer showUsing];
}

- (IBAction)onClickWelcome:(id)sender {
  [ViewControllerContainer showWelcome];
  [MainToolbar clearToolbar];
}

@end
