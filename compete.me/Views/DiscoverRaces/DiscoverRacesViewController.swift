import UIKit
import ReactiveCocoa

class DiscoverRacesViewController: UIViewController {

  @IBOutlet private weak var nextWeekendButton: UIButton!
  @IBOutlet private weak var nextMonthButton: UIButton!
  @IBOutlet private weak var otherDatesButton: UIButton!
  @IBOutlet private weak var thisWeekendButton: UIButton!
  @IBOutlet private weak var racesTable: UITableView!
  @IBOutlet weak var activeLogo: UIImageView!
  
  private let messageLabel = UILabel()
  private let refreshControl = UIRefreshControl()
  
  private var viewModel: DiscoverRacesViewModel = DiscoverRacesViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.getCurrentLocation()
    viewModel.getRaces(1)
    
    messageLabel.numberOfLines = 0;
    messageLabel.textColor = UIColor.darkGrayColor()
    messageLabel.textAlignment = NSTextAlignment.Center
    racesTable.backgroundView = messageLabel
    
    refreshControl.addTarget(self, action: "refreshData:", forControlEvents: UIControlEvents.ValueChanged)
    racesTable.addSubview(refreshControl)
    
    racesTable.separatorStyle = UITableViewCellSeparatorStyle.None
    racesTable.rowHeight = UITableViewAutomaticDimension
    racesTable.estimatedRowHeight = 160.00
    
    //TODO bind loading bar to something in viewmodel
    //TODO bind messageLabel to something in viewmodel
    //TODO bind logo to something in view model
  }
  
  func refreshData(sender: AnyObject) {
    //TODO ask viewmodel to refresh data here using whatever is in core data for settings and search
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
    
    let race = viewModel.races[indexPath.row]

    cell.nameLabel.text = race.name
    cell.dateLocationLabel.text = "\(race.date) @ \(race.location)"
    cell.typeLabel.text = race.type
    
    return cell
  }
  
  func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
    forRowAtIndexPath indexPath: NSIndexPath) {
      //TODO: when halfway through scrolling load next page, look to viewmodel to tell us if thats needed
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.races.count
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
    searchBar.setShowsCancelButton(true, animated: true)
  }
  
  func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    searchBar.text = ""
    searchBar.endEditing(true)
    searchBar.setShowsCancelButton(false, animated: true)
  }
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    //TODO search for stuff here
  }

}
