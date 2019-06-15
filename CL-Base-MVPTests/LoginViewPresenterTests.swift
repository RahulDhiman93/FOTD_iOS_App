//
//  LoginViewPresenterTests.swift
//  CL-Base-MVPTests
//
//  Created by cl-lap-147 on 02/01/18.
//  Copyright © 2018 Deepak. All rights reserved.
//

import XCTest
@testable import CL_Base_MVP

class LoginViewPresenterTests: XCTestCase {
    var presenter: LoginViewPresenterImplementation?
    
    override func setUp() {
        super.setUp()
        self.presenter = LoginViewPresenterImplementation(view: LoginViewController())
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
       // self.measure {
            // Put the code you want to measure the time of here.
//        }
    }
    
    func testEmail() {
        presenter?.replace(string: "deepak", section: .email)
        if let error = presenter?.isAllDataValid() {
            XCTAssertEqual(error, TextFieldError.emailInvalid)
        }
    }
    
    func testCharacter() {
        presenter?.shouldChange(text: "1234444", string: "we", index: IndexPath(item: 0, section: 0 ))
        
    }
    func testPassword() {
        presenter?.replace(string: "Deepak@gmail.com", section: .email)
        presenter?.replace(string: "asdfwe", section: .password)
        if let error = presenter?.isAllDataValid() {
            XCTAssertEqual(error, TextFieldError.passwordInvalid)
        }
    }
    
    func testValidateField() {
       
    }
    
    
}
