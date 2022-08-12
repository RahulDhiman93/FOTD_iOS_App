//
//  MenuContainerViewController.swift
//  TabBarContorller
//
//  Created by cl-macmini-68 on 09/05/17.
//  Copyright © 2017 Hardeep Singh. All rights reserved.
//

import UIKit

typealias Index = Int

// TODO: pending
enum MenuBarPosition {
  case top
  case bottom
}

class MenuBarController: UIViewController {
  
  //TODO: pending
  var possition: MenuBarPosition = .bottom
  
  private var controllerStackView = UIStackView()
  fileprivate var containerView = UIView()
  fileprivate var menuBarView = MenuBarView()
  
  private var currentIndex: Index = 0
  final var selectedIndex: Index {
    get {
      return  currentIndex
    }
    set {
      if isViewLoaded {
        self.menuBarItemClick(item: nil, index: newValue)
      }
    }
  }
  
  private weak var selectedController: UIViewController? = nil
  var viewControllers: [UIViewController]? {
    didSet{
      self.updateMenuBarView()
    }
  }
  
  // Mark: - View Life Cycle
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(true)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    constrainViewEqual(holderView: self.view, view: self.controllerStackView)
    self.menuBarItemClick(item: nil, index: currentIndex)
    
    ///controllerStackView.translatesAutoresizingMaskIntoConstraints = false
    
  }
  
  override func loadView() {
    super.loadView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let controller = viewControllers, controller.count > 0 else {
      fatalError("MenuBarController: viewControllers array empty.")
    }
    
    //init StackView
    self.controllerStackView.axis = .vertical
    self.controllerStackView.alignment = .fill
    self.controllerStackView.distribution = .fill
    
    //Init StackView
    containerView.backgroundColor = UIColor.purple
    controllerStackView.addArrangedSubview(containerView)
    
    //MenuBarView
    controllerStackView.addArrangedSubview(menuBarView)
    self.view.addSubview(controllerStackView)
    menuBarView.menuBarViewActionCallBack = {(barItem: MenuBarItem, index: Index) in
      self.menuBarItemClick(item: barItem, index: index)
    }
    
  }
  
  // Mark: - update UI
  private func updateMenuBarView() {
    
    guard  let controllers = viewControllers else {
      return
    }
    
    for controller in controllers {
      if let item = controller.barMenuItem {
        self.menuBarView.add(newItem: item)
      }
    }
  }
  
  // Private functions
  private func menuBarItemClick(item: MenuBarItem?, index: Int) {
    //
    if currentIndex == index, let _ = selectedController {
      return
    }
    
    guard let controllers = viewControllers else {
      return
    }
    
    print("currentIndex--- \(currentIndex)")
    print("index--- \(index)")
    
    // WillUpdateItem..
    let currentController = controllers[currentIndex]
    let newController = controllers[index]
    
    currentController.barMenuItem?.isSelected = false
    newController.barMenuItem?.isSelected = true
    
    self.removeChildCotroller(childController: currentController)
    self.addChildController(childController: newController, onView: self.containerView)
    
    self.currentIndex = index
    self.selectedController = newController
    
  }
  
}

// Mark: - Get menu bar controller
private var MenuBarControllerItemKey: UInt8 = 1 // We still need this boilerplate
extension UIViewController {
  var menuBarController: MenuBarController? {
    get {
      return objc_getAssociatedObject(self, &MenuBarControllerItemKey) as? MenuBarController
    }
    set(newValue) {
      if let n = newValue {
        objc_setAssociatedObject(self, &MenuBarControllerItemKey, n as MenuBarController, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      }
    }
  }
}

//MARK: - TODO
extension UIViewController {
  
  fileprivate func removeChildCotroller(childController: UIViewController) {
    childController.willMove(toParent: nil)
    childController.view.removeFromSuperview()
    childController.removeFromParent()
  }
  
  fileprivate func addChildController(childController: UIViewController, onView: UIView?) {
    var holderView = self.view
    if let onView = onView {
      holderView = onView
    }
    addChild(childController)
    holderView?.addSubview(childController.view)
    constrainViewEqual(holderView: holderView!, view: childController.view)
    childController.didMove(toParent: self)
  }
  
  fileprivate func constrainViewEqual(holderView: UIView, view: UIView) {
    view.translatesAutoresizingMaskIntoConstraints = false
    let pinTop = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal,
                                    toItem: holderView, attribute: .top, multiplier: 1.0, constant: 0)
    let pinBottom = NSLayoutConstraint(item: view, attribute: .lastBaseline, relatedBy: .equal,
                                       toItem: holderView, attribute: .bottom, multiplier: 1.0, constant: 0)
    let pinLeft = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal,
                                     toItem: holderView, attribute: .left, multiplier: 1.0, constant: 0)
    let pinRight = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal,
                                      toItem: holderView, attribute: .right, multiplier: 1.0, constant: 0)
    holderView.addConstraints([pinTop, pinBottom, pinLeft, pinRight])
  }
  
}
