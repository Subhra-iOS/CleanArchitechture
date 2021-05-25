//
//  ItemListTests.swift
//  CleanArchitechtureTests
//
//  Created by Subhra Roy on 25/05/21.
//

import XCTest
@testable import CleanArchitechture

class ItemListTests: XCTestCase {
    var userData: UserDataModel!
    var listVC : ListViewController!
    var storyboard: UIStoryboard!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        userData = UserDataModel(_email: "subhra.roy@e-arc.com", _password: "", token: "AVGFYDE42167HJJEFJESWDGCXHKWWLL", userid: "123")
        storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        listVC = storyboard.instantiateViewController(identifier: "ListViewControllerIdentifier", creator: { (coder) -> ListViewController? in
            return ListViewController(coder: coder, user: self.userData)
        })
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        userData = nil
        listVC = nil
        storyboard = nil
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
    
    func test_UserExists(){
        XCTAssertEqual(userData.email, "subhra.roy@e-arc.com")
        XCTAssertEqual(userData.userToken, "AVGFYDE42167HJJEFJESWDGCXHKWWLL")
    }
    
    func test_generateList(){
        guard let service = listVC.fetchItemListWith(user: userData) else { return }
        service.loadItems(results: test_handleResults)
    }
    
    private func test_handleResults(_ list: [ListItemModel]?, _ error: Result) -> Void{
        switch error {
            case .success:
                let model = list?.last
                //TODO:---Test Fail------
                XCTAssertEqual(model, ListItemModel(itemTitle: "item22", itemDescription: "This is the new item5", itemId: "10422"))
                //TODO:----Test Success-------
                //XCTAssertNotEqual(model, ListItemModel(itemTitle: "item22", itemDescription: "This is the new item5", itemId: "10422"))
            case .failure(let message):
                XCTFail("Error message: \(message)")
        }
    }
}
