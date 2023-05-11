//
//  LaunchViewController.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 22.04.2023.
//

import UIKit
import SwiftyGif

class LaunchViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var isUserLogged = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let refreshToken = CacheManager.shared.getString(forKey: "refreshToken") {
            isUserLogged = true
            Server.sharedInstance.refreshToken = refreshToken
        }
            
    }
    
    override func viewDidAppear(_ animated: Bool) {
        do {
            let gif = try UIImage(gifName: "LaunchScreen_GIF.gif")
            let imageview = UIImageView(gifImage: gif, loopCount: 1)
            imageview.frame = view.bounds
            view.addSubview(imageview)
            imageview.delegate = self
        } catch {
            print(error)
        }
    }

}

extension LaunchViewController: SwiftyGifDelegate {
    func gifDidStop(sender: UIImageView) {
        if isUserLogged {
            openTabbar()
        } else {
            openAuthorization()
        }
    }
    
    func openAuthorization() {
        let storyboard = UIStoryboard(name: "Authorization", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "OpeningScreenViewController")
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func openTabbar() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MainTabbarController")
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
}
