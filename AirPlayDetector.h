//
//  AirPlayDetector.h
//
//  Created by Steve Potter on 5/11/12.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MPMoviePlayerController.h>
#import <MediaPlayer/MediaPlayer.h>

/*
 * Notification made when [AirPlayDetector isAirPlayAvailable] changes
 */
extern NSString *AirPlayAvailabilityChanged;

/*
 * Does the job of detecting whether this device can connect to an Apple TV or whatever using AirPlay.  It uses a hack with MPVolumeButton to overcome the fact that the framework has no properties or events for this information, which seems pretty silly to me.  
 
 To use it, simply put the following code in your app, typically in appdelegate during applicationDidFinishLaunchingWithOptions:
 [[AirPlayDetector defaultDetector] startMonitoring:window];
 
 A notification will be posted when availability changes: AirPlayAvailabilityChanged
 
 Or you can query availability by: [AirPlayDetector defaultDetector].isAirPlayAvailable
 
 */
@interface AirPlayDetector : NSObject 
{
@private
    MPVolumeView *volumeButton;
    UIView *airplayButton;
    BOOL isAirPlayAvailable;
}

/*
 * When true, there are available airplay devices to play to.
 */
@property (readonly, nonatomic) BOOL isAirPlayAvailable;

/*
 * A convenient static instance of the detector, since apps will almost always use a single shared instance.
 */
+ (AirPlayDetector*)defaultDetector;

/*
 * Begins the process of monitoring for changes in airplay availability.
 */
- (void)startMonitoring:(UIWindow*)window;

@end
