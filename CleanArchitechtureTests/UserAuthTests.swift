//
//  UserAuthTests.swift
//  CleanArchitechtureTests
//
//  Created by Subhra Roy on 20/05/21.
//

import XCTest
@testable import CleanArchitechture

class UserAuthTests: XCTestCase {
    var _viewController: ViewController!
    var homeViewModel: HomeViewModel!
    var service: AuthServiceProtocol?
    var userData: UserDataModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        _viewController = nil
        homeViewModel = nil
        service = nil
        userData = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_Create_AuthModel_Success(){
        let userAuth: AuthModel = AuthModel(email: "subhra.roy@e-arc.com", pwd: "123456")
        userAuth.getUserEmail({ (email) in
            XCTAssertEqual(email, "subhra.roy@e-arc.com")
        })
        
        userAuth.getUserPassword({ (password) in
            XCTAssertEqual(password, "123456")
        })
    }
    
    func test_Create_AuthModel_Fail(){
        let userAuth: AuthModel = AuthModel(email: "subhra.roy@e-arc", pwd: "12345")
        userAuth.getUserEmail({ (email) in
            XCTAssertEqual(email, "")
        })
        
        userAuth.getUserPassword({ (password) in
            XCTAssertEqual(password, "")
        })
    }
    
    func test_CreatUserDataModel_Success(){
        let userDataModel = UserDataModel(_email: "subhra.roy@e-arc.com", _password: "", token: "AVGFYDE42167HJJEFJESWDGCXHKWWLL", userid: "123")
        if userDataModel.authenticationSucceed(){
            XCTAssert(true)
        }else{
            XCTAssert(false)
        }
    }
    
    func test_CreatUserDataModel_Fail(){
        let userDataModel = UserDataModel(_email: "subhra.roy@e-arc.com", _password: "", token: nil, userid: nil)
        if !userDataModel.authenticationSucceed(){
            XCTAssertNil(userDataModel.userToken)
        }else{
            XCTAssertFalse(true)
        }
    }
    
    func test_UserDataModel_Update(){
        var userDataModel1 = UserDataModel(_email: "subhra.roy@e-arc.com", _password: "", token: nil, userid: nil)
        let userDataModel2 = UserDataModel(_email: "subhra.roy@e-arc.com", _password: "", token: "AVGFYDE42167HJJEFJESWDGCXHKWWLL", userid: "123")
        userDataModel1.update(user: userDataModel2)
        XCTAssertEqual(userDataModel1.userToken, "AVGFYDE42167HJJEFJESWDGCXHKWWLL", "User has been updated")
        XCTAssertEqual(userDataModel1.userID, "123", "User has been updated")
    }
    
    func test_authUserSuccess(){
        let userAuth: AuthModel = AuthModel(email: "subhra.roy@e-arc.com", pwd: "123456")
        self.homeViewModel = HomeViewModel(authModel: userAuth, success: { (user) in
            self.userData = user
            let expect : XCTestExpectation = XCTestExpectation(description: "Auth success service")
            self.test_authenticateUserSuccess(self.userData, expect)
        })
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        _viewController = storyboard.instantiateViewController(identifier: "RootViewControllerIdentifier", creator: { (coder) -> ViewController? in
            return ViewController(coder: coder, viewModel: self.homeViewModel)
        })
    }
    
    private func test_authenticateUserSuccess(_ user: UserDataModel, _ expectation: XCTestExpectation){
               
        if user.authenticationSucceed() {
            XCTAssertEqual(user.userToken, "AVGFYDE42167HJJEFJESWDGCXHKWWLL")
        } else  {
            XCTAssertNotNil(user.userToken)
        }
        expectation.fulfill()
        self.service = _viewController.triggerAuthService(user: user)
        guard let adapterService = self.service else {
            return
        }
        adapterService.authenticate(handler: self.testhandlerResult)
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_authenticateUserFail(){
        let userAuth: AuthModel = AuthModel(email: "", pwd: "")
        self.homeViewModel = HomeViewModel(authModel: userAuth, success: { (user) in
            self.userData = user
            let expect : XCTestExpectation = XCTestExpectation(description: "Auth fail service")
            self.test_AuthFail(self.userData, expect)
        })
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        _viewController = storyboard.instantiateViewController(identifier: "RootViewControllerIdentifier", creator: { (coder) -> ViewController? in
            return ViewController(coder: coder, viewModel: self.homeViewModel)
        })
    }
    
   private func test_AuthFail(_ user: UserDataModel, _ expectation: XCTestExpectation){
        
        /*var statusCode: Int?
        var responseError: Error?
        */
    
        if user.authenticationSucceed() {
            XCTAssertEqual(user.userToken, "AVGFYDE42167HJJEFJESWDGCXHKWWLL")
        } else  {
            XCTAssertNil(user.userToken)
        }
        expectation.fulfill()
        self.service = _viewController.triggerAuthService(user: user)
        guard let adapterService = self.service else {
            return
        }
        adapterService.authenticate(handler: self.testhandlerResult)
        wait(for: [expectation], timeout: 2.0)

        //For actual server call once status code received
       // XCTAssertNil(responseError)
       // XCTAssertEqual(statusCode, 200)
    }
    
    private func testhandlerResult(_ userModel: UserDataModel?) -> Void{
        if let result = userModel{
            userData.update(user: result)
            homeViewModel.authSuccess(self.userData)
        }else{
            XCTFail("Error in server call")
        }
    }
}
