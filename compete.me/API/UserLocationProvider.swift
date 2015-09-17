import CoreLocation
import ReactiveCocoa

//protocol UserLocationProviderDelegate {
//  func aboutToGetLocation()
//  func didGetLocation(location: CLLocation)
//  func doesNotHaveLocationServicesAuthorization(status: CLAuthorizationStatus)
//  func locationServicesDidFailWithErrors(error: NSError)
//}
//

class UserLocationProvider: NSObject, CLLocationManagerDelegate {
  private let locationManager: CLLocationManager = CLLocationManager()
  
  override init() {
    super.init()
    locationManager.delegate = self
    locationManager.distanceFilter = 200 //distance in meters
    locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
  }
  
  func getCurrentLocation() {
    startUpdatingLocationIfAuthorized(CLLocationManager.authorizationStatus())
  }
  
  func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
    delegate.locationServicesDidFailWithErrors(error)
  }
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      locationManager.stopUpdatingLocation()
      let latestLocation = locations[locations.count - 1] 
      delegate.didGetLocation(latestLocation)
  }
  
  private func startUpdatingLocationIfAuthorized(status: CLAuthorizationStatus) {
    switch status {
    case .AuthorizedWhenInUse, .AuthorizedAlways:
      delegate.aboutToGetLocation()
      locationManager.startUpdatingLocation()
    case .NotDetermined:
      locationManager.requestWhenInUseAuthorization()
    case .Restricted, .Denied:
      delegate.doesNotHaveLocationServicesAuthorization(status)
    }
  }
  
}