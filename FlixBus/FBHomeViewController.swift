//
//  FBHomeViewController.swift
//  FlixBus
//
//  Created by sanjay on 06/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import UIKit

class FBHomeViewController: UIViewController, PayLoadFormat {

  override func viewDidLoad() {
    super.viewDidLoad()
    formatGetPayload()
    // Do any additional setup after loading the view, typically from a nib.
    
    let parser = WUJSONParser()
    let service = WUCarInfo()
    parser.request(resource: service.carInfoService) { [unowned self] result in
      print("Resul Is \(result)")
      switch result {
      case .success(let data):
        print("Data is \(data)")
        //self.output?.carInfoDidFetch(placeMarks: data.placemarks)
      case .failure(let missing):
        let error = missing.localizedDescription
        print("Description  \(error)")
    
      }
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

