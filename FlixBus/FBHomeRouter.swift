//
//  FBHomeRouter.swift
//  FlixBus
//
//  Created by sanjay on 07/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation

class FBHomeRouter: FBHomeRouterProtocol {
  static func assembleModule(view: FBHomeViewController){
    let presenter = FBHomePresenter()
    let router = FBHomeRouter()
    let interactor = FBHomeInteractor()
    presenter.view = view
    presenter.interactor = interactor
    presenter.router = router
    
    interactor.output = presenter
    view.presenter = presenter
    //router.viewController = view
  }
}
