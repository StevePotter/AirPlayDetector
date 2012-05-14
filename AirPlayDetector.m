//
//  AirPlayDetector.m
//
//  Created by Steve Potter on 5/11/12.
//

#import "AirPlayDetector.h"
#import <Foundation/Foundation.h>
#import <MediaPlayer/MPMoviePlayerController.h>
#import <MediaPlayer/MediaPlayer.h>

NSString *AirPlayAvailabilityChanged = @"AirPlayAvailabilityChanged";

@implementation AirPlayDetector

+ (AirPlayDetector *)defaultDetector
{
	static AirPlayDetector *defaultDetector;
	
	@synchronized(self)
	{
		if (!defaultDetector)
			defaultDetector = [[AirPlayDetector alloc] init];
		return defaultDetector;
	}
}

- (BOOL)isAirPlayAvailable
{
    return isAirPlayAvailable;
}

- (void)startMonitoring:(UIWindow*)window;
{
    //here is the real trick.  place an MPVolumeView in the window and monitor for changes in the airplay button's alpha property.  note that this depends on the MPVolumeView's view hierarchy so it must be tested for each iOS release
    //this was made possible by the awesome sample from http://stackoverflow.com/questions/5388884/airplay-button-on-custom-view-problems
    
    volumeButton = [[MPVolumeView alloc] initWithFrame:CGRectMake(-1000,-1000,100,100)];
    volumeButton.showsVolumeSlider = NO;
    volumeButton.showsRouteButton = YES;
    [window addSubview:volumeButton];//if you don't add to a window, nothing will ever happen
    for (UIView *view in volumeButton.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            airplayButton = [view retain];
            isAirPlayAvailable = view.alpha == 1;//it was always 1 in testing but why not, right?
            [airplayButton addObserver:self forKeyPath:@"alpha" options:NSKeyValueObservingOptionNew context:nil];
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (![object isKindOfClass:[UIButton class]])
        return;
    BOOL isNowAvailable = [[change valueForKey:NSKeyValueChangeNewKey] floatValue] == 1;
    if ( isNowAvailable != isAirPlayAvailable )
    {
        isAirPlayAvailable = isNowAvailable;
        [[NSNotificationCenter defaultCenter] postNotificationName:AirPlayAvailabilityChanged object:self];
    }
}

- (void)dealloc
{
    [airplayButton removeObserver:self forKeyPath:@"alpha"];
    [airplayButton release];
    [volumeButton release];
    [super dealloc];
}

@end
