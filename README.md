# Simple Shop - demo project

Created by Grzegorz Biegaj (23  - 29 April)

## Project description

Simple Shop is just an iOS demo app presenting clean code and application architecture.
The main feature of the app is to create basket of goods in a number of different currencies .

### How it works:
- App shows product list which can be purchased
- User can add ech product to the basket with any quantity (from 1 to 10)
- In the basket view user can change current currency (default is $) to any other taken from currency list
- Backet will be automaticaly recalculated to the choosen currency
- Checkout button is recalculating basket again, just to be sure, that currency rate is updated
- It's possible to remove products from the basket (by swipe), change their quantity, or remove all the products

NOTE:
- Currencies are taken online from: http://jsonrates.com/
- Each time, when we choose the currency rates can change 

## Architecture

### Modified MVC
Because of usage storyboards introduction of pure MVVM is not so easy, because view is integrated with ViewControllers. Instead of it View Controller is separated by ViewModel and Controller

### Storyboards
For that simple app storyboards are good solution. Storyboards are split to possible small scenes accordingly to the ViewControllers

### Unit tests
Most of the possible unit tests exists

### Dependency injection
Because of usage unit tests it was necessary to introduce dependecy injection to separate components.

### Dependencies
No any dependencies and dependeny manager

### Programming tools
Xcode 9.3, swift 4.1
