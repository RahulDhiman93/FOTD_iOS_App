//
//  CLView+Extension.swift
//  CLApp
//
//  Created by Hardeep Singh on 12/4/16.
//  Copyright © 2016 Hardeep Singh. All rights reserved.
//

import Foundation
import UIKit

//Extension UIWindow
public extension UIWindow {
  
  public var visibleViewController: UIViewController? {
    return UIWindow.getVisibleViewControllerFrom(viewController: self.rootViewController)
  }
  
  public static func getVisibleViewControllerFrom(viewController: UIViewController?) -> UIViewController? {
    if let navViewController = viewController as? UINavigationController {
      return UIWindow.getVisibleViewControllerFrom(viewController: navViewController.visibleViewController)
    } else if let tabBarViewController = viewController as? UITabBarController {
      return UIWindow.getVisibleViewControllerFrom(viewController: tabBarViewController.selectedViewController)
    } else {
      if let presentViewController = viewController?.presentedViewController {
        return UIWindow.getVisibleViewControllerFrom(viewController: presentViewController)
      } else {
        return viewController
      }
    }
  }
  
}

extension UILabel {
//  open override class func initialize() {
//    // make sure this isn't a subclass
//    print("*********>>>> UILabel")
//    guard self === UILabel.self else {
//      print("*********>>>> guard self === UILabel.self else")
//      return
//    }
//  }
}

// MARK: -
extension UIView {
  
  class func loadNib(nibName: String!) -> UIView? {
    let loadedViews: [UIView]? = Bundle.main.loadNibNamed(nibName, owner: self, options: nil) as? [UIView]
    if loadedViews != nil {
      return loadedViews?.first
    } else {
      return nil
    }
  }
  
  class func loadNib() -> UIView? {
    return UIView.loadNib(nibName: String(describing: UIView.self))
  }
  
  func border(width: CGFloat, color: UIColor, radius: CGFloat) {
    self.layer.borderWidth = width
    self.layer.borderColor = color.cgColor
    self.layer.cornerRadius = radius
  }
  
}

extension  UITextField {
  
  func placeHolderColor(color: UIColor!) {
    if let placeholder = self.placeholder {
        let attriStr =  NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: color])
      self.attributedPlaceholder = attriStr
    }
  }
}

// MARK: - TableView
extension  UITableView {
  
  func indexPathForSubView(subview: UIView) -> IndexPath {
    if let superview = subview.superview {
      let location: CGPoint = superview.convert(subview.center, to: self)
      if let indexPath = self.indexPathForRow(at: location) {
        return indexPath
      }
    }
    
    fatalError("UITableView:- Not able find index path for row location")
    
  }
  
  func hideLastCellLine() {
    let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
    view.backgroundColor = UIColor.clear
    self.tableFooterView = view
  }
  
  func scrollEnableOnlyForExtraContent() {
    if self.contentSize.height > self.frame.size.height {
      self.isScrollEnabled = true
    } else {
      self.isScrollEnabled = false
    }
  }
  
  func registerCell(_ nibName: String, identifier: String = "", bundle: Bundle? = nil ) {
    var identifier = identifier
    if identifier.isEmpty {
      identifier = nibName
    }
    let nib: UINib = UINib(nibName: nibName, bundle: bundle)
    self.register(nib, forCellReuseIdentifier: identifier)
  }
  
  func registerHeaderFooter(_ nibName: String, identifier: String = "", bundle: Bundle? = nil ) {
    var identifier = identifier
    if identifier.isEmpty {
      identifier = nibName
    }
    let nib: UINib = UINib(nibName: nibName, bundle: bundle)
    self.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
  }
  
}
