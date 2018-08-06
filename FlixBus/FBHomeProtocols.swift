//
//  FBHomeProtocols.swift
//  FlixBus
//
//  Created by sanjay on 07/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation
/// View Protocols
protocol FBHomeViewProtocol: class
{
  var presenter: FBHomePresenterProtocol? { get set }
  func showBusInformation(with info: FBTimeTable)
}

/// View -> Interactor and View -> Router Communication Protocols
protocol FBHomePresenterProtocol: class
{
  var view: FBHomeViewProtocol? { get set }
  var router: FBHomeRouterProtocol? { get set }
  var interactor: FBHomeInteractorProtocol?{get set}
  func fetchBusInformation()
}


/// Interactor -> Presenter Communication Protocols
protocol FBHomeInteractorProtocol: class
{
  var output: FBHomeOutputProtocol? { get set }
  func decodeJSONInformation()
}

protocol FBHomeOutputProtocol: class
{
  func busInfoDidFetch(busInfo: FBTimeTable)
}

/// Router Protocols and assembling Module
protocol FBHomeRouterProtocol: class
{
  static func assembleModule(view: FBHomeViewController)
}
