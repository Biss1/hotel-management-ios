//
//  UIViewExtensions.swift
//  HotelManagement
//
//  Created by Bisera Belkoska on 11.11.17.
//  Copyright © 2017 Bisera Belkoska. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)![0] as! T
    }
    
    func addZeroHorizontalConstraintsToParent() {
        addZeroConstraintToParentWithAttribute(attribute: NSLayoutAttribute.leading)
        addZeroConstraintToParentWithAttribute(attribute: NSLayoutAttribute.trailing)
    }
    
    func addZeroConstraintToParentWithAttribute(attribute: NSLayoutAttribute) {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: attribute,
                                            relatedBy: NSLayoutRelation.equal,
                                            toItem: self.superview,
                                            attribute: attribute,
                                            multiplier: 1,
                                            constant: 0)
        self.superview?.addConstraint(constraint)
    }
    
    func addTopVerticalSpacingConstraint(toView: UIView, constant: CGFloat) {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: NSLayoutAttribute.top,
                                            relatedBy: NSLayoutRelation.equal,
                                            toItem: toView,
                                            attribute: NSLayoutAttribute.bottom,
                                            multiplier: 1,
                                            constant: constant)
        self.superview?.addConstraint(constraint)
    }
}

