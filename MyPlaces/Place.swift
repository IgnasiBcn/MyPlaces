//
//  Place.swift
//  MyPlaces
//
//  Created by iMac on 2/10/18.
//  Copyright © 2018 Ignasi Pérez. All rights reserved.
//

import Foundation
import MapKit


//  Type Alias Codable:
//  Codable is a type alias for the Encodable and Decodable protocols.
//  When you use Codable as a type or a generic constraint, it matches
//  any type that conforms to both protocols.
//
class Place: Codable
{
    var id = ""
    var type:PlacesTypes = .GenericPlace
    var name = ""
    var description = ""
    var location: CLLocationCoordinate2D!
    var image: Data? = nil
    
    enum PlacesTypes: Int, Codable
    {
        case GenericPlace
        case TouristicPlace
    }
    
    
    //  Protocol CodingKey:
    //  A type that can be used as a key for encoding and decoding.
    //
    enum CodingKeys: String, CodingKey
    {
        case id
        case description
        case name
        case type
        case latitude
        case longitude
    }
    
    
    init()
    {
        self.id = UUID().uuidString
    }
    
    
    init(name: String, description: String, image_in: Data?)
    {
        self.id = UUID().uuidString
        self.name = name
        self.description = description
        self.image = image_in
    }
    
    
    init(type:PlacesTypes, name: String, description: String, image_in: Data?)
    {
        self.id = UUID().uuidString
        self.type = type
        self.name = name
        self.description = description
        self.image = image_in
    }
    
    
    required convenience init(from decoder: Decoder) throws
    {
        self.init()
        try decode(from: decoder)
    }
    
    
    //  ********************************************************************
    //  MARK: - Encodable Protocol
    //  PLA2 - 6.3.3
    //
    //  Protocol Encodable
    /// Encodes this value into the given encoder.
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(type, forKey: .type)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(location.latitude, forKey: .latitude)
        try container.encode(location.longitude, forKey: .longitude)
    }
    
    
    func decode(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        type = try container.decode(PlacesTypes.self, forKey: .type)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        
        location = CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude)
    }
}
