# MKDSlideViewController#
*2013 Edition*

## About ##

*MKDSlideViewController* is a shameless copy of the sliding view controller user interface found in popular apps like **[Facebook]** or **[Path]**.

The Slide View Controller was developed for the iOS 6.1 SDK, but should work with iOS 5.0.

*All files in this project can be freely used and modified under the [MIT] license*

## Migration from the legacy version ##
The *2013 Edition* of *MKDSlideViewController* is not fully compatible with the previous version. The old version has been moved to the **"legacy"** branch of this repository.

The slide view controller is now accessible from its child view controllers through a *UIViewController+MKDSlideViewController* category. 

You are now responsible for the appearance of the main view controller. It won't be wrapped in a UINavigationController instance and has no default menu button.

This example code has been updated for UIStoryboards and the replacement of the main view controller is now hassle-free *(I hope!)* and also animated.

## Usage ##

See the *ExampleProject* folder for a basic usage example. You can add this repository as a submodule to your project and add the following files to your Xcode project:

- MKDSlideViewController.h
- MKDSlideViewController.m
- UIViewController+MKDSlideViewController.h
- UIViewController+MKDSlideViewController.m

**Be aware:** *MKDSlideViewController* doesn't play nice with a MainStoryboard in your project yet. It must be setup in your App Delegate. You can always instantiate a Storyboard after that.

## ARC ##

This project doesn't use ARC. If your project is ARC-enabled, add `-fno-objc-arc` to all *MKDSlideViewController* source files in your project target's build phases.

## Screenshots ##

![Screenshot 1](https://raw.github.com/newmarcel/MKDSlideViewController/master/ExampleProject/Resources/Screenshot-1.png)

![Screenshot 2](https://raw.github.com/newmarcel/MKDSlideViewController/master/ExampleProject/Resources/Screenshot-2.png)

![Screenshot 3](https://raw.github.com/newmarcel/MKDSlideViewController/master/ExampleProject/Resources/Screenshot-3.png)



[Facebook]: https://www.facebook.com/iphone
[Path]: http://www.path.com/
[MIT]: http://www.opensource.org/licenses/mit-license.php
