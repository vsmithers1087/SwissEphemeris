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

#### Usage

To get the tropical zodiac position as well as the precise degree of planet.

```swift
/// Create a date
let now = Date()
/// Create an instance of `PlanetCoordinate` with a planet
let moonCoordinate = PlanetCoordinate(planet: .moon, date: now)
/// Get the precise degree of the planet 
let degree = moonCoordinate.degree
/// Get the formatted position mapped to the tropical zodiac
let formatted = moonCoordinate.tropicalZodiacPosition.formatted
/// 13 Degrees Sagittarius ♐︎ 46' 49''"
```
To get the Placidus house layout for date and location.

```swift
/// Create a date and location
let now = Date()
let latitude: Double = 37.5081153
let longitude: Double = -122.2854528
/// Initialize with date, latitude and longitude
/// All house cusps, Ascendent, Descendent, MC, and IC are properties on `houses`
let houses =  PlacidusHouses(date: date, latitude: latitude, longitude: longitude)
/// Get the formatted position 
let ascendentFormatted = houses.ascendent.tropicalZodiacPosition.formatted
/// Or the precise degree
let degree = houses.ascendent.degree
```

### Testing 

#### Accuracy

In order to test the accuracy of this package please use the [Test Page](https://www.astro.com/swisseph/swetest.htm) as suggested in the original Swiss Ephemeris documentation. I also found the Astrodienst [page](https://www.astro.com/h/pl_e.htm) for current planets to be helpful. 


