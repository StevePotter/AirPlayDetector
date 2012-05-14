AirPlayDetector
===============


Does the job of detecting whether this device can connect to an Apple TV or whatever using AirPlay.  It uses a hack with MPVolumeButton to overcome the fact that the framework has no properties or events for this information, which seems pretty silly to me.  
 
To use it, simply put the following code in your app, typically in appdelegate during applicationDidFinishLaunchingWithOptions:
[[AirPlayDetector defaultDetector] startMonitoring:window];
 
A notification will be posted when availability changes: AirPlayAvailabilityChanged
 
Or you can query availability by: [AirPlayDetector defaultDetector].isAirPlayAvailable