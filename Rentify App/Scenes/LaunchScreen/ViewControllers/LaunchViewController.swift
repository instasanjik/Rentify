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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let storyboard = UIStoryboard(name: "Authorization", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "OpeningScreenViewController")
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
