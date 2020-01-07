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

    @IBOutlet weak var favTable: UITableView!
    var favouriteArr = [FavouriteMovies]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "favouriteCell", bundle: nil)
        favTable.register(nib, forCellReuseIdentifier: "favCell")
        favTable.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favouriteArr = CoreDataHandler.getDataFromCoreData() ?? []

        favTable.reloadData()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        viewWillAppear(true)
    }
}
extension FavoriteVC: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favouriteArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favCell") as? favouriteCell else{
            print("can't get")
            return UITableViewCell()
        }
        cell.titleLabel.text = favouriteArr[indexPath.row].original_title
        cell.releaseLabel.text = favouriteArr[indexPath.row].release_date
        cell.rateLabel.text = "⭐️ \(favouriteArr[indexPath.row].vote_average)"
        cell.movieImg?.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w185/\(favouriteArr[indexPath.row].poster_path ?? "")"), placeholderImage: UIImage(named: "popcorn"),completed: nil)
        
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
       favouriteArr = CoreDataHandler.deleteObjectFromCoreData(movieItem: favouriteArr[indexPath.row]) ?? []
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
}
