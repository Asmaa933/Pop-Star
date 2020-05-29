//
//  FavoriteVC.swift
//  Filmey
//
//  Created by Asmaa Tarek on 1/3/2019.
//  Copyright © 2020 Asmaa Tarek. All rights reserved.
//

import UIKit
import SDWebImage

class FavoriteVC: UIViewController,UITabBarControllerDelegate {
    
    @IBOutlet weak private var favTable: UITableView!
    private var favoriteArr = [FavoriteMovies]()
    var movieID = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        favTable.tableFooterView = UIView()
        let nib = UINib(nibName: "favoriteCell", bundle: nil)
        favTable.register(nib, forCellReuseIdentifier: "favCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteArr = CoreDataHandler.getDataFromCoreData() ?? []
        
        favTable.reloadData()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        viewWillAppear(true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if (segue.identifier == "favorite"){
            if let detail = segue.destination as? MovieDetailsVC{
                detail.selectedMovieID = movieID
            }
        }
    }
}
extension FavoriteVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favoriteArr.isEmpty{
            tableView.setEmptyView(title: "You don't have favorite movie", message: "Your favorites will be in here.", messageImage: #imageLiteral(resourceName: "popcorn"))
            
        }
        else {
            tableView.restore()
        }
        return favoriteArr.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favCell") as? favoriteCell else{
            print("can't get")
            return UITableViewCell()
        }
        let title = favoriteArr[indexPath.row].original_title ?? ""
        let releaseDate = favoriteArr[indexPath.row].release_date ?? ""
        let rate = "⭐️ \(favoriteArr[indexPath.row].vote_average)"
        let imageURL = "https://image.tmdb.org/t/p/w185/\(favoriteArr[indexPath.row].poster_path ?? "")"
        cell.configureCell(imageURL: imageURL, title: title, release: releaseDate, rate: rate)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let alert = UIAlertController(title: "Alert", message: "Are you sure want to delete movie from favourites", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                self.favoriteArr = CoreDataHandler.deleteObjectFromCoreData(movieItem: self.favoriteArr[indexPath.row]) ?? []
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            let action2 = UIAlertAction(title: "Cancel", style: .default) { (action) in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(action1)
            alert.addAction(action2)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieID = Int (favoriteArr[indexPath.row].id)
        performSegue(withIdentifier: "favorite", sender: nil)
    }
    
}
