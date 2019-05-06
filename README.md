# Smartphone Research Platform

## Overview

This GitHub repository provides the guidelines for running C/MATLAB algorithms on Android and iOS smartphone platforms. The example app provided here is for hearing improvement studies. Note that these guidelines are applicable to any real-time signal processing app.

The repository addresses the following:
* Software tools required to implement signal processing algorithms on smartphones
* How to run C codes on Android or iOS devices
* Converting MATLAB functions into C codes using the MATLAB Coder
* Hardware dependencies one needs to be aware of while implementing signal processing algorithms
* Designing a real-time audio filtering app for both Android and iOS

## Users Guides

[Android](UsersGuide-SmartphoneResearchPlatform-Android.pdf)<br>
[iOS](UsersGuide-SmartphoneResearchPlatform-iOS.pdf)

## Prerequisites

- For iOS implementation, a Mac laptop or desktop machine is needed as well as an Apple developer account
- For Android implementation, [Superpowered SDK](https://superpowered.com) is used to set up the audio I/O, which can be found at: [LINK](https://github.com/superpoweredSDK/Low-Latency-Android-iOS-Linux-Windows-tvOS-macOS-Interactive-Audio-Platform)
- Conversion of MATLAB script to C is done by the MATLAB Coder utility of MATLAB 

## License and Citation
The codes are licensed under MIT license.

For any utilization of the code content of this repository, one of the following books needs to get cited by the user:

- N. Kehtarnavaz, F. Saki, and A. Duran, [Anywhere-Anytime Signals and Systems Laboratory: From MATLAB
to Smartphones - 2nd Edition](https://ieeexplore.ieee.org/document/8527721), Morgan and Claypool Publishers, 2018.
- N. Kehtarnavaz, A. Sehgal, and S. Parris, [Smartphone-Based Real-Time Digital Signal Processing - 2nd Edition](https://www.morganclaypool.com/doi/abs/10.2200/S00885ED2V01Y201811SPR016),
Morgan and Claypool Publishers, 2018.
