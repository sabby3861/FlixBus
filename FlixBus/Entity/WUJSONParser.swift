//
//  WUJSONParser.swift
//  Wunder
//
//  Created by sanjay on 06/08/18.
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
      //let json = try JSONSerialization.jsonObject(with: data, options: [])
      //print("Json is \(json)")
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


/// Bus Time Table info
struct FBTimeTable : Codable {
  let arrivals: [FBArrivalDeparture]
  let departures: [FBArrivalDeparture]
}


/// Bus Arrival and Departure Info
struct FBArrivalDeparture : Codable {
  let station: String
  let datetime: FBDateTime
  let linedirection: String
  let route: [FBRoute]
  let lineCode: String
  let direction: String
  enum CodingKeys: String, CodingKey {
    case station = "through_the_stations"
    case datetime = "datetime"
    case linedirection = "line_direction"
    case route = "route"
    case lineCode = "line_code"
    case direction = "direction"
  }
  
  struct FBDateTime : Codable {
    let timestamp: Int
    let tz: String
  }
}


/// Bus Route Info
struct FBRoute : Codable {
  let id: Int
  let name: String
  let defaultAddress: FBAddress
  let address: String
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case name = "name"
    case defaultAddress = "default_address"
    case address = "address"
  }
  
  /// Address Info
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
  
  /// Coordinate Info
  struct FBCoordinate : Codable {
    var latitude: Double
    var longitude: Double
    enum CodingKeys: String, CodingKey {
      case latitude = "latitude"
      case longitude = "longitude"
    }
  }
  
}
