import UIKit

class DiscoverRacesViewController: UIViewController {

  @IBOutlet private weak var nextWeekendButton: UIButton!
  @IBOutlet private weak var nextMonthButton: UIButton!
  @IBOutlet private weak var otherDatesButton: UIButton!
  @IBOutlet private weak var thisWeekendButton: UIButton!
  @IBOutlet private weak var racesTable: UITableView!
  
  var races: [Race] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    racesTable.separatorStyle = UITableViewCellSeparatorStyle.None
    racesTable.rowHeight = UITableViewAutomaticDimension
    racesTable.estimatedRowHeight = 60.00
    
    createRaces()
  }
  
  func createRaces() {
    for _ in 1...25 {
      let race = Race.init(name: "2015 Run thru the woods", date: "November 25, 2015", location: "The Woodlands Market Street", type: "Running - 5 miles - 5K - 1K")
      races.append(race)
    }
  }
  
  private func unselectAllDateButtons() {
    nextWeekendButton.selected = false
    nextMonthButton.selected = false
    otherDatesButton.selected = false
    thisWeekendButton.selected = false
  }
  
  @IBAction func didTapThisWeekendButton(sender: AnyObject) {
    let button = sender as! UIButton
    unselectAllDateButtons()
    button.selected = true
  }
  
  @IBAction func didTapNextWeekendButton(sender: AnyObject) {
    let button = sender as! UIButton
    unselectAllDateButtons()
    button.selected = true
  }

  @IBAction func didTapNextMonthButton(sender: AnyObject) {
    let button = sender as! UIButton
    unselectAllDateButtons()
    button.selected = true
  }
  
  @IBAction func didTapOtherDatesButton(sender: AnyObject) {
    let button = sender as! UIButton
    unselectAllDateButtons()
    button.selected = true
  }
    
  // MARK: - tableview delegate methods
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("raceCell", forIndexPath: indexPath) as! RaceTableViewCell
    
    let race = races[indexPath.row]
    
    cell.nameLabel.text = race.name
    cell.dateLocationLabel.text = "\(race.date) @ \(race.location)"
    cell.typeLabel.text = race.type
    
    return cell
  }
  
//  func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
//    forRowAtIndexPath indexPath: NSIndexPath) {
//      
//  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return races.count
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

  // MARK: - searchBar delegate
  
  func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
    searchBar.showsCancelButton = true
  }
  
  func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    searchBar.text = ""
    searchBar.endEditing(true)
    searchBar.showsCancelButton = false
  }
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    //TODO search for stuff here
  }

}
