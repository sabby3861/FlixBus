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
  var presenter: FBHomePresenterProtocol? { get }
  func showBusInformation(with info: FBTimeTable)
  func removeActivityView()
}

/// View -> Interactor and View -> Router Communication Protocols
protocol FBHomePresenterProtocol: class
{
  var view: FBHomeViewProtocol? { get }
  var router: FBHomeRouterProtocol? { get }
  var interactor: FBHomeInteractorProtocol?{get}
  func fetchBusInformation()
  func sendDataToBusInfoView(busInfo: [FBArrivalDeparture])
}


/// Interactor -> Presenter Communication Protocols
protocol FBHomeInteractorProtocol: class
{
  var output: FBHomeOutputProtocol? { get }
  func decodeJSONInformation()
}

protocol FBHomeOutputProtocol: class
{
  func busInfoDidFetch(busInfo: FBTimeTable)
  func errorOccured()
}

/// Router Protocols and assembling Module
protocol FBHomeRouterProtocol: class
{
  var viewController: FBHomeViewController? { get}
  static func assembleModule(view: FBHomeViewController)
  func showBusInfoView(busInfo: [FBArrivalDeparture])
}
