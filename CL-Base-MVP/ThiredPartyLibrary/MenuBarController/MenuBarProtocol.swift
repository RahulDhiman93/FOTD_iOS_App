//
//  MenuBarProtocol.swift
//  TabBarContorller
//
//  Created by Hardeep Singh on 13/05/17.
//  Copyright © 2017 Hardeep Singh. All rights reserved.
//

import Foundation
import UIKit

protocol ViewLoadFromNib: class {
  static func nibName() -> String?
  static func loadViewFromNib() -> UIView?
}

extension ViewLoadFromNib {
  private static func loadNib(nibName: String!) -> UIView? {
    let loadedViews: [UIView]? = Bundle.main.loadNibNamed(nibName, owner: self, options: nil) as? [UIView]
    if loadedViews != nil {
      return loadedViews?.first
    } else {
      return nil
    }
  }
  static func loadViewFromNib() -> UIView? {
    return Self.loadNib(nibName: String(describing: Self.self))
  }
}

protocol MenuViewAble: class {
  var titleLabel: UILabel! {get set}
  var imageView: UIImageView! {get set}
  init(title: String?, image: UIImage?, tag: Int)
}

// MenuItemAble
protocol MenuItemAble: AnyObject {
}

private var ValidatableInterfaceElementRulesKey: UInt8 = 110
extension MenuItemAble {
  //Return item able
  var itemView: MenuViewAble? {
    get {
      return objc_getAssociatedObject(self, &ValidatableInterfaceElementRulesKey) as? MenuViewAble
    }
    set(newValue) {
      if let n = newValue {
        objc_setAssociatedObject(self, &ValidatableInterfaceElementRulesKey, n as AnyObject, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      }
    }
  }
}

