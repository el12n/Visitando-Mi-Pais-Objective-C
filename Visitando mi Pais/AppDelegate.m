//
//  AppDelegate.m
//  Visitando mi Pais
//
//  Created by Alvaro De la Cruz Lockhart on 3/19/15.
//  Copyright (c) 2015 Alvaro De la Cruz Lockhart. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    [self getCalendarPermission];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void) getCalendarPermission{
    self.eventStore = [[EKEventStore alloc] init];
    [self.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error){
        if (granted) {
            NSLog(@"Access granted");
            self.calendar =  [self loadApplicationCalendar];
        }else{
            NSLog(@"Access denied");
            NSLog(@"Error: %@", error.localizedDescription);
        }
    }];
}

-(EKCalendar *)loadApplicationCalendar{
    NSArray *calendars = [self.eventStore calendarsForEntityType:EKEntityTypeEvent];
    for(EKCalendar *calendar in calendars){
        if([calendar.title isEqualToString:@"Visitando mi Pais"]){
            return calendar;
        }
    }
    return [self createLocalCalendar];
}

-(EKCalendar *)createLocalCalendar{
    EKCalendar *calendar = [EKCalendar calendarForEntityType:EKEntityTypeEvent eventStore:self.eventStore ];
    EKSource *localSource = [[EKSource alloc] init];
    for(EKSource *source in self.eventStore.sources){
        localSource = source;
        break;
    }
    calendar.title = @"Visitando mi Pais";
    calendar.source = localSource;
    NSError *error;
    [self.eventStore saveCalendar:calendar commit:YES error:&error];
    if(error != nil){
        NSLog(@"Error creating calendar: %@",error.localizedDescription);
    }else{
        NSLog(@"Calendar created with identifier: %@", calendar.calendarIdentifier);
    }
    return calendar;
}

@end
