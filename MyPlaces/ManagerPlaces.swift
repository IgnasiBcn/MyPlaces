//
//  ManagerPlaces.swift
//  MyPlaces
//
//  Created by iMac on 2/10/18.
//  Copyright © 2018 Ignasi Pérez. All rights reserved.
//

import Foundation

class ManagerPlaces: Codable {
    
    var places: [Place] = []
    
    // A collection containing subscribers
    public var managerPlacesObservers = Array<ManagerPlacesObserver>()

    
    enum CodingKeys: String, CodingKey {
        
        case places
        
    }
    
    
    enum PlacesTypeKey: CodingKey {
        
        case type
        
    }
    
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(places, forKey: .places)
        
    }
    
    
    func decode(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        places = [Place]()
        
        var objectsArrayForType = try container.nestedUnkeyedContainer(
            forKey: CodingKeys.places)
        
        var tmp_array = objectsArrayForType
        
        while !objectsArrayForType.isAtEnd {
            
            let object = try objectsArrayForType.nestedContainer(keyedBy: PlacesTypeKey.self)
            let type = try object.decode(Place.PlacesTypes.self, forKey: PlacesTypeKey.type)
            
            switch type {
            case Place.PlacesTypes.TouristicPlace:
                self.append(try tmp_array.decode(PlaceTourist.self))
            default:
                self.append(try tmp_array.decode(Place.self))
            }
        }
        
    }
    
    
    //  PLA2 - 6.5.3
    func store() {
        
        do {
            let encoder = JSONEncoder()

            let data: Data = try encoder.encode(self)
            
            for place in places {
                
                if place.image != nil {
                    FileSystem.writeData(id: place.id, image: place.image!)
                    place.image = nil
                }
                
                FileSystem.write(data: String(data: data, encoding: .utf8)!)
                
                // let data_str = FileSystem.read()
            }
        }
        catch {
            
        }
    }
    
    
    private static func load() -> ManagerPlaces? {
        var resul: ManagerPlaces? = nil
        let data_str = FileSystem.read()
        if data_str != "" {
            do {
                let decoder = JSONDecoder()
                let data = Data(data_str.utf8)
                resul = try decoder.decode(ManagerPlaces.self, from: data)
            }
            catch
            {
                resul = nil
            }
        }
        return resul
    }
    
    
    func append(_ value: Place) {
        
        places.append(value)
        
    }
    
    
    func getCount() -> Int {
        
        return places.count
        
    }
    
    
    func getItemAt(position:Int) -> Place {
        
        return places[position]
        
    }


    func getItemById(id: String) -> Place {
        
        let placeFiltered = places.filter {$0.id == id}
        return placeFiltered[0]
        
    }
    

    func remove(_ value: Place) {
        
        places = places.filter {$0.id != value.id}
        
    }
    
    
    func getPathImage(p: Place) -> String {
        
        let r = FileSystem.getPathImage(id: p.id)
        return r
        
    }
    
    
    
    //  *****************************************************************
    //  MARK: - SINGLETON Design Pattern
    //
    //  PLA1 - 3.4
    //
    //  Unique instance for all App
    //
    private static var sharedManagerPlaces: ManagerPlaces = {
        
        var singletonManager: ManagerPlaces?
        
        singletonManager = load()
        
        if singletonManager == nil {
            singletonManager = ManagerPlaces()
        }
        
        return singletonManager!
    }()
    

    class func shared() -> ManagerPlaces {
        
        return sharedManagerPlaces
        
    }
    
    
    
    //  *****************************************************************
    //  MARK: - OBSERVER Design Pattern
    //
    //  PLA2 - 5.3
    //
    /// Observers subscribe themselfs to the list of observers
    /// Observers: FirstViewController and SecondViewController
    //
    public func addObserver(object: ManagerPlacesObserver) {
        
        managerPlacesObservers.append(object)
        
    }
    
    
    func updateObservers() {
        
        for item in managerPlacesObservers {
            print("ManagerPlaces updateObservers() - \(item)")
            item.onPlacesChange()
        }
        
    }
    
}



//  PLA2 - 5.1
//
/// All subscribers will have to implement the onPlacesChange() method of this protocol.
/// In this App the subscribers objects are: FirstViewController and SecondViewController
//
protocol ManagerPlacesObserver {
    
    func onPlacesChange()
    
}





protocol ManagerPlaceable {
    
//    func getCount() -> Int
//    func getItemAt(position:Int) -> Place
//    func getItemById(id: String) -> Place
//    func remove(_ value: Place)
//    func getPathImage(p: Place) -> String
}

extension ManagerPlaceable {
    
    func store() {
        
        return ManagerPlaces.shared().store()
        
    }
    
    
    func append(_ value: Place) {
        
        ManagerPlaces.shared().append(value)
        
    }
    
    
    func getCount() -> Int {
        
        return ManagerPlaces.shared().getCount()
        
    }
    
    
    func getItemAt(position: Int) -> Place {
        
        return ManagerPlaces.shared().getItemAt(position: position)
        
    }
    
    
    func getItemById(id: String) -> Place {
        
        return ManagerPlaces.shared().getItemById(id: id)
        
    }
    
    
    func remove(_ value: Place) {
        
        ManagerPlaces.shared().remove(value)
        
    }
    
    
    func getPathImage(p: Place) -> String {
        
        return ManagerPlaces.shared().getPathImage(p: p)
        
    }
    
    
    func addObserver(object: ManagerPlacesObserver) {
        
        ManagerPlaces.shared().addObserver(object: object)
        
    }
    
    func updateObservers() {
        
        ManagerPlaces.shared().updateObservers()
        
    }
    
}
