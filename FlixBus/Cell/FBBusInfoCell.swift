//
//  WUCarInfoCell.swift
//  WeSerVite
//
//  Created by sanjay on 05/08/18.
//  Copyright © 2017 sanjay chauhan. All rights reserved.
//

import UIKit
@IBDesignable
class FBBusInfoCell: UITableViewCell {
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var directionLabel: UILabel!
  @IBOutlet weak var routeLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
  /// Display data on table view cell
  ///
  /// - Parameter data: WUPlaceMark containing all info
  func displayData(data: FBArrivalDeparture) {
    timeLabel.text = getDate(timeStamp: data.datetime.timestamp, timeZone: data.datetime.tz)
    directionLabel.text = data.direction
    routeLabel.text = data.station
  }
  
  func getDate(timeStamp: Int, timeZone: String) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: timeZone) //Set timezone that you want
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "HH:mm" //Specify your format that you want
    let time = dateFormatter.string(from: date)
    return time
  }
  @IBInspectable var cornerRadius: CGFloat = 0 {
    didSet {
      layer.cornerRadius = cornerRadius
      layer.masksToBounds = cornerRadius > 0
    }
  }
  @IBInspectable var borderWidth: CGFloat = 0 {
    didSet {
      layer.borderWidth = borderWidth
    }
  }
}
