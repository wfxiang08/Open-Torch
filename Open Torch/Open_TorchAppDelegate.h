//
//  Open_TorchAppDelegate.h
//  Open Torch
//
//  Created by Abhi Beckert on 2011-04-26.
//  Copyright 2011 Precedence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Open_TorchViewController;

@interface Open_TorchAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet Open_TorchViewController *viewController;

@end
