//
//  FBHomeViewController.swift
//  FlixBus
//
//  Created by sanjay on 06/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import UIKit

class FBHomeViewController: UIViewController, PayLoadFormat {

  var presenter: FBHomePresenterProtocol?
  var container: UIView!
  var loadingView: UIView!
  var actInd: UIActivityIndicatorView!
  var timeTableData: FBTimeTable?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    formatGetPayload()
    showActivityIndicatory(uiView: self.view)
    self.presenter?.fetchBusInformation()

  }

  @IBAction func arrivalsButtonClicked(_ sender: Any) {
    self.presenter?.sendDataToBusInfoView(busInfo: (timeTableData?.arrivals)!)
  }
  
  @IBAction func departuresButtonClicked(_ sender: Any) {
    self.presenter?.sendDataToBusInfoView(busInfo: (timeTableData?.departures)!)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func showActivityIndicatory(uiView: UIView) {
    container = UIView()
    container.frame = uiView.frame
    container.center = uiView.center
    container.backgroundColor = UIColor(white: 0.5, alpha: 0.3)//UIColor(hex: "0xffffff").withAlphaComponent( 0.3)
    loadingView = UIView()
    loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    loadingView.center = uiView.center
    loadingView.backgroundColor = UIColor(white: 0.5, alpha: 0.7)
    loadingView.clipsToBounds = true
    loadingView.layer.cornerRadius = 10
    
    actInd = UIActivityIndicatorView()
    actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40);
    actInd.activityIndicatorViewStyle =
      UIActivityIndicatorViewStyle.whiteLarge
    actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
    loadingView.addSubview(actInd)
    container.addSubview(loadingView)
    uiView.addSubview(container)
    actInd.startAnimating()
  }
  
  func removeActivity() {
    actInd.stopAnimating()
    actInd.removeFromSuperview()
    loadingView.removeFromSuperview()
    container.removeFromSuperview()
  }
}

extension FBHomeViewController: FBHomeViewProtocol{
  func showBusInformation(with info: FBTimeTable){
    timeTableData = info
    DispatchQueue.main.async {
      self.removeActivity()
    }
  }
  func removeActivityView(){
    DispatchQueue.main.async {
      self.removeActivity()
    }
  }
}
