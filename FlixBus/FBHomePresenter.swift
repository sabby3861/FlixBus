//
//  FBHomePresenter.swift
//  FlixBus
//
//  Created by sanjay on 07/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation
class FBHomePresenter: FBHomePresenterProtocol {
  var view: FBHomeViewProtocol?
  var router: FBHomeRouterProtocol?
  var interactor: FBHomeInteractorProtocol?
  
  func fetchBusInformation(){
    interactor?.decodeJSONInformation()
  }
  
}


// MARK: - Presenter to view communication
extension FBHomePresenter: FBHomeOutputProtocol{
  
  func busInfoDidFetch(busInfo: FBTimeTable){
    view?.showBusInformation(with: busInfo)
  }
}
