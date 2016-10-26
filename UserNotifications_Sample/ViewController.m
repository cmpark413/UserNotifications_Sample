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

@synthesize imgView;

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
    
    NSString* title = @"Title String";
    NSString* subtitle = @"SubTitle String";
    NSString* body = @"Body String";
    NSURL* url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"right" ofType:@"png"]];
    
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:title arguments:nil];
    content.subtitle = [NSString localizedUserNotificationStringForKey:subtitle arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:body arguments:nil];
    content.sound = [UNNotificationSound defaultSound];
    
    // modify thumbnail image of notification
    // CFDictionaryRef ref = CGRectCreateDictionaryRepresentation(CGRectMake(0.25f, 0.25f, 0.5f, 0.5f)); // default CGRectMake(0, 0, 1, 1)
    // NSDictionary* optionDic = [NSDictionary dictionaryWithObject:(__bridge NSDictionary*)ref forKey:UNNotificationAttachmentOptionsThumbnailClippingRectKey];
    // UNNotificationAttachment *attach = [UNNotificationAttachment attachmentWithIdentifier:@"imageAttach" URL:url options:optionDic error:nil];
    
    UNNotificationAttachment *attach = [UNNotificationAttachment attachmentWithIdentifier:@"imageAttach" URL:url options:nil error:nil];
    content.attachments = [NSArray arrayWithObjects:attach, nil];
    
    UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"timeInterval" content:content trigger:trigger];
    
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
    }];

}

@end
