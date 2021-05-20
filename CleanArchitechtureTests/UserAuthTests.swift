//
//  UserAuthTests.swift
//  CleanArchitechtureTests
//
//  Created by Subhra Roy on 20/05/21.
//

import XCTest
@testable import CleanArchitechture

class UserAuthTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
    
    func test_authenticateUserSuccess(){
        var userData: UserDataModel = UserDataModel(_email: "subhra.roy@e-arc.com", _password: "123456")
        let expect = expectation(description: "Auth success service")
        let homeViewModel: HomeViewModel = HomeViewModel(authModel: AuthModel(email: "", pwd: "")) {
            if userData.authenticationSucceed() {
                XCTAssertEqual(userData.userToken, "AVGFYDE42167HJJEFJESWDGCXHKWWLL")
            }else{
                XCTAssertNotNil(userData.userToken)
            }
            expect.fulfill()
        }
        homeViewModel.serverAuthenticationWith(user: userData, completion: {  (userModel) in
            userData.update(user: userModel)
            homeViewModel.authSuccess()
        })
        
        waitForExpectations(timeout: 1.0) { (error) in
            
        }
    }
    
    func test_authenticateUserFail(){
        var userData: UserDataModel = UserDataModel(_email: "", _password: "")
        
        let expect = expectation(description: "Auth fail service")
        let homeViewModel: HomeViewModel = HomeViewModel(authModel: AuthModel(email: "", pwd: "")) {
            if userData.authenticationSucceed() {
                XCTAssertEqual(userData.userToken, "AVGFYDE42167HJJEFJESWDGCXHKWWLL")
            }else{
                XCTAssertNil(userData.userToken)
            }
            expect.fulfill()
        }
        homeViewModel.serverAuthenticationWith(user: userData, completion: {  (userModel) in
            userData.update(user: userModel)
            homeViewModel.authSuccess()
        })
        
        waitForExpectations(timeout: 1.0) { (error) in
            
        }
    }
}
