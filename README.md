# Swiss Ephemeris

This repository contains the [Swiss Ephemeris](https://www.astro.com/swisseph/swephinfo_e.htm#proflic), packaged with a wrapper written in Swift. All Swiss Ephemeris C code has not been modified, is accessible and can be called directly after importing the package. If you program in C, or are familiar with the original library it is possible to ignore the Swift code.

I am working on a Swift wrapper for convenience and accessibility for developers who are not familiar with C, but would like to leverage the power of this ephemeris. This is still a work in progress, and the current state of the wrapper only utilizes a small percentage of what the ephemeris offers.

The package is available through [Swift Package Manager](https://swift.org/package-manager/)

### Licensing

This project is under the licensing model `a) GNU public license version 2 or later` outlined in the section on `How to license the Swiss Ephemeris`  on the description of the [Astrodienst](http://www.astro.com/) [Swiss Ephemeris](https://www.astro.com/swisseph/swephinfo_e.htm). Please familiarize yourself with the licensing requirements before getting started.

### [Jet Propulsion Laboratory Development Ephemeris](https://en.wikipedia.org/wiki/Jet_Propulsion_Laboratory_Development_Ephemeris) Files

At the moment the JPL-Ephemeris files that are included are the following. 

| File          | Time Period    | Type    |
| ------------- |:--------------:| -----:  |
| semo_18.se1   | 1800 - 2399 AD | Moon    |
| sepl_18.se1   | 1800 - 2399 AD | Planet  |

To extend the time period or the types of celestial bodies covered, the `.se1` files are contained in a `Sources/CSwissEphemeris/include`.

### Wrapper 

I have been extending existing C files to write new methods that call existing C code, without modifying what is part of the original source code. These new methods interface with the SwissEphemeris source files. I intend to keep the bridging methods separate, and this division is marked by:

`//MARK: - Extending for Swift Wrapper`

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

The `enum` types for `Planet`,  and `LunarNode` correspond to IPL numbers in the ephemeris. Other celestial bodies such as astroids and stars still need to be added. The type numbering is not comprehensive, but can be easily extended to match the celestial body that is not available in the package. All of the types conform to the `CelestialBody` protocol which makes it so different categories of celestial points can be mapped to the tropical zodiac both in aspect and position. 

### Testing 

#### Accuracy

In order to test the accuracy of this package please use the [Test Page](https://www.astro.com/swisseph/swetest.htm) as suggested in the original Swiss Ephemeris documentation. I also found the Astrodienst [page](https://www.astro.com/h/pl_e.htm) for current planets to be helpful. 


