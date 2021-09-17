//
//  TransactionListView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

struct TransactionListView: View {
    @ObservedObject var viewModel: TransactionsViewModel
    
    var body: some View {
        VStack {
            TransactionFilterView(viewModel: self.viewModel)
            List {
                ForEach(self.viewModel.transactions) { transaction in
                    TransactionView(transaction: transaction, isPinned: self.viewModel.isPinned(transaction: transaction), viewModel: self.viewModel)
                }
            }
            .animation(.easeIn)
            .listStyle(PlainListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Transactions")
            
            SumView(viewModel: self.viewModel)
                .padding([.horizontal, .bottom], 10)
        }
        
    }
}

#if DEBUG
struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView(viewModel: TransactionsViewModel())
    }
}
#endif
