//
//  SKCurveView.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 13.05.2023.
//

import Foundation
import UIKit


class SKCurveView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView(additionalViewBackgroundColor color: UIColor = .blue,
                   additionalViewFont font: UIFont = .systemFont(ofSize: 16, weight: .medium),
                   additionalViewText text: String = "1 day",
                   imageForShowing: UIImage? = nil) {
        let imageView = UIImageView(image: imageForShowing)
        imageView.frame = bounds
        imageView.contentMode = .scaleAspectFill
        
        let shapeLayer = CAShapeLayer()
        
        let freeform =  UIBezierPath()
        freeform.move(to: CGPoint(x: 0, y: 16))
        freeform.addLine(to: CGPoint(x: 0, y: 100))
        freeform.addArc(withCenter: CGPoint(x: 16, y: 116), radius: 16, startAngle: .pi, endAngle: CGFloat.pi/2, clockwise: false)
        freeform.addLine(to: CGPoint(x: 62, y: 132))
        freeform.addArc(withCenter: CGPoint(x: 69, y: 139), radius: 7, startAngle: 3*CGFloat.pi/2, endAngle: 0, clockwise: true)
        freeform.addLine(to: CGPoint(x: 76, y: 152))
        freeform.addArc(withCenter: CGPoint(x: 92, y: 152), radius: 16, startAngle: .pi, endAngle: CGFloat.pi/2, clockwise: false)
        freeform.addLine(to: CGPoint(x: 345-32, y: 178 - 10))
        freeform.addArc(withCenter: CGPoint(x: 345-16, y: 178-26), radius: 16, startAngle: .pi/2, endAngle: 0, clockwise: false)
        freeform.addLine(to: CGPoint(x: 345, y: 16))
        freeform.addArc(withCenter: CGPoint(x: 329, y: 16), radius: 16, startAngle: 0, endAngle: .pi*3/2, clockwise: false)
        freeform.addLine(to: CGPoint(x: 16, y: 0))
        freeform.addArc(withCenter: CGPoint(x: 16, y: 16), radius: 16, startAngle: .pi*3/2, endAngle: .pi, clockwise: false)
        
        shapeLayer.path = freeform.cgPath
        
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1.0
        shapeLayer.position = CGPoint(x: 0, y: 10)
        
        imageView.layer.mask = shapeLayer
        
        addSubview(imageView)
        
        let dayView = UIView(frame: CGRect(x: 0, y: 162-16, width: 64+8, height: 32))
        dayView.applyRadiusMaskFor(topLeft: 16, bottomLeft: 16, bottomRight: 16, topRight: 3)
        dayView.backgroundColor = color
        
        addSubview(dayView)
        
        let dayLabel = UILabel(frame: dayView.bounds)
        dayLabel.text = text
        dayLabel.textColor = .white
        dayLabel.textAlignment = .center
        dayLabel.font = font
        dayView.addSubview(dayLabel)
    }
    
    
}

extension UIView {
    func applyRadiusMaskFor(topLeft: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0, topRight: CGFloat = 0) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.width - topRight, y: 0))
        path.addLine(to: CGPoint(x: topLeft, y: 0))
        path.addQuadCurve(to: CGPoint(x: 0, y: topLeft), controlPoint: .zero)
        path.addLine(to: CGPoint(x: 0, y: bounds.height - bottomLeft))
        path.addQuadCurve(to: CGPoint(x: bottomLeft, y: bounds.height), controlPoint: CGPoint(x: 0, y: bounds.height))
        path.addLine(to: CGPoint(x: bounds.width - bottomRight, y: bounds.height))
        path.addQuadCurve(to: CGPoint(x: bounds.width, y: bounds.height - bottomRight), controlPoint: CGPoint(x: bounds.width, y: bounds.height))
        path.addLine(to: CGPoint(x: bounds.width, y: topRight))
        path.addQuadCurve(to: CGPoint(x: bounds.width - topRight, y: 0), controlPoint: CGPoint(x: bounds.width, y: 0))
        
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        layer.mask = shape
    }
}
