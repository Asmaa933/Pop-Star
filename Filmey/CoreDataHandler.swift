//
//  CoreDataHandler.swift
//  Movie using core data
//
//  Created by Asmaa Tarek on 12/24/2019.
//  Copyright © 2019 Asmaa Tarek. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class CoreDataHandler {
    class func getCoreDataobject() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    class func saveIntoCoreData(movieItem: FavouriteMovies){
           let context = CoreDataHandler.getCoreDataobject()
           do{
               try context.save()
               print("Saved")
           } catch {
               print("error in saving")
           }
        
       }
    class func getDataFromCoreData() -> [FavouriteMovies]? {
        let context = CoreDataHandler.getCoreDataobject()
        var movies : [FavouriteMovies]?
        do{
            movies = try context.fetch(FavouriteMovies.fetchRequest())
            print("fetched")

        }catch{
        print("error in get data")
        }
        
        
        return movies
        
    }
     class func deleteObjectFromCoreData (movieItem: FavouriteMovies) -> [FavouriteMovies]? {
            let context = CoreDataHandler.getCoreDataobject()
        context.delete(movieItem)
            do {
                try context.save()
                print("deleted")
            }catch{
                print("error in delete data")
            }
            return CoreDataHandler.getDataFromCoreData()
        }
    
    class func checkforSpecificItemFromCoreData(movieID: Int) -> Bool{
           var movie = [FavouriteMovies]()
           let context = CoreDataHandler.getCoreDataobject()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: FavouriteMovies.entity().name ?? "")
           request.predicate = NSPredicate(format: "id = \(Int64(movieID))")
           do{
               movie =  try  context.fetch(request) as? [FavouriteMovies] ?? []
           }catch(let error){
               print(error.localizedDescription)
           }
        return !movie.isEmpty
           
       }
}

    

