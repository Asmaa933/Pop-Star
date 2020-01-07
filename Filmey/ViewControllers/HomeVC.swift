//
//  HomeVC.swift
//  Filmey
//
//  Created by Asmaa Tarek on 1/3/2019.
//  Copyright © 2020 Asmaa Tarek. All rights reserved.
//

import UIKit
import SDWebImage

class HomeVC: UIViewController,UITabBarControllerDelegate{

    @IBOutlet weak var changeView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    let service = MoviesServices()
    var nowPlayingArr = [MovieModel]()
    var topRatedArr = [MovieModel]()
    var mostPopularArr  = [MovieModel]()
    var selectMovie: MovieModel?

    @IBOutlet weak var nowPlayingBtn: UIButton!
    @IBOutlet weak var mostPopularBtn: UIButton!
    @IBOutlet weak var topRatedBtn: UIButton!
    var arrayNum = 1
    var arr = [MovieModel]()
    override func viewDidLoad() {
      
        super.viewDidLoad()
        getNowPlaying()

       }
    override func viewWillAppear(_ animated: Bool) {

        collectionView.reloadData()
    }
      func getNowPlaying()
      {
        service.nowPlayingData { (responseModel, error) in
            if responseModel.isEmpty == false && error == nil{
                self.arrayNum = 1
                self.nowPlayingArr = responseModel
                
                DispatchQueue.main.async {
                 self.navigationController?.navigationBar.topItem?.title = "Now Playing"
                self.collectionView.reloadData()

                }
            }
        }
      }
    
    
    @IBAction func barBtnPressed(_ sender: UIBarButtonItem) {
        changeView.isHidden = !changeView.isHidden
        
    }
    
    @IBAction func nowPlayingBtnTapped(_ sender: UIButton)
    {
        nowPlayingBtn.isHidden = true
        topRatedBtn.isHidden = false
        mostPopularBtn.isHidden = false
        changeView.isHidden = true
        getNowPlaying()
    }
    @IBAction func topRatedBtn(_ sender: UIButton)
    {
        nowPlayingBtn.isHidden = false
        topRatedBtn.isHidden = true
        mostPopularBtn.isHidden = false
        changeView.isHidden = true
        service.topRatedData { (responseModel, error) in
            if responseModel.isEmpty == false && error == nil{
                self.arrayNum = 2
                        self.topRatedArr = responseModel
                        DispatchQueue.main.async {
                  self.navigationController?.navigationBar.topItem?.title = "Top Rated"

                        self.collectionView.reloadData()

                        }
        }
        }
    }
    
    @IBAction func mostPopularBtn(_ sender: UIButton) {
        nowPlayingBtn.isHidden = false
        topRatedBtn.isHidden = false
        mostPopularBtn.isHidden = true
        changeView.isHidden = true
        service.mostPopularData { (responseModel, error) in
            if responseModel.isEmpty == false && error == nil{
            self.arrayNum = 3
                    self.mostPopularArr = responseModel
                    DispatchQueue.main.async {
                        self.navigationController?.navigationBar.topItem?.title = "Most Popular"

                    self.collectionView.reloadData()
        }
        
      
                  

                              }
              }
              }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.viewWillAppear(true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "movieSegue")
        {
            if let detail = segue.destination as? MovieDetailsVC
            {
                detail.selectedMovie = self.selectMovie
            }
        }
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        viewWillAppear(true)
    }
  
}

extension HomeVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
 
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch arrayNum {
        case 1:
            arr = nowPlayingArr
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectMovie = arr[indexPath.row]
              performSegue(withIdentifier: "movieSegue", sender: nil)
    }
     //  return CGSize(width: UIScreen.main.bounds.width  / 3, height: UIScreen.main.bounds.height / 3)

   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       return 5
   }

   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
       return 5
   }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)
    }
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     return CGSize(width: CGFloat((collectionView.frame.size.width / 2) - 10 ), height: (collectionView.frame.size.height / 2 ) - 50)
   }



   }
    
    


