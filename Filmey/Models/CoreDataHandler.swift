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
class CoreDataHandler
{
    class func getCoreDataobject() -> NSManagedObjectContext
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    class func saveIntoCoreData(movieItem: FavoriteMovies)
    {
        let context = CoreDataHandler.getCoreDataobject()
        do{
            try context.save()
        } catch {
            print("error in saving")
        }
    }
    class func getDataFromCoreData() -> [FavoriteMovies]?
    {
        let context = CoreDataHandler.getCoreDataobject()
        var movies : [FavoriteMovies]?
        do
        {
            movies = try context.fetch(FavoriteMovies.fetchRequest())
        }
        catch
        {
            print("error in get data")
        }
        return movies
    }
    class func deleteObjectFromCoreData (movieItem: FavoriteMovies) -> [FavoriteMovies]?
    {
        let context = CoreDataHandler.getCoreDataobject()
        context.delete(movieItem)
        do
        {
            try context.save()
        }
        catch
        {
            print("error in delete data")
        }
        return CoreDataHandler.getDataFromCoreData()
    }
    
    class func checkforSpecificItemFromCoreData(movieID: Int64) -> [FavoriteMovies]
    {
        var movies = [FavoriteMovies]()
        let context = CoreDataHandler.getCoreDataobject()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: FavoriteMovies.entity().name ?? "")
        request.predicate = NSPredicate(format: "id = \(movieID)")
        do
        {
            movies =  try  context.fetch(request) as? [FavoriteMovies] ?? []
        }catch
        {
            print("error in search")
        }
        return movies
        
    }
    
}



