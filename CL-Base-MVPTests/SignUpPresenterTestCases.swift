//
//  SignUpPresenterTestCases.swift
//  CL-Base-MVPTests
//
//  Created by cl-lap-147 on 02/01/18.
//  Copyright © 2018 Deepak. All rights reserved.
//

import XCTest
@testable import CL_Base_MVP

class SignUpPresenterTestCases: XCTestCase {
    var presenter: SignUpViewPresenterImplementation?
    
    override func setUp() {
        super.setUp()
        self.presenter = SignUpViewPresenterImplementation(view: SignUpViewController())
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
        //}
    }
    
    func testFirstName() {
        presenter?.replace(string: " ", section: .firstName)
        if let error = presenter?.isAllDataValid() {
            XCTAssertEqual(error, TextFieldError.firstNameEmpty)
        }
    }
    
    func testLastName() {
        presenter?.replace(string: "Deepak", section: .firstName)
        presenter?.replace(string: " ", section: .lastName)
        if let error = presenter?.isAllDataValid() {
            XCTAssertEqual(error, TextFieldError.lastNameEmpty)
        }
    }
    
    func testEmailAddress() {
        presenter?.replace(string: "Deepak", section: .firstName)
        presenter?.replace(string: "Sharma", section: .lastName)
        presenter?.replace(string: "deepak.com", section: .email)
        if let error = presenter?.isAllDataValid() {
            XCTAssertEqual(error, TextFieldError.emailInvalid)
        }
    }
    func testUserName() {
        presenter?.replace(string: "Deepak", section: .firstName)
        presenter?.replace(string: "Sharma", section: .lastName)
        presenter?.replace(string: "deepak@test.com", section: .email)
        presenter?.replace(string: "8765655454545", section: .phoneNumber)
        presenter?.replace(string: " ", section: .username)
        if let error = presenter?.isAllDataValid() {
            XCTAssertEqual(error, TextFieldError.userNameEmpty)
        }
    }
    func testPhoneNumber() {
        presenter?.replace(string: "Deepak", section: .firstName)
        presenter?.replace(string: "Sharma", section: .lastName)
        presenter?.replace(string: "deepak@test.com", section: .email)
        presenter?.replace(string: "Deepak Sharma", section: .username)
        presenter?.replace(string: " ", section: .phoneNumber)
        if let error = presenter?.isAllDataValid() {
            XCTAssertEqual(error, TextFieldError.phoneNumberEmpty)
        }
    }
    
    func testPassword() {
        presenter?.replace(string: "Deepak", section: .firstName)
        presenter?.replace(string: "Sharma", section: .lastName)
        presenter?.replace(string: "deepak@test.com", section: .email)
        presenter?.replace(string: "89898989888", section: .phoneNumber)
        presenter?.replace(string: "Deepak Sharma", section: .username)
        presenter?.replace(string: " ", section: .password)
        if let error = presenter?.isAllDataValid() {
            XCTAssertEqual(error, TextFieldError.passwordEmpty)
        }
    }
}
