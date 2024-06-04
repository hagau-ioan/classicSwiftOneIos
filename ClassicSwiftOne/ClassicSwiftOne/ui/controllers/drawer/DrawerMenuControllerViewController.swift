//
//  DrawerMenuControllerViewController.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 03.06.2024.
//

import UIKit

class DrawerMenuControllerViewController: UIViewController {

    static let shared = DrawerMenuControllerViewController()
    
    let transitionManager = DrawerTransitionManager()
    
    var menuItems = [MenuItem]()
    
    var selectedItemMenuId: Int = 0
    
    private init() {
        super.init(nibName: nil, bundle: nil)
        //        // it's important to set presentation style to custom
        //        // because it allows us to modify the presentation later on
        modalPresentationStyle = .custom
        transitioningDelegate = transitionManager

        populateItems()
        createMenuItems()
    }
    
    override func viewDidLoad() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(dismissPresentedController))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
    }
    
    @objc private func dismissPresentedController() {
        transitionManager.dismiss()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(context: UIViewController?) {
        if let ctx = context {
            // using: present(...) is possible to display any viewController as a complex dialog modal or not.
            ctx.present(self, animated: true)
        }
    }
}

extension DrawerMenuControllerViewController: UITableViewDataSource, UITableViewDelegate  {
    
    func populateItems() {
        
        func selectItem(menuItem: MenuItem) {
            print("Do Something after the menu item \(menuItem.name) is selected")
        }
        
        menuItems.append(MenuItem(id: 1, name: "Menu Option 1", icon: "", selected: false, onClick: selectItem))
        menuItems.append(MenuItem(id: 2, name: "Menu Option 2", icon: "", selected: false, onClick: selectItem))
        menuItems.append(MenuItem(id: 3, name: "Menu Option 3", icon: "", selected: false, onClick: selectItem))
        menuItems.append(MenuItem(id: 4, name: "Menu Option 4", icon: "", selected: false, onClick: selectItem))
        menuItems.append(MenuItem(id: 5, name: "Menu Option 5", icon: "", selected: false, onClick: selectItem))
        
    }
    
    func toggleItem(id: Int, selected: Bool) {
        for (index, _) in menuItems.enumerated() {
            menuItems[index].setSelected(selected: selected)
        }
    }
    
    func findSelectedMenuItem() -> MenuItem? {
        for item in menuItems {
            if item.selected {
                return item
            }
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuItemList.identifier, for: indexPath) as! MenuItemList
        cell.setTitle(menuItems[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40 // height of the row, can be different from one row to another
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let thisCell = tableView.cellForRow(at: indexPath) {
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.green
            thisCell.selectedBackgroundView = bgColorView
            transitionManager.dismiss()
            if selectedItemMenuId > 0 {
                toggleItem(id: selectedItemMenuId, selected: false)
            }
            print("unselected: \(selectedItemMenuId)")
            selectedItemMenuId = menuItems[indexPath.row].id
            print("selected: \(selectedItemMenuId)")
            toggleItem(id: menuItems[indexPath.row].id, selected: true)
            menuItems[indexPath.row].onClick(menuItems[indexPath.row])
            
            
         }
    }
    
    func createMenuItems() {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(MenuItemList.self, forCellReuseIdentifier: MenuItemList.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = .zero // removing the left padding of table
        tableView.contentInset = .zero
        tableView.directionalLayoutMargins = .zero
        tableView.layoutMargins = .zero
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints  = false
        tableView.autoresizingMask = .flexibleWidth
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.trailingAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
   
}
