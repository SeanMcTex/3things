fastlane documentation
================
# Installation
```
sudo gem install fastlane
```
# Available Actions
## iOS
### ios add_device
```
fastlane ios add_device
```
Add new device to provisioning profile
### ios refresh_profiles
```
fastlane ios refresh_profiles
```

### ios profiles
```
fastlane ios profiles
```
Grab provisioning profiles
### ios test
```
fastlane ios test
```
Runs all the tests
### ios beta
```
fastlane ios beta
```
Submit a new Beta Build to Apple TestFlight

This will also make sure the profile is up to date
### ios release
```
fastlane ios release
```
Deploy a new version to the App Store

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [https://fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [https://docs.fastlane.tools](https://docs.fastlane.tools).
