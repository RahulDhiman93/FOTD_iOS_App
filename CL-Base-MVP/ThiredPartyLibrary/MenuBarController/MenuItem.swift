//
//  MenuItem.swift
//  TabBarContorller
//
//  Created by Hardeep Singh on 09/05/17.
//  Copyright © 2017 Hardeep Singh. All rights reserved.
//

import UIKit
import ObjectiveC

// Item Detail structs.
struct ItemContent<ViewType: MenuViewAble> {
  typealias InputType = ViewType
  var title: String?
  var image: UIImage?
  var selectedImg: UIImage?
}

class MenuBarItem: MenuItemAble {
  
  var title: String?
  var image: UIImage?
  var selectedImage: UIImage?
  var isSelected = false {
    didSet {
      if isSelected {
        showHighlightLayer()
      }else {
        hideHighlightLayer()
      }
    }
  }
  
  private var view: MenuViewAble?
  
//  init<ViewType: MenuViewAble>(item: ItemContent<ViewType>) {
//    
//    title = item.title
//    image = item.image
//    selectedImage = item.selectedImg
//    
//    if let NibType = ViewType.self as? ViewLoadFromNib.Type,
//      let nibView = NibType.loadViewFromNib(),
//      let menuViewAble = nibView as? MenuViewAble {
//      itemView = menuViewAble
//    }else {
//      itemView = ViewType(title: "", image: nil, tag: 0)
//    }
//    
//    itemView?.titleLabel.text = title
//    itemView?.imageView.image = image
//    self.addAction(actionView: itemView!)
//    
//  }
  
  // Mark: Private actions.
  enum EventState {
    case didPress
    case highlight
    case unhighlight
  }
  
 private var menuItemClickedCallBack: ((_ item: MenuBarItem, _ state: EventState ) -> ())?
 internal func setMenuItemClickedCallBack(callBack: ((_ item: MenuBarItem, _ state: EventState) -> Void)?) {
    menuItemClickedCallBack = callBack
  }
  
  private func addAction(actionView: MenuViewAble) {
    if let actionController = actionView as? UIControl {
      actionController.addTarget(self, action: #selector(MenuBarItem.didPress), for: .touchUpInside)
      actionController.addTarget(self, action: #selector(MenuBarItem.highlight), for: [
        .touchDown,
        .touchDragEnter])
      actionController.addTarget(self, action: #selector(MenuBarItem.unhighlight), for: [
        .touchUpInside,
        .touchUpOutside,
        .touchCancel,
        .touchDragExit])
    }
  }
  
  @objc private func didPress() {
    self.menuItemClickedCallBack?(self, .didPress)
  }
  
  @objc private func highlight() {
    self.menuItemClickedCallBack?(self, .highlight)
  }
  
  @objc private func unhighlight() {
    self.menuItemClickedCallBack?(self, .unhighlight)
  }

  // Selected effect 
  private var highlightLayer: CALayer?
  private func showHighlightLayer() {
    guard let view = itemView as? UIControl  else {
      return
    }
    
    self.hideHighlightLayer()
    
    let highlightLayer = CALayer()
    highlightLayer.frame = view.layer.bounds
    highlightLayer.backgroundColor = UIColor.black.cgColor
    highlightLayer.opacity = 0.5
    var maskImage: UIImage? = nil
    UIGraphicsBeginImageContextWithOptions(view.layer.bounds.size, false, 0)
    if let context = UIGraphicsGetCurrentContext() {
      view.layer.render(in: context)
      maskImage = UIGraphicsGetImageFromCurrentImageContext()
    }
    UIGraphicsEndImageContext()
    let maskLayer = CALayer()
    maskLayer.contents = maskImage?.cgImage
    maskLayer.frame = highlightLayer.frame
    highlightLayer.mask = maskLayer
    view.layer.addSublayer(highlightLayer)
    self.highlightLayer = highlightLayer
    print("-----> \(view.bounds)")
  }
  
  private func hideHighlightLayer() {
      highlightLayer?.removeFromSuperlayer()
      highlightLayer = nil
  }
  
  func layoutBarItemIfNeeded() {
    guard let view = itemView as? UIControl  else {
      return
    }
    print("-----> \(view.bounds)")
  }
  
}

extension MenuBarItem: Equatable {
  static func == (lhs: MenuBarItem, rhs: MenuBarItem) -> Bool {
    return (lhs.title == rhs.title
      && lhs.image == rhs.image
      && lhs.selectedImage == rhs.selectedImage)
  }
}

//
// Menu bar item
//
private var MenuBarItemElementRulesKey: UInt8 = 110
extension UIViewController {
  var barMenuItem: MenuBarItem? {
    get {
      return objc_getAssociatedObject(self, &MenuBarItemElementRulesKey) as? MenuBarItem
    }
    set(newValue) {
      if let n = newValue {
        objc_setAssociatedObject(self, &MenuBarItemElementRulesKey, n as MenuBarItem, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      } else {
      }
    }
  }
}




