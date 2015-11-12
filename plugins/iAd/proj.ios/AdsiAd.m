/****************************************************************************
Copyright (c) 2012-2013 cocos2d-x.org

http://www.cocos2d-x.org

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
****************************************************************************/
#import "AdsiAd.h"
#import "AdsWrapper.h"

#define OUTPUT_LOG(...)     if (self.debug) NSLog(__VA_ARGS__);

@implementation AdsiAd

@synthesize debug = __debug;


#pragma mark Interfaces for ProtocolAd  s impl

-(void) InitIadBanner
{
    iadBanner_ = [[ADBannerView alloc] initWithFrame:CGRectZero];
    iadBanner_.delegate = self;
    iadBanner_.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifierLandscape];
    iadBanner_.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        //iadBanner_.center = CGPointMake(480/2,320-32/2);
        iadBanner_.center = CGPointMake(480/2,32/2);
    else
        //iadBanner_.center = CGPointMake(1024/2,768-66/2);
        iadBanner_.center = CGPointMake(1024/2,66/2);
    appWantToShow = YES;
    iadBanner_.hidden = TRUE;
    
    UIViewController* controller = [AdsWrapper getCurrentRootViewController];
    [controller.view addSubview:iadBanner_];
}


- (void) configDeveloperInfo: (NSMutableDictionary*) devInfo
{
    [self InitIadBanner];
}

-(void) checkAndShowAd
{
    iadBanner_.hidden = !(appWantToShow && iadBanner_.bannerLoaded);
    
}
- (void) showAds: (NSMutableDictionary*) info position:(int) pos
{
    appWantToShow = YES;
    [self checkAndShowAd];
}

- (void) hideAds: (NSMutableDictionary*) info
{
    appWantToShow = NO;
    [self checkAndShowAd];
}

- (void) queryPoints
{
    
}

- (void) spendPoints: (int) points
{
    
}

- (void) setDebugMode: (BOOL) isDebugMode
{
}

- (NSString*) getSDKVersion
{
    return @"4.2.1";
}

- (NSString*) getPluginVersion
{
    return @"0.2.0";
}

#pragma mark Interfaces for iAd impl

-(void)bannerViewDidLoadAd:(ADBannerView *)b {
    [self checkAndShowAd];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    [self checkAndShowAd];
}

@end
