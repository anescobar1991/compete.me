import Foundation
import CoreLocation

//will catch signal from activeAPImanager and will update models with it
//catches any signals from model and updates view with it
class DiscoverRacesViewModel {
  var races: [RaceCellViewModel]!
  var currentLocation: CLLocationCoordinate2D!
  
  func getCurrentLocation() -> CLLocation{
    
  }
  func getRaces(pageNumber: Int) {
    let races = ActiveAPIDataProvider().getRaces()

    for race in races {
      let raceViewModel = RaceCellViewModel.init(name: race.name, date: race.date, location: race.location, type: race.type)
      
      self.races.append(raceViewModel)
    }
  }
  
}