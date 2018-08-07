//
//  FBHomeInteractor.swift
//  FlixBus
//
//  Created by sanjay on 07/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation
class FBHomeInteractor: FBHomeInteractorProtocol {
  var output: FBHomeOutputProtocol?
  
  func decodeJSONInformation(){
    let parser = WUJSONParser()
    let service = WUBusInfoParser()
    parser.request(resource: service.busInfoService) { [unowned self] result in
      //print("Result Is \(result)")
      switch result {
      case .success(let data):
        //print("Data is \(data)")
        self.output?.busInfoDidFetch(busInfo: data.timetable)
      case .failure(let missing):
        let error = missing.localizedDescription
        print("Description  \(error)")
        FBAlertViewController.showAlert(withTitle: "Error", message:  String(describing: missing))
      }
    }
  }
  
}
