//
//  FBPayLoadHeaders.swift
//  FlixBus
//
//  Created by sanjay on 06/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation
protocol PayLoadFormat {
  func formatGetPayload()
}
extension PayLoadFormat{
  func formatGetPayload() {
    var payload = FBHTTPPayload(payloadType: .RequestMethodGET)
    payload.addHeader(name: FBHTTPHeaderType.contentType.rawValue, value: FBHTTPMimeType.applicationJSON.rawValue)
    payload.addHeader(name: FBHTTPHeaderType.authentication.rawValue, value: FBHTTPMimeType.key.rawValue)
    ServiceManager.payload = payload
  }
}

struct ServiceManager {
  static var payload: FBHTTPPayload?
}

struct FBHTTPPayload {
  var type: FBHTTPPayloadType!
  var headers = Dictionary<String, String>()
  
  init(payloadType: FBHTTPPayloadType) {
    self.type = payloadType
  }
  mutating func addHeader(name: String, value: String) {
    headers[name] = value
  }
  
}

enum FBHTTPMimeType: String {
  case applicationJSON = "application/json; charset=utf-8"
  case key = "intervIEW_TOK3n"
}
enum FBHTTPHeaderType: String{
  case authentication  = "X-Api-Authentication"
  case contentType    = "Content-Type"
}

enum FBHTTPMethod: String {
  case get
}

enum FBHTTPPayloadType{
  case RequestMethodGET
  func httpMethod() -> String {
    switch self{
    case .RequestMethodGET: return FBHTTPMethod.get.rawValue
    }
  }
}


