//
//  DetailsScreenViewController.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 22.04.2024.
//

import UIKit

class DetailsScreenViewController: UIViewController, UIScrollViewDelegate {
    
    static let identifier = "detailsScreen"
    
    var imageNameArg: ImageItem?  = nil
    
    var arg: ScreenDetailsArg? = nil
    
    // @Inject
    var viewModel: MainViewModel? = diUI.resolve(MainViewModel.self)
    
    private weak var writeBackValueDelegate: (any WriteValueBackDelegate)? = nil
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    func setArg(arg: ScreenDetailsArg) {
        self.arg = arg
    }
    
    func writeBackValueDelegate(_ writeBackValueDelegate: any WriteValueBackDelegate){
        self.writeBackValueDelegate = writeBackValueDelegate
    }
    
    override func viewDidLoad() {
        
        if let newArg = self.arg {
            imageNameArg = newArg.imageName
        }
        
        configureCurrentScreen()
        
        setupScreenDesign()
        
        print("\(#function) from \(String(describing: self))")
    }
    
    private func configureCurrentScreen() {
        title = String(localized: "SCREEN_DETAILS_TITLE")
        view.backgroundColor = .white
    }
    
    private func setupScreenDesign() {
        
        let uiTitle: UILabel = UILabel()
        let uiDescription: UILabel = UILabel()
        let picture = UIImageView()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        contentView.addSubview(uiTitle)
        contentView.addSubview(picture)
        contentView.addSubview(uiDescription)
        
        uiTitle.adjustsFontSizeToFitWidth = false
        uiTitle.numberOfLines = 0
        uiTitle.lineBreakMode = .byWordWrapping
        uiTitle.font = .systemFont(ofSize: 18, weight: .bold)
        uiTitle.textColor = .black
        uiTitle.textAlignment = .center
        uiTitle.translatesAutoresizingMaskIntoConstraints = false
        uiTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        uiTitle.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        uiTitle.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        picture.topAnchor.constraint(equalTo: uiTitle.bottomAnchor, constant: 20).isActive = true
        picture.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        picture.layer.masksToBounds = true
        picture.layer.borderWidth = 1
        picture.layer.borderColor = UIColor.black.cgColor
        picture.layer.cornerRadius = 5
        picture.translatesAutoresizingMaskIntoConstraints = false
        
        uiDescription.preferredMaxLayoutWidth = 180
        uiDescription.adjustsFontSizeToFitWidth = false
        uiDescription.numberOfLines = 0
        uiDescription.lineBreakMode = .byWordWrapping
        uiDescription.font = .systemFont(ofSize: 12, weight: .regular)
        uiDescription.textColor = .black
        uiDescription.textAlignment = .left
        uiDescription.translatesAutoresizingMaskIntoConstraints = false
        uiDescription.topAnchor.constraint(equalTo: picture.bottomAnchor).isActive = true
        uiDescription.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        uiDescription.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        if let t = imageNameArg {
            uiTitle.text = String(format: NSLocalizedString("DETAILS_IMAGE_TITLE", comment: ""), t.title)
    
            if(t.image != "") { // Loading the image from assets
                picture.image = UIImage(imageLiteralResourceName: t.image)
                picture.image = picture.image?.scale(newWidth: 300)
            }
            
            if(t.description != "") {
                uiDescription.text = t.description
            }
        } else {
            uiTitle.text = "Default title here"
            uiDescription.text = "No summary text."
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("\(#function) from \(String(describing: self))")
        // navigationController?.isNavigationBarHidden = true;
        navigationController?.navigationBar.tintColor = UIColor.green
        navigationController?.navigationBar.backgroundColor = .blue
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.red]
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        print("\(#function) from \(String(describing: self))")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("\(#function) from \(String(describing: self))")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("\(#function) from \(String(describing: self))")
        writeBackValueDelegate?.onWriteValueBack<String>("Value send back to the First Controler Screen")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("\(#function) from \(String(describing: self))")
    }
    
    override func viewDidLayoutSubviews() {
        print("\(#function) from \(String(describing: self))")
    }
    
    override func viewWillLayoutSubviews() {
        print("\(#function) from \(String(describing: self))")
    }
    
    override func didReceiveMemoryWarning() {
        print("\(#function) from \(String(describing: self))")
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print("\(#function) from \(String(describing: self))")
    }
    
    deinit {
        writeBackValueDelegate = nil
        print("deinit from \(String(describing: self))")
    }
}
