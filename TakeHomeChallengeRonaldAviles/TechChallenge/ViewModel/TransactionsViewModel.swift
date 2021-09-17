//
//  TransactionsViewModel.swift
//  TechChallenge
//
//  Created by Ronald Aviles on 9/15/21.
//

import Combine

class TransactionsViewModel: ObservableObject {
    
    @Published var transactions: [TransactionModel] = ModelData.sampleTransactions {
        didSet {
            self.calcSum()
        }
    }
    @Published var selectedCategory: TransactionModel.Category? = nil
    @Published var sum: Double = ModelData.sampleTransactions.reduce(0.0) { (sum, transaction) in
        return sum + transaction.amount
    }
    var pinnedTransactions = Set<TransactionModel>(ModelData.sampleTransactions) {
        didSet {
            self.calcSum()
        }
    }
    
    func filter(category: TransactionModel.Category?) {
        self.selectedCategory = category
        
        guard let category = category else {
            self.transactions = ModelData.sampleTransactions
            return
        }
        
        self.transactions = ModelData.sampleTransactions.filter { model in
            return model.category == category
        }
    }
    
    
    
    func calcSum() {
        self.sum = self.transactions.reduce(0.0) { (sum, transaction) in
            return sum + ((self.isPinned(transaction: transaction)) ? transaction.amount : 0.0)
        }
    }
    
    func calcSum(per category: TransactionModel.Category) -> Double {
        return ModelData.sampleTransactions.reduce(0.0) { sum, transaction in
            return sum + ((transaction.category == category && isPinned(transaction: transaction)) ? transaction.amount : 0.0)
        }
    }
    
    var pinnedSum: Double {
        return self.pinnedTransactions.reduce(0.0) { sum, transaction in
            return sum + transaction.amount
        }
    }
    
    
    func togglePin(transaction: TransactionModel) {
        if self.pinnedTransactions.contains(transaction) {
            self.pinnedTransactions.remove(transaction)
        } else {
            self.pinnedTransactions.insert(transaction)
        }
    }
    
    func isPinned(transaction: TransactionModel) -> Bool {
        return self.pinnedTransactions.contains(transaction)
    }
        
    
}
