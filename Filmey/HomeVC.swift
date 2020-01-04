//
//  HomeVC.swift
//  Filmey
//
//  Created by Asmaa Tarek on 1/3/2019.
//  Copyright © 2020 Asmaa Tarek. All rights reserved.
//

import UIKit
import SDWebImage

class HomeVC: UIViewController,UITabBarDelegate {

    @IBOutlet weak var changeView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    let service = MoviesServices()
    var nowplayingArr = [movieModel]()
    var topRatedArr = [movieModel]()
    var mostPopularArr  = [movieModel]()

    var arrayNum = 1
    var arr = [movieModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        }
    override func viewWillAppear(_ animated: Bool) {
                getData()

    }
      func getData()
      {
        service.nowPlayingData { (responseModel, error) in
            if responseModel.isEmpty == false && error == nil{
                self.arrayNum = 1
                self.nowplayingArr = responseModel
                DispatchQueue.main.async {
                self.collectionView.reloadData()

                }
            }
        }
      }
    
    
    @IBAction func barBtnPressed(_ sender: UIBarButtonItem) {
        changeView.isHidden = !changeView.isHidden
        
    }
    
    @IBAction func topRatedBtn(_ sender: UIButton)
    {
        changeView.isHidden = true
        service.topRatedData { (responseModel, error) in
            if responseModel.isEmpty == false && error == nil{
                self.arrayNum = 2
                        self.topRatedArr = responseModel
                        DispatchQueue.main.async {
                        self.collectionView.reloadData()

                        }
        }
        }
    }
    
    @IBAction func mostPopularBtn(_ sender: UIButton) {
        
        changeView.isHidden = true
        service.mostPopularData { (responseModel, error) in
            if responseModel.isEmpty == false && error == nil{
            self.arrayNum = 3
                    self.mostPopularArr = responseModel
                    DispatchQueue.main.async {
                    self.collectionView.reloadData()
        }
        
      
                  

                              }
              }
              }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.viewWillAppear(true)
    }
    
}
extension HomeVC : UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch arrayNum {
        case 1:
            arr = nowplayingArr
            case 2:
             arr = topRatedArr
            case 3:
            arr = mostPopularArr
        default:
            break
        }
        return arr.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? moviesCell else
        {
           print("can't get")
            return UICollectionViewCell()
        }
        cell.movieImg?.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w185/\(arr[indexPath.row].poster_path)"), placeholderImage: UIImage(named: "popcorn"),completed: nil)
        return cell
    }
    
    
}
