import UIKit

class DiscoverRacesViewController: UIViewController {

  @IBOutlet private weak var nextWeekendButton: UIButton!
  @IBOutlet private weak var nextMonthButton: UIButton!
  @IBOutlet private weak var otherDatesButton: UIButton!
  @IBOutlet private weak var thisWeekendButton: UIButton!
  @IBOutlet private weak var racesTable: UITableView!
  
  private let progressBar = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
  private let messageLabel = UILabel()
  private let refreshControl = UIRefreshControl()
  
  var races: [Race] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureView()
    
    //load races if no races
    createRaces()
  }
  
  func refreshData(sender: AnyObject) {
    //TODO refresh data here using whatever is in core data for settings and search
  }
  
  private func configureView() {
    messageLabel.numberOfLines = 0;
    messageLabel.textColor = UIColor.darkGrayColor()
    messageLabel.textAlignment = NSTextAlignment.Center
    
    refreshControl.addTarget(self, action: "refreshData:", forControlEvents: UIControlEvents.ValueChanged)
    racesTable.addSubview(refreshControl)
    
    racesTable.separatorStyle = UITableViewCellSeparatorStyle.None
    racesTable.rowHeight = UITableViewAutomaticDimension
    racesTable.estimatedRowHeight = 160.00
    
    progressBar.center = racesTable.center
    progressBar.hidesWhenStopped = true
  }
  
  private func setTableViewMessageLabel(message: String) {
    messageLabel.text = message
    racesTable.backgroundView = messageLabel
  }
  
  private func displayProgressBar(display: Bool) {
    if (display) {
      racesTable.backgroundView = progressBar
      progressBar.startAnimating()
    } else {
      racesTable.backgroundView = nil
      progressBar.stopAnimating()
    }
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
//    return races.count
    return 0;
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
