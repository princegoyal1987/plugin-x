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
#import <AdColony/AdColony.h>

#define OUTPUT_LOG(...)     if (self.debug) NSLog(__VA_ARGS__);

@implementation AdsiAd

@synthesize debug = __debug;


#pragma mark Interfaces for ProtocolAd  s impl

-(void) InitIadBanner
{
    return;
    NSLog(@"AdsiAd.m: InitIadBanner: beginning1");
   
    
    iadBanner_ = [[ADBannerView alloc] initWithFrame:CGRectZero];
    
    iadBanner_.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifierLandscape];
    
    iadBanner_.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
    
    iadBanner_.delegate = self;
    
    [iadBanner_ retain];
    
    
    appWantToShow = YES;
//    iadBanner_.hidden = TRUE;
    
    
    UIViewController* controller = [AdsWrapper getCurrentRootViewController];
    controller.canDisplayBannerAds = NO;
    [controller.view addSubview:iadBanner_];
    
    NSLog(@"AdsiAd.m:  InitIadBanner: done..");
}

- (void)createAdBannerView
{
    
}

- (void) configDeveloperInfo: (NSMutableDictionary*) devInfo
{
    [self InitIadBanner];
    
    //Init Adcolony
    [AdColony configureWithAppID:@"appc7986bd62f9b4c4083"
                         zoneIDs:@[@"vz0d86ada204594ca1af"]
                        delegate:nil
                         logging:YES];
}

-(void) checkAndShowAd
{
//    iadBanner_.hidden = NO;!(appWantToShow && iadBanner_.bannerLoaded);
//    NSLog(@"AdsiAd.m:  checkAndShow: iadBanner.hidden=%@ bannerloaded=%@",iadBanner_.hidden?@"YES":@"NO",iadBanner_.bannerLoaded?@"YES":@"NO");
    
}
- (void) showAds: (NSMutableDictionary*) info position:(int) pos
{
    if(pos == 0) //0 = cocos2d::plugin::ProtocolAds::AdsPos::kPosCenter
        [AdColony playVideoAdForZone:@"vz0d86ada204594ca1af" withDelegate:nil];
    return;
    appWantToShow = YES;
    [self checkAndShowAd];
}

- (void) hideAds: (NSMutableDictionary*) info
{
    return;
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
    NSLog(@" AdsiAd.m : error => %@ ", [error userInfo] );
}

@end
