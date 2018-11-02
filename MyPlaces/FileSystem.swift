//
//  FileSystem.swift
//  MyPlaces
//

//  Copyright © 2018 UOC. All rights reserved.
//

import Foundation

class FileSystem
{
    class func getPathBase() -> String
    {
        let pathBase: String =
            NSSearchPathForDirectoriesInDomains(
                .documentDirectory,
                .userDomainMask,
                true)[0]
        
        do
        {
            let fileManager: FileManager = FileManager()
            
            try fileManager.createDirectory(
                atPath: pathBase,
                withIntermediateDirectories: true,
                attributes: nil)
        }
        catch
        {
            
            
        }
        return pathBase
    }
    
    
    class func getPath() -> URL
    {
        // Get App Document directory
        let pathBase: String = getPathBase()
        
        
        let pathBD: String = pathBase + "/database.txt"

        let url = URL(fileURLWithPath: pathBD)
        
        return url
    }
    
    
    class func read() -> String
    {
        var data: String = ""

        
        do {
             data = try String(contentsOf: getPath(), encoding: .utf8)
        }
        catch {
            //************ error handling
            
        }
        return data
    }
    
    
    class func getPathImage(id: String) -> String
    {
        return getPathBase() + "/" + id;
    }
    
    
    class func writeData(id:String, image:Data)
    {
        do {
            try image.write(to: URL(fileURLWithPath: getPathBase() + "/" + id))
        }
        catch {
            //************ error handling
        }
    }

    
    class func write(data: String)
    {
        do {
            try data.write(to: getPath(), atomically: false, encoding: .utf8)
        }
        catch {
            //************ error handling
        }

    }
}
