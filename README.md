# Pre-work -  Quick Tip

Quick Tip is a tip calculator application for iOS.

Submitted by: John Cheshire

Time spent: 8 hours spent in total

## User Stories

The following **required** functionality is complete:

* [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [x] User can select between tip percentages by tapping different values on the segmented control and the tip value is updated accordingly (updated to use slider instead of tapped values)

The following **optional** features are implemented:

* [x] UI animations
* [x] Remembering the bill amount across app restarts (if <10mins)
* [x] Using locale-specific currency and currency thousands separators.
* [x] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [x] Default tip settings that persist when the app is closed and update the current tip percentage after changing the default
- [x] Slider allowing tip to be selected between 5% and 35%
- [x] Allowing users to select default currency, dollars, yen, pounds, or euro while keeping location specific thousands separators and decimals.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

![](https://i.imgur.com/nHKztNl.gif)




GIF created with EZGif (http://ezgif.com/video-to-gif).

## Notes

There were many new areas of Swift to investigate in building this app. A few key challenges were understanding how dates work in Swift, setting up an animation, and understanding how to add a custom string conversion method to use default currencies. Additionally, I am fairly new at working with Swift, so overall understanding of how to put things together took time as well.

## License

    Copyright 2021 John Cheshire

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
