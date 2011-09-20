//
//  OTTorchView.m
//  Open Torch
//
//  Created by Abhi Beckert on 21/09/11.
//  Copyright 2011 Precedence. All rights reserved.
//

#import "OTTorchView.h"

@implementation OTTorchView

- (void)awakeFromNib
{
  screenTorchOn = NO;
}

- (void)setScreenTorchOn:(BOOL)newScreenTorchOn
{
  if (screenTorchOn == newScreenTorchOn)
    return;
  
  screenTorchOn = newScreenTorchOn;
  
  UIImage *image = [UIImage imageNamed:@"Default@2x.png"];
  self.backgroundColor = [UIColor blackColor];
  
  if (screenTorchOn) {
    UIGraphicsBeginImageContext(image.size);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeCopy);
    
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeDifference);
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(),[UIColor whiteColor].CGColor);
    CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, image.size.width, image.size.height));
    image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();  
    
    self.backgroundColor = [UIColor whiteColor];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
      self.image = nil;
    });
  }
  
  self.image = image;
}

- (BOOL)screenTorchOn
{
  return screenTorchOn;
}

@end
