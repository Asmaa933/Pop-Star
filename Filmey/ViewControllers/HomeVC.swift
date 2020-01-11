//
//  HomeVC.swift
//  Filmey
//
//  Created by Asmaa Tarek on 1/3/2019.
//  Copyright © 2020 Asmaa Tarek. All rights reserved.
//

import UIKit
import RevealingSplashView

class HomeVC: UIViewController,UITabBarControllerDelegate{

    
    @IBOutlet weak var changeView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nowPlayingBtn: UIButton!
    @IBOutlet weak var mostPopularBtn: UIButton!
    @IBOutlet weak var topRatedBtn: UIButton!
   
    var nowPlayingArr = [MovieModel]()
    var topRatedArr = [MovieModel]()
    var mostPopularArr  = [MovieModel]()
    var movieID = 0
    var renderedArr: arrays = .now
    var nowCounter = 1
    var topCounter = 1
    var mostCounter = 1
    var arr = [MovieModel]()
    var alertCounter = 0
    var imageView = UIImageView()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
               self.navigationController?.navigationBar.isHidden = true
    splashScreenShower()


    }
  
    func checkReachability()
    {

        if Reachability.isConnectedToNetwork()
        {
            
                imageView.removeFromSuperview()
              getNowPlaying()
            self.navigationController?.navigationBar.isHidden = false
                self.tabBarController?.tabBar.isHidden = false
                alertCounter = 0
               }
               else
               {
                if alertCounter == 0
                {
                    showAlertView(message: "Check internet connection")

                }

               }
    }
    func handleNoInternet()
    {
        imageView = UIImageView(frame: CGRect(x: 50, y: 100, width: 300, height: 300))
        imageView.center = view.center
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "internet", in: Bundle(for: type(of: self)), compatibleWith: nil)
        view.addSubview(imageView)
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(HomeVC.gestureRecognizer))
        downSwipe.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(downSwipe)
        checkReachability()
    }
    @objc func gestureRecognizer()
    {
        checkReachability()
    }
   
    func splashScreenShower()
    {
        MoviesServices.resetArray(arr: .now)
               let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "1")!,iconInitialSize: CGSize(width: 70, height: 70), backgroundColor: UIColor(red:0.11, green:0.56, blue:0.95, alpha:1.0))
               revealingSplashView.animationType = SplashAnimationType.swingAndZoomOut
               self.view.addSubview(revealingSplashView)
               revealingSplashView.startAnimation()
                {
               
                    self.checkReachability()

                }
    }
    override func viewWillAppear(_ animated: Bool)
    {

        collectionView.reloadData()
    }
    
    func getNowPlaying()
    {
            MoviesServices.getMovies(pageNum: nowCounter, array: .now) { (responseModel, error) in
                if responseModel != nil && error == nil
                {
                    self.renderedArr = .now
                    self.nowPlayingArr = responseModel!
                }
                DispatchQueue.main.async
                {
                    MoviesServices.resetArray(arr: .top)
                    MoviesServices.resetArray(arr: .most)
                    self.mostPopularArr = []
                    self.topRatedArr = []
                    self.navigationController?.navigationBar.topItem?.title = "Now Playing"
                    self.collectionView.reloadData()
                }
            }
        }
    
    @IBAction func barBtnPressed(_ sender: UIBarButtonItem)
    {
        changeView.isHidden = !changeView.isHidden
        
    }
    
    @IBAction func nowPlayingBtnTapped(_ sender: UIButton)
    {
        self.collectionView?.scrollToItem(at: IndexPath(row: 0, section: 0),at: .top,animated: true)
        nowPlayingBtn.isHidden = true
        topRatedBtn.isHidden = false
        mostPopularBtn.isHidden = false
        changeView.isHidden = true
        getNowPlaying()
    }
    
    @IBAction func topRatedBtnPressed()
    {

        self.collectionView?.scrollToItem(at: IndexPath(row: 0, section: 0),at: .top,animated: true)
        nowPlayingBtn.isHidden = false
        topRatedBtn.isHidden = true
        mostPopularBtn.isHidden = false
        changeView.isHidden = true
            MoviesServices.getMovies(pageNum: topCounter, array: .top) { (responseModel, error) in
                if responseModel != nil && error == nil
                {
                    self.renderedArr = .top
                    self.topRatedArr = responseModel!
                    DispatchQueue.main.async {
                        
                        MoviesServices.resetArray(arr: .now)
                        MoviesServices.resetArray(arr: .most)
                        self.nowPlayingArr = []
                        self.mostPopularArr = []
                        
                        self.navigationController?.navigationBar.topItem?.title = "Top Rated"
                        
                        self.collectionView.reloadData()
                        
                }
            }
        }
    }
    @IBAction func mostPopularBtnPressed() {
        self.collectionView?.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top,animated: true)
        nowPlayingBtn.isHidden = false
        topRatedBtn.isHidden = false
        mostPopularBtn.isHidden = true
        changeView.isHidden = true

            MoviesServices.getMovies(pageNum: mostCounter, array: .most) { (responseModel, error) in
                if responseModel != nil && error == nil
                {
                    self.renderedArr = .most
                    self.mostPopularArr = responseModel!
                    DispatchQueue.main.async
                    {
                        MoviesServices.resetArray(arr: .now)
                        MoviesServices.resetArray(arr: .top)
                        self.nowPlayingArr = []
                        self.topRatedArr = []
                        
                        self.navigationController?.navigationBar.topItem?.title = "Most Popular"
                        
                        self.collectionView.reloadData()
                    
                }
            }
        }
        
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem)
    {
        self.viewWillAppear(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "movieSegue")
        {
            if let detail = segue.destination as? MovieDetailsVC
            {
                detail.selectedMovieID = movieID
            }
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController)
    {
        viewWillAppear(true)
    }
    func showAlertView(message: String)
    {
        alertCounter += 1;
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "ok", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
            self.handleNoInternet()

        }
        let action2 = UIAlertAction(title: "Try again ", style: .default) { (action) in
            self.checkReachability()
        }
       alert.addAction(action1)
        alert.addAction(action2)

       self.present(alert, animated: true, completion: nil)
    }
}

extension HomeVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        switch renderedArr {
        case .now:
            arr = nowPlayingArr
        case .top:
            arr = topRatedArr
        case .most:
            arr = mostPopularArr
            
        }
        
        return arr.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? moviesCell else
        {
            print("can't get")
            return UICollectionViewCell()
        }
        cell.configureCell(poster_path: arr[indexPath.row].poster_path)
         
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        movieID = arr[indexPath.row].id
    performSegue(withIdentifier: "movieSegue", sender: nil)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == arr.count - 1
        {
            switch renderedArr {
                   case .now:
                    if nowCounter <= nowPlayingMaxPage
                    {
                        self.nowCounter += 1;
                        getNowPlaying()

                    }
            case .top:
                if topCounter <= topRatedMaxPage
                {
                    topCounter += 1;
                    topRatedBtnPressed()

                }
                   case .most:
                    if mostCounter <= mostPopularMaxPage
                    {
                        mostCounter += 1 ;
                        mostPopularBtnPressed()
                    }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: CGFloat((collectionView.frame.size.width / 2) - 10 ), height: (collectionView.frame.size.height / 2 ) - 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)
    }
   
}




