# Swiss Ephemeris

This repository contains the [Swiss Ephemeris](https://www.astro.com/swisseph/swephinfo_e.htm#proflic), packaged with a wrapper written in Swift. All Swiss Ephemeris C code has not been modified, is accessible and can be called directly after importing the package. If you program in C, or are familiar with the original library it is possible to ignore the Swift code.

I am working on a Swift wrapper for convenience and accessibility for developers who are not familiar with C, but would like to leverage the power of this ephemeris. This is still a work in progress, and the current state of the wrapper only utilizes a small percentage of what the ephemeris offers.

The package is available through [Swift Package Manager](https://swift.org/package-manager/)

### Licensing

This project is under the licensing model `a) GNU public license version 2 or later` outlined in the section on `How to license the Swiss Ephemeris`  on the description of the [Astrodienst](http://www.astro.com/) [Swiss Ephemeris](https://www.astro.com/swisseph/swephinfo_e.htm). Please familiarize yourself with the licensing requirements before getting started.

### [Jet Propulsion Laboratory Development Ephemeris](https://en.wikipedia.org/wiki/Jet_Propulsion_Laboratory_Development_Ephemeris) Files

At the moment the JPL-Ephemeris files that are included are the following. 

| Type        	 | File Numbering               | Time Period  					         |
|---------------|----------------------------|------------------------------------------------|
| Planet  		 | seplm60 - seplm132      | 11 Aug 13000 BCE – Jan 16800 CE      |
|                       | seplm06 - seplm54         |                                                                 |	
|                       | sepl0 - sepl162               |                                                                       |	
| Asteroid         | seasm06 - seasm54       |  5401 BCE - 4800 CE – 5399 CE     	        |
| 		         | seas_06 - seas_48         |    									|
| Moon             | semom60 - semom132 |  11 Aug 13000 BCE – Jan 16800 CE             |
|                       | semom06 - semom54    |                                                                        |
|                       | semo_00 - semo_162     |                                                                       |

### Setting the Ephemeris Files

It is crucial that the path to the JPL-Ephemeris files is set at runtime before getting any astrological data.  Various documentation and examples that exist out there have this step as optional, but the functionality of  this library will be greatly limited if not taken. Since Swift tools version 5.3 it is possible to [bundle resources as a part of a Swift package](https://developer.apple.com/documentation/swift_packages/bundling_resources_with_a_swift_package). This allows adding the JPL file as a resource to the package, and setting the resource path as the path to the ephemeris files. 

This method should be called once at the entry point of your app. By default, the `Bundle.module` resource path of this package that holds the JPL files is set as the ephemeris path. However, It is also possible to pass in `path` parameter to set a different ephemeris files that you have bundled in your app.

```swift
// Sets ephemeris path to the JPL resources.
JPLFileManager.setEphemerisPath()
// Set a path to JPL files added to your app bundle.
let path = "URL to your ephemeris files"
JPLFileManager.setEphemerisPath(path: )
```

### Usage

#### Astronomical and Astrological Coordinates

To get coordinate data for a planet, moon or lunar node create a `Coordinate` where `T` is the type of IPL body category. This type contains more than astrological data, including the latitudinal and longitudinal speed, and distance in AU for any planetary body.

```swift
let now = Date()
// Astronomical and astrological information for the moon at this point in time.
let moonCoordinate = Coordinate<Planet>(planet: .moon, date: now)
// The moon's longitude.
moonCoordinate.longitude
// The moon's latitude.
moonCoordinate.latitude
// The distance in AU from the earth.
moonCoordinate.distance
// The speed in longitude (deg/day).
moonCoordinate.speedLongitude
// The speed in latitude (deg/day).
moonCoordinate.speedLatitude
// The speed in distance (AU/day).
moonCoordinate.speedDistance
```
Astrological information about the tropical zodiacal location of a celestial body is also available from the same `Coordinate` type.

```swift
// Date for 12.14.2019 13:39 UT/GMT
let date = Date(timeIntervalSince1970: 598023482.487818)
// Astronomical and astrological information for the sun on December 14th 2019.
let sunCoordinate = Coordinate<Planet>(planet: .sun, date: date)
// This will return 21 Degrees Sagittarius ♐︎ 46' 49''.
sunCoordinate.formatted
// It is also possible to get the degree, minute and second as properties of the Coordinate.
let degree = sunCoordinate.degree
let minute = sunCoordinate.minute
let second = sunCoordinate.second
```
#### Astrological Aspect

To create an aspect between two `CelestialBody`  types use  `Aspect`.  `Transit` contains start and end date properties of the transit with an accuracy of one hour.

```swift
// Create a pair of celestial bodies.
let moonTrueNode = Pair<Planet, LunarNode>(a: .moon, b: .trueNode)
// Transit contains start and end date properties.
let transit = Transit(pair: moonTrueNode, date: Date(), orb: 8.0)
```
####  Astrological Houses

To get the house layout for a date, location, and house system create a `HouseCusps`. The `HouseSystem` determines the type of astrological house system that is set. All house `Cusp` properties can be used to create an `Aspect` with a `CelestialBody`.

```swift
/// Create a date and location
let now = Date()
let latitude: Double = 37.5081153
let longitude: Double = -122.2854528
/// All house cusps, Ascendent, and MC are properties on `houses`.
let houses = HouseCusps(date: date, latitude: latitude, longitude: longitude, houseSystem: .placidus)
/// Get the formatted astrological position.
let ascendentFormatted = houses.ascendent.formatted
/// Or the precise degree
let degree = houses.ascendent.degree
```

#### IPL Numbering

The `enum` types for `Planet`, `Asteroid`, and `LunarNode` correspond to IPL numbers in the ephemeris. Other celestial bodies such as stars as fictitious points still need to be added. The type numbering is not comprehensive, but can be easily extended to match the celestial body that is not available in the package. All of the types conform to the `CelestialBody` protocol which makes it so different categories of celestial points can be mapped to the tropical zodiac both in aspect and position. 

#### Batch Calculations

To get the most out of the ephemeris, you may need to make a lot of calculations at one time. Making calculations in mass is an expensive operation. and should never be done on the main thread. If you are making hundreds of calculations at one time it is recommended to use a `BatchRequest` for increased performance and to avoid the undefined behavior that results from making numerous calculations concurrently on a single thread.

For example, if I wanted to calculate the exact dates for the phases of the moon I could create a map of the hourly percentage by requesting a `Lunation` for every hour over the next 30 days.

```swift
let lunationsRequest = LunationsRequest()
let now = Date()
let end = Date(),.addingTimeInterval(60 * 60 * 24 * 30)
lunationsRequest.fetch(start: now, end: end, interval: 60.0 * 60.0) { lunations in
    /// An array of `Lunation` for every hour between now and 720 hours in the future
    /// mapped to percentage values.
    let percentages = lunations.map { $0.percentage }
}
```

### Testing 

#### Accuracy

In order to test the accuracy of this package please use the [Test Page](https://www.astro.com/swisseph/swetest.htm) as suggested in the original Swiss Ephemeris documentation. I also found the Astrodienst [page](https://www.astro.com/h/pl_e.htm) for current planets to be helpful. 


