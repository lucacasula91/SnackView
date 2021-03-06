fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios run_bootstrap
```
fastlane ios run_bootstrap
```


Ensure carthage is ready to go.

:configuration Optionally set the configuration.  Default is release.
### ios test_with_coverage
```
fastlane ios test_with_coverage
```


Run tests using scan and slather.


### ios screenshots
```
fastlane ios screenshots
```
Generate new localized screenshots
### ios create_release
```
fastlane ios create_release
```
Generate github release

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
