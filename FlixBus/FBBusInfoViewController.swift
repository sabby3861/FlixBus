//
//  FBBusInfoViewController.swift
//  FlixBus
//
//  Created by sanjay on 07/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import UIKit

class FBBusInfoViewController: UIViewController {
  
  @IBOutlet weak var tableView: FBTableView!
  var data: [FBArrivalDeparture]?
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    tableView.addCellIdentifiers(["FBBusInfoCell"])
    
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
    return data!.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "FBBusInfoCell", for: indexPath) as! FBBusInfoCell
    cell.displayData(data: data![indexPath.row])
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
}

