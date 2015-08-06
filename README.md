AirPlayDetector - NO LONGER IN DEVELOPMENT
===============

HEY EVERYONE - I haven't touched this code in a long time because I'm out of the iOS development world.  I got bit by the hardware bug and spend my days in linux now.  I don't even own a mac so I couldn't work on this if I wanted.  Anyone who wants to take over, please email me at me@stevepotter.me

Does the job of detecting whether this device can connect to an Apple TV or whatever using AirPlay.  It uses a hack with MPVolumeButton to overcome the fact that the framework has no properties or events for this information, which seems pretty silly to me.  
 
This is for iOS only.  OSX version would be welcomed!
 
To use it, simply put the following code in your app, typically in appdelegate during applicationDidFinishLaunchingWithOptions:
[[AirPlayDetector defaultDetector] startMonitoring:window];
 
A notification will be posted when availability changes: AirPlayAvailabilityChanged
 
Or you can query availability by: [AirPlayDetector defaultDetector].isAirPlayAvailable
