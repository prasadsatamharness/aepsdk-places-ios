# Migration from ACPPlaces to AEPPlaces

This document is a reference comparison of ACPPlaces (2.x) APIs against their equivalent APIs in AEPPlaces (4.x).

If explanation beyond showing API differences is necessary, it will be captured as a "Note" within that API's section.  

For example:

> **Note**: This is information that is important to help clarify the API.

## Primary class

The class name containing public APIs is different depending on which SDK and language combination being used.

| SDK Version | Language | Class Name | Example |
| ----------- | -------- | ---------- | ------- |
| ACPPlaces | Objective-C | `ACPPlaces` | `[ACPPlaces clear];`|
| AEPPlaces | Objective-C | `AEPMobilePlaces` | `[AEPMobilePlaces clear];` |
| AEPPlaces | Swift | `Places` | `Places.clear()` |

## Additional public classes and enums

| ACPPlaces (Objective-C) | AEPPlaces (Objective-C) | AEPPlaces (Swift) |
| ----------------------- | ----------------------- | ----------------- |
| `ACPPlacesRequestError` | `AEPPlacesQueryResponseCode` | `PlacesQueryResponseCode` |
| `ACPPlacesPoi` | `AEPPlacesPoi` | `PointOfInterest` |
| `ACPRegionEventType` | `AEPPlacesRegionEvent` | `PlacesRegionEvent` |

## Public APIs (alphabetical)
- [clear](#clear)
- [extensionVersion](#extensionVersion)
- [getCurrentPointsOfInterest](#getCurrentPointsOfInterest)
- [getLastKnownLocation](#getLastKnownLocation)
- [getNearbyPointsOfInterest](#getNearbyPointsOfInterest)
- [processRegionEvent](#processRegionEvent)
- [registerExtension](#registerExtension)
- [setAuthorizationStatus](#setAuthorizationStatus)

---

### clear

**ACPPlaces (Objective-C)**
```objc
+ (void) clear;
```

**AEPPlaces (Objective-C)**
```objc
+ (void) clear;
```

**AEPPlaces (Swift)**
```swift
static func clear()
```

---

### extensionVersion

**ACPPlaces (Objective-C)**
```objc
+ (nonnull NSString*) extensionVersion;
```

**AEPPlaces (Objective-C)**
```objc
+ (nonnull NSString*) extensionVersion;
```

**AEPPlaces (Swift)**
```swift
static var extensionVersion: String
```

---

### getCurrentPointsOfInterest

**ACPPlaces (Objective-C)**
```objc
+ (void) getCurrentPointsOfInterest: (nullable void (^) (NSArray<ACPPlacesPoi*>* _Nullable userWithinPoi)) callback;
```

**AEPPlaces (Objective-C)**
```objc
+ (void) getCurrentPointsOfInterest: ^(NSArray<AEPPlacesPoi*>* _Nonnull pois) closure;
```

**AEPPlaces (Swift)**
```swift
static func getCurrentPointsOfInterest(_ closure: @escaping ([PointOfInterest]) -> Void)
```

---

### getLastKnownLocation

**ACPPlaces (Objective-C)**

> **Note**: If the SDK has no last known location, it will pass a `CLLocation` object with a value of `999.999` for latitude and longitude to the callback.

```objc
+ (void) getLastKnownLocation: (nullable void (^) (CLLocation* _Nullable lastLocation)) callback;
```

**AEPPlaces (Objective-C)**
```objc
+ (void) getLastKnownLocation: ^(CLLocation* _Nullable lastLocation) closure;
```

**AEPPlaces (Swift)**

> **Note**: If the SDK has no last known location, it will pass `nil` to the closure.

```swift
static func getLastKnownLocation(_ closure: @escaping (CLLocation?) -> Void)
```

---

### getNearbyPointsOfInterest


**ACPPlaces (Objective-C)**

> **Note**: Two `getNearbyPointsOfInterest` methods exist. The overloaded version allows the caller to provide an `errorCallback` parameter in the case of failure.

```objc
// without error handling
+ (void) getNearbyPointsOfInterest: (nonnull CLLocation*) currentLocation
                             limit: (NSUInteger) limit
                          callback: (nullable void (^) (NSArray<ACPPlacesPoi*>* _Nullable nearbyPoi)) callback;

// with error handling
+ (void) getNearbyPointsOfInterest: (nonnull CLLocation*) currentLocation
                             limit: (NSUInteger) limit
                          callback: (nullable void (^) (NSArray<ACPPlacesPoi*>* _Nullable nearbyPoi)) callback
                     errorCallback: (nullable void (^) (ACPPlacesRequestError result)) errorCallback;
```

**AEPPlaces (Objective-C)**
```objc
+ (void) getNearbyPointsOfInterest: (nonnull CLLocation*) currentLocation
                             limit: (NSUInteger) limit
                          callback: ^ (NSArray<AEPPlacesPoi*>* _Nonnull, AEPPlacesQueryResponseCode) closure;
```

**AEPPlaces (Swift)**

> **Note**: Rather than providing an overloaded method, a single method supports retrieval of nearby Points of Interest. The provided closure accepts two parameters, representing the resulting nearby Points of Interest (if any) and the response code.

```swift
static func getNearbyPointsOfInterest(forLocation location: CLLocation,
                                      withLimit limit: UInt,
                                      closure: @escaping ([PointOfInterest], PlacesQueryResponseCode) -> Void)
```

---

### processRegionEvent

**ACPPlaces (Objective-C)**

> **Note**: The order of parameters has the `CLRegion` that triggered the event first, and the `ACPRegionEventType` second.

```objc
+ (void) processRegionEvent: (nonnull CLRegion*) region
         forRegionEventType: (ACPRegionEventType) eventType;
```

**AEPPlaces (Objective-C)**
```objc
+ (void) processRegionEvent: (AEPRegionEventType) eventType
                  forRegion: (nonnull CLRegion*) region;
```

**AEPPlaces (Swift)**

> **Note**: The order of parameters has the `PlacesRegionEvent` first, and the `CLRegion` that triggered the event second. This aligns better with Swift API naming conventions.

```swift
static func processRegionEvent(_ regionEvent: PlacesRegionEvent,
                               forRegion region: CLRegion)
```

---

### registerExtension

**ACPPlaces (Objective-C)**
```objc
+ (void) registerExtension;
```

**AEPPlaces (Objective-C)**

> **Note**: Registration occurs by passing `AEPMobilePlaces` to the `[AEPMobileCore registerExtensions:completion:]` API.

```objc
[AEPMobileCore registerExtensions:@[AEPMobilePlaces.class] completion:nil];
```

**AEPPlaces (Swift)**

> **Note**: Registration occurs by passing `Places` to the `MobileCore.registerExtensions` API.

```swift
MobileCore.registerExtensions([Places.self])
```

---

### setAuthorizationStatus

**ACPPlaces (Objective-C)**
```objc
+ (void) setAuthorizationStatus: (CLAuthorizationStatus) status;
```

**AEPPlaces (Objective-C)**
```objc
+ (void) setAuthorizationStatus: (CLAuthorizationStatus) status;
```

**AEPPlaces (Swift)**
```swift
static func setAuthorizationStatus(_ status: CLAuthorizationStatus)
```

---
