//
//  WUJSONParser.swift
//  Wunder
//
//  Created by sanjay on 04/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation
enum APIError: Error {
  case message(String)
  
  var localizedDescription: String {
    switch self {
    case .message(let string):
      return string
    }
  }
}
// return .failure(APIError.message(errorMessage))

let baseUrl = "http://api.mobile.staging.mfb.io/mobile/v1/network/station/1/timetable"
struct JSONParser<Model> {
  var request: URLRequest
  let parse: (Data) throws -> Model
}
enum Result<Model> {
  case success(Model)
  case failure(Error)
}

struct WUJSONParser{
  func request<Model>(resource: JSONParser<Model>, completion: @escaping (Result<Model>) -> Void) {
    URLSession.shared.dataTask(with: resource.request) { (data, _, error) in
      if let error = error {
        DispatchQueue.main.async {
          completion(.failure(error))
        }
      } else {
        if let data = data {
          do {
            let result = try resource.parse(data)
            DispatchQueue.main.async {
              completion(.success(result))
            }
          } catch let error {
            DispatchQueue.main.async {
              completion(.failure(error))
            }
          }
        }
      }
      }.resume()
  }
}

extension JSONParser {
  init(url: ServiceURL, parseJSON: @escaping (Any) throws -> Model) {
    print("Url is \(url.description)")
    // create the url request
    self.request = URLRequest(url: url.description)
    self.request.httpMethod = ServiceManager.payload?.type.httpMethod()
    for (key, value) in (ServiceManager.payload?.headers)! {
      self.request.setValue(value, forHTTPHeaderField: key)
    }
    self.parse = { data in
      let json = try JSONSerialization.jsonObject(with: data, options: [])
      print("Json is \(json)")
      return try parseJSON(data)
    }
  }
}

struct WUCarInfo {
  let carInfoService = JSONParser<FBBusInfo>(url: ServiceURL.CarService, parseJSON: { json in
    guard let data = json as? Data else {
      throw APIError.message("Unable to deconde the response")
    }
    return  try  JSONDecoder().decode(FBBusInfo.self, from: data)
  })
}

enum ServiceURL {
  case CarService;
  var description : URL {
    switch self {
    case .CarService: return URL(string: "\(baseUrl)")!;
    }
  }
}
  


/// Codable Protocol for response
struct FBBusInfo : Codable {
  let timetable: FBTimeTable
  enum CodingKeys: String, CodingKey {
    case timetable = "timetable"
  }
}


/// Placemarks info
struct FBTimeTable : Codable {
  let arrivals: [FBArrival]
}

struct FBArrival : Codable {
  let station: String
  let datetime: FBDateTime
  let linedirection: String
  let route: [FBRoute]
  enum CodingKeys: String, CodingKey {
    case station = "through_the_stations"
    case datetime = "datetime"
    case linedirection = "line_direction"
    case route = "route"
  }
  
  struct FBDateTime : Codable {
    let timestamp: Int
    let tz: String
  }
}

struct FBRoute : Codable {
  let id: Int
  let name: String
  let defaultAddress: FBAddress
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case name = "name"
    case defaultAddress = "default_address"
  }
  
  struct FBAddress : Codable {
    let address: String
    let fulladdress: String
    let coordinates: FBCoordinate
    enum CodingKeys: String, CodingKey {
      case address = "address"
      case fulladdress = "full_address"
      case coordinates = "coordinates"
    }
  }
  
  struct FBCoordinate : Codable {
    var latitude: Double
    var longitude: Double
    enum CodingKeys: String, CodingKey {
      case latitude = "latitude"
      case longitude = "longitude"
    }
  }
  
}

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
struct ServiceManager {
  static var payload: FBHTTPPayload?
}

