//
//  MenuView.swift
//  TabBarContorller
//
//  Created by Hardeep Singh on 09/05/17.
//  Copyright © 2017 Hardeep Singh. All rights reserved.
//

import UIKit

class MenuBarView: UIView {
  
  private var backGroundImageView: UIImageView?
  private var stackView: UIStackView?
  private(set) var barItems: [MenuBarItem] = []
  var menuBarViewActionCallBack: ((_ item: MenuBarItem, _ index: Int) -> Void)?
  
  // MARK: - init view
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setupStackView()
  }
  
  init() {
    super.init(frame: CGRect.zero)
    let height = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 49)
    self.addConstraint(height)
    self.setupStackView()
  }
  
  private func setupStackView() {
    stackView = UIStackView()
    self.stackView?.axis = .horizontal
    self.stackView?.alignment = .fill
    self.stackView?.spacing = 0.7
    self.stackView?.distribution = .fillEqually
    self.addSubview(stackView!)
    
    backGroundImageView = UIImageView()
    backGroundImageView?.backgroundColor = UIColor.lightGray
    self.addSubview(backGroundImageView!)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.stackView?.frame = self.bounds
  }
  
  // Mark: - Internal actions
  
  internal func insert(newItem: MenuBarItem, at: Index) {
    self.barItems.insert(newItem, at: at)
    if let view = newItem.itemView as? UIView {
      self.stackView?.insertArrangedSubview(view, at: at)
      self.addAction(item: newItem)
    }
  }
  
  internal func add(newItem: MenuBarItem) {
    self.barItems.append(newItem)
    if let view = newItem.itemView as? UIView {
      self.stackView?.addArrangedSubview(view)
      self.addAction(item: newItem)
    }
  }
  
  internal func remove(item: MenuBarItem) {
    
    if let index = self.barItems.index(of: item) {
      self.barItems.remove(at: index)
    }

    if let view = item.itemView as? UIView {
      item.setMenuItemClickedCallBack(callBack: nil)
      self.stackView?.removeArrangedSubview(view)
    }
    
  }
  
  func addAction(item: MenuBarItem) {
    item.setMenuItemClickedCallBack { (item: MenuBarItem, state: MenuBarItem.EventState) in
      /// When any item clicked.
      if state == .didPress {
        self.menuBarViewItemClick(item: item, state: state)
      }
    }
  }
  
  private func menuBarViewItemClick(item: MenuBarItem, state: MenuBarItem.EventState) {
    if let index = self.barItems.index(of: item), state == .didPress {
      self.menuBarViewActionCallBack?(item, index)
    }
  }
  
}
