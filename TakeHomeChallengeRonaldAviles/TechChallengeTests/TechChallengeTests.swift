//
//  TechChallengeTests.swift
//  TechChallengeTests
//
//  Created by Adrian Tineo Cabello on 30/7/21.
//

import XCTest
@testable import TechChallenge

class TechChallengeTests: XCTestCase {

    var viewModel: TransactionsViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.viewModel = TransactionsViewModel()
    }

    override func tearDownWithError() throws {
        self.viewModel = nil
        try super.tearDownWithError()
    }
    
    
    func testFilter() {
        // Food
        self.viewModel.filter(category: TransactionModel.Category.food)
        XCTAssertEqual(self.viewModel.transactions, SampleData.sampleFoodTransactions)
        
        // Health
        self.viewModel.filter(category: TransactionModel.Category.health)
        XCTAssertEqual(self.viewModel.transactions, SampleData.sampleHealthTransactions)
        
        // Entertainment
        self.viewModel.filter(category: TransactionModel.Category.entertainment)
        XCTAssertEqual(self.viewModel.transactions, SampleData.sampleEntertainmentTransactions)
        
        // Shopping
        self.viewModel.filter(category: TransactionModel.Category.shopping)
        XCTAssertEqual(self.viewModel.transactions, SampleData.sampleShoppingTransactions)
        
        // Travel
        self.viewModel.filter(category: TransactionModel.Category.travel)
        XCTAssertEqual(self.viewModel.transactions, SampleData.sampleTravelTransactions)
        
        // All
        self.viewModel.filter(category: nil)
        XCTAssertEqual(self.viewModel.transactions, SampleData.sampleAllTransactions)
        
    }
    
    func testSum() {
        // Food
        self.viewModel.filter(category: TransactionModel.Category.food)
        self.viewModel.calcSum()
        XCTAssertEqual(self.viewModel.sum.formatted(), "74.28")
        
        // Health
        self.viewModel.filter(category: TransactionModel.Category.health)
        self.viewModel.calcSum()
        XCTAssertEqual(self.viewModel.sum.formatted(), "21.53")
        
        // Entertainment
        self.viewModel.filter(category: TransactionModel.Category.entertainment)
        self.viewModel.calcSum()
        XCTAssertEqual(self.viewModel.sum.formatted(), "82.99")
        
        // Shopping
        self.viewModel.filter(category: TransactionModel.Category.shopping)
        self.viewModel.calcSum()
        XCTAssertEqual(self.viewModel.sum.formatted(), "78.00")
        
        // Travel
        self.viewModel.filter(category: TransactionModel.Category.travel)
        self.viewModel.calcSum()
        XCTAssertEqual(self.viewModel.sum.formatted(), "215.28")
        
        // All
        self.viewModel.filter(category: nil)
        self.viewModel.calcSum()
        XCTAssertEqual(self.viewModel.sum.formatted(), "472.08")
    }

}
