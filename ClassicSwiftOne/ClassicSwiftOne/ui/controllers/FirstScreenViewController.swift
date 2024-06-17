//
//  ViewController.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 15.04.2024.
//

import UIKit
import Combine

class FirstScreenViewController: UIViewController, WriteValueBackDelegate {
    
    typealias T = String

    var pictures = [ImageItem]()
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let labelHead = UILabel(frame: .zero)
    
    // @Inject
    var viewModel: MainViewModel? = nil
    
    var cancelable: AnyCancellable? = nil
    
    var cancelablePosts: AnyCancellable? = nil
    
    var monitorCancelable: AnyCancellable? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureCurrentScreen()
        
        setupScreenDesign()
        
        // exampleTextTranslation()
        
        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChange),
                    name: UIDevice.orientationDidChangeNotification, object: nil)
        
        print("\(#function) from \(String(describing: self))")
        
        cancelable = viewModel?.$dataLocalImages.sink{ receiveValue in
            let data = receiveValue ?? DataLoadingState.ERROR(errorCode: DataLoadingErrorCode.UNKNOWN_ERROR)
            self.handleLoadedItems(data: data)
        }
        
        cancelablePosts = viewModel?.$postListServerFuture.sink { receiveValue in
            let data = receiveValue ?? DataLoadingState.ERROR(errorCode: DataLoadingErrorCode.UNKNOWN_ERROR)
            self.handleLoadedItems(data: data)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        viewModel?.loadData()
        
//        viewModel?.testUserSettingsDefaults()
//        viewModel?.testKeyChainStoreData()
        viewModel?.testUserUserCase()
        triggerNetworkConnection()
        
        let blt = BluetoothScanService()
        blt.start()

        addHamburgerMenu()
        
    }
    
    func addHamburgerMenu() {
        // let leftButton =  UIBarButtonItem(title: "Left Button", style: UIBarButtonItem.Style.plain, target: self, action: nil)
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(self.toggleDrawer))
        navigationItem.leftItemsSupplementBackButton = true // Can be added beside back button
        navigationItem.leftBarButtonItem = leftButton
        // navigationItem.leftItemsSupplementBackButton = true // to add BACK button beside other buttons
        // navigationItem.leftBarButtonItems = [] // To add multiple buttons in the top toolbar
    }
    
    @objc private func toggleDrawer() {
        let drawerController = DrawerMenuControllerViewController.shared
        weak var thisSelf = self
        drawerController.show(context: thisSelf)
    }
    
    /*
     * Observe any network change. Can be injected using DI
     */
    func triggerNetworkConnection() {
        let monitor = NetworkMonitor()
        monitorCancelable = monitor.objectWillChange.sink { _ in
            print("Network changed and is: \(monitor.isConnected)")
        }
    }
    
    private func handleLoadedItems(data: DataLoadingState<ImageItem>) {
        var titles = [ImageItem]()
        switch data {
        case .ERROR(let errorCode):
            print("ERROR \(errorCode)")
        case .LOADING:
            print("LOADING")
        case .SUCCESS(let dataLoading):
            dataLoading.data.forEach { item in
                titles.append(item)
            }
            self.pictures += titles
        case .NONE:
            print("NONE")
        }
    }
    
    /*
     Receive back a value from the child Controller opened from this controller.
     */
    func onWriteValueBack<String>(_ data: String) {
        print("onWriteValueBack \(data)")
    }
    
    private func configureCurrentScreen() {
        title = String(localized: "SCREEN_HOME")
        view.backgroundColor = .white
    }
    
    private func setupScreenDesign() {
        view.addSubview(labelHead)
        labelHead.text = String(localized: "HOME_SCREEN_TITLE_TBL")
        labelHead.textColor = .red
        labelHead.insetsLayoutMarginsFromSafeArea = true
        labelHead.textAlignment = .center
        labelHead.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        labelHead.layer.backgroundColor = UIColor.black.withAlphaComponent(0.14).cgColor
        labelHead.layer.cornerRadius = 5
        
        
//        let insets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//        labelHead.inse
        
        labelHead.translatesAutoresizingMaskIntoConstraints = false
        // This is posionning the label in the extreme top edge of the screen.
//        labelHead.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        labelHead.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        labelHead.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
//        labelHead.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        labelHead.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        
        
        view.addSubview(tableView)
        tableView.register(TableCell.self, forCellReuseIdentifier: TableCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = .zero // removing the left padding of table
        tableView.contentInset = .zero
        tableView.directionalLayoutMargins = .zero
        tableView.layoutMargins = .zero
        
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 100 // Set a reasonable estimate
        
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.topAnchor.constraint(equalTo: labelHead.bottomAnchor).isActive = true
//        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        
        // Another approch of applying the constraints
        tableView.translatesAutoresizingMaskIntoConstraints  = false
        tableView.autoresizingMask = .flexibleWidth
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: labelHead.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.trailingAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    private func exampleTextTranslation() {
        let text = String(localized: "TITLE")
        let desc = String(format: NSLocalizedString("DESC", comment: ""), 100)
        print(text + " :: " + desc)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("\(#function) from \(String(describing: self))")
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        print("\(#function) from \(String(describing: self))")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("\(#function) from \(String(describing: self))")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("\(#function) from \(String(describing: self))")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("\(#function) from \(String(describing: self))")
    }
    
    override func viewDidLayoutSubviews() {
        print("\(#function) from \(String(describing: self))")
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillLayoutSubviews() {
        print("\(#function) from \(String(describing: self))")

    }
    
    override func didReceiveMemoryWarning() {
        print("\(#function) from \(String(describing: self))")
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
      super.willTransition(to: newCollection, with: coordinator)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print("\(#function) from \(String(describing: self))")
    }
    
    @objc func orientationDidChange(_ notification: Notification) {
        let currentOrientation = UIDevice.current.orientation
        switch currentOrientation {
            case .portrait, .portraitUpsideDown:
                print("isPortrait \(currentOrientation.isPortrait)")
            case .landscapeLeft, .landscapeRight:
                print("isLandscape \(currentOrientation.isLandscape)")
            default:
                break
        }
    }
    
    deinit {
        print("deinit from \(String(describing: self))")
        cancelable?.cancel()
        cancelable = nil
        cancelablePosts?.cancel()
        cancelablePosts = nil
        monitorCancelable?.cancel()
        monitorCancelable = nil
        viewModel?.onStop()
    }
    
}
extension FirstScreenViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {        
        return pictures.count
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let thisCell = tableView.cellForRow(at: indexPath) {
            (thisCell as! TableCell).title.textColor = .black
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let thisCell = tableView.cellForRow(at: indexPath) {
            (thisCell as! TableCell).title.textColor = .orange
            
            let verticalPadding: CGFloat = 8

            let maskLayer = CALayer()
            maskLayer.cornerRadius = 10    //if you want round edges
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.frame = CGRect(x: thisCell.bounds.origin.x, y: thisCell.bounds.origin.y, width: thisCell.bounds.width, height: thisCell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
            thisCell.layer.mask = maskLayer
            thisCell.backgroundColor = .cyan
            
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.green
            thisCell.selectedBackgroundView = bgColorView
        }
        
        ScreenNavigation.shared.openDetailsScreen(
            navigationController: navigationController,
            picture: pictures[indexPath.row],
            writeBackValueDelegate: self
        )
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40 // height of the row, can be different from one row to another
    }
    
    /**
            Table content set
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.identifier, for: indexPath) as! TableCell
        cell.setTitle(pictures[indexPath.row].title)
        return cell
    }
}

