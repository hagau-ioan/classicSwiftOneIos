//
//  MainViewModel.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 23.04.2024.
//

import Foundation
import Combine

class MainViewModel: NSObject {
    
    private var loadDataTask: Task<Void, Error>?
    
    private var loadListDataServerTask: Task<Void, Error>?
    
    private var loadListUrlDataTask: URLSessionDataTask?
    
    @Published var dataLocalImages: DataLoadingState<ImageItem>? = DataLoadingState.NONE {
        didSet {
            // print("DID set: \(oldValue ?? [String]())")
        }
        willSet {
            // print("Will set: \(newValue ?? [String]())")
        }
    }
    
    @Published var postListServerFuture: DataLoadingState<ImageItem>? = DataLoadingState.NONE
    
    // @Inject
    private var postsUseCase: GetPostsUseCase? = nil
    
    private var imagesUseCase: GetImagesUseCase? = nil
    
    private var settings: GetUserSettingsUseCase? = nil
    
    private var keyChain: GetKeyChainPasswordUseCase? = nil
    
    private var userUsercase: GetUserUseCase? = nil
    
    init(
        postsUseCase: GetPostsUseCase?,
        imagesUseCase: GetImagesUseCase?,
        settings: GetUserSettingsUseCase?,
        keyChain: GetKeyChainPasswordUseCase?,
        userUsercase: GetUserUseCase?
    ) {
        self.postsUseCase = postsUseCase
        self.imagesUseCase = imagesUseCase
        self.settings = settings
        self.keyChain = keyChain
        self.userUsercase = userUsercase
    }
    
    
    //    Run multiple async requests in paralel.
    //    Task {
    //            async let firstImage = loadImage(index: 1)
    //            async let secondImage = loadImage(index: 2)
    //            async let thirdImage = loadImage(index: 3)
    //            let images = await [firstImage, secondImage, thirdImage] // paralel
    //        }
    //    Run multiple async call in sequence.
    //    Task {
    //            let firstImage = await loadImage(index: 1)
    //            let secondImage = await loadImage(index: 2)
    //            let thirdImage = await loadImage(index: 3)
    //            let images = [firstImage, secondImage, thirdImage] // Sequence
    //        }
    
    func loadData() {

        loadDataTask = Task {
            do {
                try await loadListOfImages()
            } catch {}
        }
        
        loadListDataServerTask = Task {
            do {
                try await loadRemoteListData()
            } catch {}
        }
    }
    
    func loadRemoteListData() async throws {
        postListServerFuture = DataLoadingState.LOADING
        postListServerFuture = await postsUseCase?.loadPosts().value
    }
    
    func loadListOfImages() async throws {
//        await TaskUtils.delay(seconds: 5)
        dataLocalImages = await imagesUseCase?.loadImages().value
    }
   
    /*
     * Running a test for "DefaultUser" type of storage
     */
    func testUserSettingsDefaults() {
        Task {
            await settings?.saveAccessTime(now: TimeUtils.getNow())
            let result = await settings?.getAccessTime() ?? 0
            if(result != 0) {
                print(TimeUtils.getFormatedDateSince1970(miliseconds: result))
            }
        }
    }
    
    /*
     * Test of storing an information like password encripted locally using keyChain
     */
    func testKeyChainStoreData() {
        Task {
            let isSaved = await keyChain?.savePassword(userName: "ihagau", password: "123456") ?? false
            if(isSaved) {
                let pass = await keyChain?.getPassword(userName: "ihagau") ?? ""
                print("The password found for user ihagau is \(pass)")
            }
            
        }
        
    }
    
    /*
     * Running a dummy test to see how the core data is working, some print information will be displayed in the log
     */
    func testUserUserCase() {
        Task {
            await userUsercase?.test()
        }
    }
    
    func onStop() {
        loadDataTask?.cancel()
        loadDataTask = nil
        loadListDataServerTask?.cancel()
        loadListDataServerTask = nil
    }
    
    /*
     * Used only for Unit testing POC
     */
    func methodForTestTask(value: Int) async -> Task<Int, Error> {
        Task {
            return value
        }
    }
    
    deinit {
        onStop()
    }
    
}

