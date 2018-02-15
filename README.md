# OneMobileSDK-controls-ios
Public iOS implementation of the OneMobileSDK default custom controls interface... demonstrating how customers can implement their own custom video player controls.

# Required tools
Before build the project install next tools.

1. [Homebrew](https://brew.sh/index_ru.html)
2. [Sourcery](https://github.com/krzysztofzablocki/Sourcery): ```brew install sourcery```

# Snapshot Tests

## Setup
Install required frameworks using command in terminal:

`carthage update --platform iOS`

Install fastlane:

`bundle install`

## Launch Commands
To launch snapshot tests on multiple devices:

`bundle exec fastlane verify`

To record new reference images:

`bundle exec fastlane record`

To run all Unit tests and Snapshot tests:

`bundle exec fastlane test`
