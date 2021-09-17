//
//  TransactionFilterView.swift
//  TechChallenge
//
//  Created by Ronald Aviles on 9/15/21.
//

import SwiftUI

struct TransactionFilterView: View {
    
    @ObservedObject var viewModel: TransactionsViewModel
    
    var body: some View {
        ScrollView(.horizontal, content: {
            HStack {
                Button(action: {
                    self.viewModel.filter(category: nil)
                }, label: {
                    Text("all")
                        .categroy(category: nil)
                })
                .cornerRadius(25.0)
                ForEach(TransactionModel.Category.allCases) { category in
                    Button(action: {
                        self.viewModel.filter(category: category)
                    }, label: {
                        Text(category.rawValue)
                            .categroy(category: category)
                    })
                    .cornerRadius(25.0)
                }
            }
            .padding()
        })
        .background(Color.accentColor)
        .opacity(0.8)
    }
}

struct TransactionFilterView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionFilterView(viewModel: TransactionsViewModel())
            .previewLayout(.sizeThatFits)
    }
}
