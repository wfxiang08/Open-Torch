//
//  OTTorchView.h
//  Open Torch
//
//  Created by Abhi Beckert on 21/09/11.
//  Copyright 2011 Precedence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OTTorchView : UIImageView
{
  BOOL screenTorchOn;
}

- (void)setScreenTorchOn:(BOOL)newScreenTorchOn;
- (BOOL)screenTorchOn;

@end
