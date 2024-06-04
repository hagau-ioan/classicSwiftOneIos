//
//  TableCell.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 18.04.2024.
//

import UIKit

class MenuItemList: UITableViewCell {
    
    static let identifier = "menuItemList"
    
    var title = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = SelectionStyle.blue
        //accessoryType = .none // Removing the default right arrow
        backgroundColor = .darkGray
        
        contentView.layoutMargins = .zero
        contentView.directionalLayoutMargins = .zero
        layoutMargins = .zero
        
        addSubview(title)
        configureTitle()
        setTitleConstraint()
      }
    
    // This rectangle with round border will adapt to the screen size in case of rotation
    override func layoutSubviews() {
        super.layoutSubviews()
        let verticalPadding: CGFloat = 8

        let maskLayer = CALayer()
        maskLayer.cornerRadius = 0    //if you want round edges
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.width, height: bounds.height).insetBy(
            dx: 10, dy: verticalPadding/2)
        layer.mask = maskLayer
    }
    
    func setTitleConstraint() {
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor,  constant: 20).isActive = true
        title.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor,  constant: -20).isActive = true
        title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        title.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
//        title.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        title.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func configureTitle() {

        
        title.adjustsFontSizeToFitWidth = false
        title.numberOfLines = 1
        title.lineBreakMode = .byTruncatingMiddle
        // title.preferredMaxLayoutWidth = 180
        
        title.font = .systemFont(ofSize: 18, weight: .bold)
        title.textAlignment = .center
        
        title.textColor = .white
    }
    
    func setTitle(_ title: String = "") {
        self.title.text = title
    }
    
    required init?(coder _: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
}
