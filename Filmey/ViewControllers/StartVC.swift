//
//  ViewController.swift
//  Filmey
//
//  Created by Asmaa Tarek on 1/3/2019.
//  Copyright © 2020 Asmaa Tarek. All rights reserved.
//

import UIKit
import RevealingSplashView

class StartVC: UIViewController
{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        MoviesServices.resetArray(arr: .now)
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "1")!,iconInitialSize: CGSize(width: 70, height: 70), backgroundColor: UIColor(red:0.11, green:0.56, blue:0.95, alpha:1.0))
        revealingSplashView.animationType = SplashAnimationType.swingAndZoomOut
        self.view.addSubview(revealingSplashView)
        revealingSplashView.startAnimation()
    }
    
    
}

