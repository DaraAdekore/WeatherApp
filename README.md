# Weather App
This is a simple weather app that uses the OpenWeatherMap API to display the current weather data for a user's current location. The app is built using Swift 5 and Xcode 12 and follows iOS design guidelines for a clean and easy-to-use interface.

![AcidicCooperativeHairstreak-size_restricted](https://user-images.githubusercontent.com/18224357/221120141-f5b765a1-4495-48ef-b193-06b35681333b.gif)

# Features
The app has the following features:

* Splash screen with app logo
* Login screen: Users can create an account or login with an existing account
* Dashboard screen: Displays the current weather data for the user's current location, including temperature, humidity, wind speed, and description of the weather
* Search screen: Users can search for the current weather data for any location by entering the city name or ZIP code. The search results are displayed in a list.
* Detail screen: Users can tap on any search result to see the detailed weather data for that location.
* Notifications: The app sends a local notification to the user every morning at 8:00 AM, reminding them to check the weather.
# Additional features:

* The app uses CoreLocation to determine the user's current location.
* The app uses Alamofire to consume the OpenWeatherMap API.
* The app uses UserNotifications to implement local notifications.
# Requirements
## To run the app, you will need:

* Xcode 12 or later
* An API key from OpenWeatherMap. The API key is hard-coded into the code and should be replaced with your own API key before running the app. 
This is not best practice but for the sake of the assessment and ease of installation it has been included.
# Installation
* Clone the repository
* Open the WeatherApp.xcodeproj file in Xcode
* Replace the API key in the WeatherService.swift file with your own API key
* Build and run the app in Xcode
Additional Notes
* The app was tested on an iPhone running iOS 14.4.
* The app may not function properly if the user has disabled location services or notifications for the app.
* The app was built as a demonstration of iOS app development skills and is not intended for commercial use.
