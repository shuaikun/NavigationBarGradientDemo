//
//  AppDelegate.h
//  NavigationBarGradientDemo
//
//  Created by caoshuaikun on 2017/3/3.
//  Copyright © 2017年 useeinfo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

