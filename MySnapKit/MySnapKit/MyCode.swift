//
//  MyCode.swift
//  MySnapKit
//
//  Created by 刘菁楷 on 2020/11/9.
//

import Foundation
import UIKit

extension UIView {
    var snp: SNP {
        return SNP(view: self)
    }
}

public class SNP {
    
    private var view: UIView!
    
    init(view: UIView) {
        self.view = view
    }
    
    func makeConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        ConstraintMaker.makeConstraints(item: self.view, closure: closure)
    }
}

public class ConstraintItem {
    
    private var view: UIView
    private var attribute: NSLayoutConstraint.Attribute
    
    init(view: UIView, attribute: NSLayoutConstraint.Attribute) {
        self.view = view
        self.attribute = attribute
    }
    
    func equalToSuperview() {
        let c = NSLayoutConstraint(item: view, attribute: attribute, relatedBy: .equal, toItem: view.superview, attribute: attribute, multiplier: 1.0, constant: 0.0)
        self.view.superview!.addConstraint(c)
    }
    
    func equalTo(_ constant: CGFloat) {
        var c: NSLayoutConstraint
        switch attribute {
        case .height, .width:
            c = NSLayoutConstraint(item: view, attribute: attribute, relatedBy: .equal, toItem: view.superview, attribute: attribute, multiplier: 0.0, constant: constant)
        default:
            c = NSLayoutConstraint(item: view, attribute: attribute, relatedBy: .equal, toItem: view.superview, attribute: attribute, multiplier: 1.0, constant: constant)
        }
        self.view.superview!.addConstraint(c)
    }
    
    func equalTo(_ viewB: UIView) {
        let c = NSLayoutConstraint(item: view, attribute: attribute, relatedBy: .equal, toItem: viewB, attribute: attribute, multiplier: 1.0, constant: 0.0)
        self.view.superview!.addConstraint(c)
    }
    
}

public class ConstraintMaker {
    
    private var item: UIView
    
    init(item: UIView) {
        self.item = item
        item.translatesAutoresizingMaskIntoConstraints = false
    }

    public static func makeConstraints(item: UIView, closure: (_ make: ConstraintMaker) -> Void) {
        let maker = ConstraintMaker(item: item)
        closure(maker)
    }
    
    var leading: ConstraintItem {
        return ConstraintItem(view: self.item, attribute: .leading)
    }
    
    var trailing: ConstraintItem {
        return ConstraintItem(view: self.item, attribute: .trailing)
    }
    
    var top: ConstraintItem {
        return ConstraintItem(view: self.item, attribute: .top)
    }
    
    var bottom: ConstraintItem {
        return ConstraintItem(view: self.item, attribute: .bottom)
    }
    
    var height: ConstraintItem {
        return ConstraintItem(view: self.item, attribute: .height)
    }
    
    var width: ConstraintItem {
        return ConstraintItem(view: self.item, attribute: .width)
    }
    
    var centerX: ConstraintItem {
        return ConstraintItem(view: self.item, attribute: .centerX)
    }
    
    var centerY: ConstraintItem {
        return ConstraintItem(view: self.item, attribute: .centerY)
    }

}
