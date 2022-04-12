# iOS technical test - Leboncoin

## Overview

This app displays a list of ads sorted by urgency and creation date.  
User has the possibility to see the details of a selected ad. It is also possible to filter ads by category.

<img width="923" alt="appPreview" src="https://user-images.githubusercontent.com/45374748/162921859-3549b364-7ddd-47b3-a68f-a0078f785ff0.png">

This app is built with Swift language and views are created programmatically (UIKit)  
Target iOS 14+

## Architecture 

**Presentation**: MVVM-C pattern  
**Domain**: handles business rules  
**Data**: handles data  

## Installation 

Clone the repo:
```
$ git clone https://github.com/janinjan/LeboncoinTest.git
````

## Code Style guide
#### SwiftLint
This project uses [SwiftLint]( https://github.com/realm/SwiftLint) to ensure a unified code style.
SwiftLint can be easily installed using [Homebrew](https://brew.sh)

```
$ brew install swiftlint
```
SwiftLint configuration variables are defined in `.swiftlint.yml` file at the root of the repository

