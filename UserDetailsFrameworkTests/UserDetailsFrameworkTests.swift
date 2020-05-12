//
//  UserDetailsFrameworkTests.swift
//  UserDetailsFrameworkTests
//
//  Created by Dadha Kumar on 11/5/20.
//  Copyright © 2020 Dadha Kumar. All rights reserved.
//

import XCTest
@testable import UserDetailsFramework

class UserDetailsFrameworkTests: XCTestCase {

    let fetchUserDetails = FetchUserDetails()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testExecuteUrlRequestMethod() {
        
        fetchUserDetails.executeUrlRequestMethod { (userInfo, error) in
            XCTAssertNil(error)
            guard let userInfoFetched = userInfo else {
                XCTFail()
                return
            }
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: userInfoFetched, options: [])
                let userInfoDecoded = try JSONDecoder().decode(UserDetailsResponse.self, from: jsonData)
                XCTAssertNotNil(userInfoDecoded)
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testExecuteUrlRequestMulUsers() {
                
        fetchUserDetails.executeUrlRequestMulUsers { (userInfo, error) in
                        XCTAssertNil(error)
            guard let userInfoFetched = userInfo else {
                XCTFail()
                return
            }
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: userInfoFetched, options: [])
                let userInfoDecoded = try JSONDecoder().decode(UserDetailsResponse.self, from: jsonData)
                XCTAssertNotNil(userInfoDecoded)
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
