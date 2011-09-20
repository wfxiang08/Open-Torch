//
//  Open_TorchAppDelegate.m
//  Open Torch
//
//  Created in 2011 by Abhi Beckert <http://abhibeckert.com>
//  
//  This is free and unencumbered software released into the public domain.
//  
//  Anyone is free to copy, modify, publish, use, compile, sell, or
//  distribute this software, either in source code form or as a compiled
//  binary, for any purpose, commercial or non-commercial, and by any
//  means.
//  
//  In jurisdictions that recognize copyright laws, the author or authors
//  of this software dedicate any and all copyright interest in the
//  software to the public domain. We make this dedication for the benefit
//  of the public at large and to the detriment of our heirs and
//  successors. We intend this dedication to be an overt act of
//  relinquishment in perpetuity of all present and future rights to this
//  software under copyright law.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
//  OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
//  ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//  
//  For more information, please refer to <http://unlicense.org/>
//

#import "Open_TorchAppDelegate.h"

#import "Open_TorchViewController.h"

@implementation Open_TorchAppDelegate


@synthesize window=_window;

@synthesize viewController=_viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  // hide status bar
  [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
  
  // show window
  self.window.rootViewController = self.viewController;
  [self.window makeKeyAndVisible];
  return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  [self turnTorchOn];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  [self turnTorchOff];
}

- (void)turnTorchOn
{
  AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
  if (device && [device hasTorch] && [device hasFlash]) {
    [self turnTorchOnInFlashMode];
  } else {
    [self turnTorchOnInScreenMode];
  }
}

- (void)turnTorchOnInFlashMode
{
  AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
  
  if (!captureSession) {
    AVCaptureDeviceInput *flashInput = [AVCaptureDeviceInput deviceInputWithDevice:device error: nil];
    AVCaptureVideoDataOutput *output = [[[AVCaptureVideoDataOutput alloc] init] autorelease];
    
    captureSession = [[AVCaptureSession alloc] init];
    
    [captureSession beginConfiguration];
    [device lockForConfiguration:nil];
    
    [captureSession addInput:flashInput];
    [captureSession addOutput:output];
    [device setTorchMode:AVCaptureTorchModeOn];
    [device setFlashMode:AVCaptureFlashModeOn];
    
    [device unlockForConfiguration];
    
    [captureSession commitConfiguration];
  }
  
  [captureSession startRunning];
  
  [device lockForConfiguration:nil];
  [device setTorchMode:AVCaptureTorchModeOn];
  [device setFlashMode:AVCaptureFlashModeOn];
  [device unlockForConfiguration];
}

- (void)turnTorchOnInScreenMode
{
  self.viewController.screenTorchView.screenTorchOn = YES;
}

- (void)turnTorchOff
{
  if (!captureSession)
    return;
  
  [captureSession stopRunning];
  
  self.viewController.screenTorchView.screenTorchOn = NO;
}

- (void)dealloc
{
  [captureSession release];
  [_window release];
  [_viewController release];
  [super dealloc];
}

@end
