//
//  ViewController.m
//  UserNotifications_Sample
//
//  Created by SDTeam on 2016. 10. 17..
//  Copyright © 2016년 SDTeam. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController ()

@end

@implementation ViewController

@synthesize button, imgView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [imgView setImage:[UIImage imageNamed:@"direction"]];
}

- (void)viewWillAppear:(BOOL)animated {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(showNotification) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)showNotification {
    
    NSLog(@"show notification.");
    
    NSString *title = @"회전정보안내";
    NSString *body = @"";
    NSURL *url;
    NSInteger time = CFAbsoluteTimeGetCurrent();
    if (time % 2 == 0) {
        body = @"우회전입니다.";
        url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"right" ofType:@"png"]];
    }else {
        body = @"좌회전입니다.";
        url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"left" ofType:@"png"]];
    }
    
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:title arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:body arguments:nil];
    //content.sound = [UNNotificationSound defaultSound];
    
    // modify thumbnail image of notification
    //CFDictionaryRef ref = CGRectCreateDictionaryRepresentation(CGRectMake(0, 0, 1, 1));
    //NSDictionary *andBack = (__bridge NSDictionary*)ref;
    //NSDictionary *dic = [NSDictionary dictionaryWithObject:andBack forKey:UNNotificationAttachmentOptionsThumbnailClippingRectKey];
    //UNNotificationAttachment *attach = [UNNotificationAttachment attachmentWithIdentifier:@"imageAttach" URL:url options:dic error:nil];
    
    UNNotificationAttachment *attach = [UNNotificationAttachment attachmentWithIdentifier:@"imageAttach" URL:url options:nil error:nil];
    content.attachments = [NSArray arrayWithObjects:attach, nil];
    
    UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"timeInterval" content:content trigger:trigger];
    
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
    }];

}

@end
