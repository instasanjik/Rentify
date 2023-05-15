//
//  UIView.swift
//  Sleepmate
//
//  Created by Sanzhar Koshkarbayev on 21.01.2023.
//

import UIKit
import SnapKit

extension UIView {
    
    func shake(duration: Float = 0.6, force: Float = 20) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = CFTimeInterval(duration)
        animation.values = [-force, force, -force, force, -force/2, force/2, -force/4, force/4, 0]
        layer.add(animation, forKey: "shake")
    }
    
    func showLoading(style: UIActivityIndicatorView.Style = .large) {
        self.subviews.forEach({ $0.isHidden = true })
        let loadingView = UIActivityIndicatorView()
        loadingView.startAnimating()
        loadingView.hidesWhenStopped = true
        loadingView.style = style
        Logger.log(.success, "Loading started")
        self.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func hideLoading() {
        Logger.log(.success, "Loading stopped")
        allSubViewsOf(type: UIActivityIndicatorView.self).forEach({ $0.removeFromSuperview() })
        self.subviews.forEach({ $0.isHidden = false })
    }
    
    func allSubViewsOf<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        func getSubview(view: UIView) {
            if let aView = view as? T{
                all.append(aView)
            }
            guard view.subviews.count>0 else { return }
            view.subviews.forEach{ getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }
    
}
