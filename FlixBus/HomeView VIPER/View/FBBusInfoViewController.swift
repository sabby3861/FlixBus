//
//  FBBusInfoViewController.swift
//  FlixBus
//
//  Created by sanjay on 07/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import UIKit

class FBBusInfoViewController: UIViewController, FBTimeManagement {
  
  @IBOutlet weak var tableView: FBTableView!
  var data: [FBArrivalDeparture]?
  var groupData: [Int : [FBArrivalDeparture]]?
  var values: [[FBArrivalDeparture]]?
  var keys: [Int]?
  var sectionArray = [NSString]()
  var dateFormat: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    groupData = Dictionary(grouping: data!, by: { $0.datetime.timestamp } )
    // Create Array of the Values for cell
    values = Array(groupData!.values)
    // Create section keys array
    keys = Array(groupData!.keys)
    
    tableView.addCellIdentifiers(["FBBusInfoCell"])
    self.title = data?.first?.direction
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}



// MARK: - Extension for TableView DataSource
extension FBBusInfoViewController: UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return values![section].count
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let data = values![section].first
    self.dateFormat = "dd/mm/yy"
    let title = getDate(timeStamp: (data?.datetime.timestamp)!, timeZone: (data?.datetime.tz)!)
    return "   \(title)"
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "FBBusInfoCell", for: indexPath) as! FBBusInfoCell
    let value = values![indexPath.section]
    cell.displayData(data: value[indexPath.row])
    return cell
  }
}

// MARK: - Extension for TableView Delegate
extension FBBusInfoViewController: UITableViewDelegate{
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
    return UITableViewAutomaticDimension
  }
  func numberOfSections(in tableView: UITableView) -> Int {
    return (groupData?.keys.count)!
  }
}


