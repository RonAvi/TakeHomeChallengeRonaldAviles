//
//  TransactionView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

struct TransactionView: View {
    @State var transaction: TransactionModel
    @State var isPinned: Bool
    
    @ObservedObject var viewModel: TransactionsViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text(transaction.category.rawValue)
                    .font(.headline)
                    .foregroundColor(transaction.category.color)
                Spacer()
                Button(action: {
                    self.viewModel.togglePin(transaction: self.transaction)
                    self.isPinned.toggle()
                }, label: {
                    Image(systemName: (self.isPinned) ? "pin.fill" : "pin.slash.fill" )
                })
            }
            
            if self.isPinned {
                HStack {
                    transaction.image
                        .resizable()
                        .frame(
                            width: 60.0,
                            height: 60.0,
                            alignment: .top
                        )
                    
                    VStack(alignment: .leading) {
                        Text(transaction.name)
                            .secondary()
                        Text(transaction.accountName)
                            .tertiary()
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("$\(transaction.amount.formatted())")
                            .bold()
                            .secondary()
                        Text(transaction.date.formatted)
                            .tertiary()
                    }
                }
            }
            

        }
        .padding(8.0)
        .background(Color.accentColor.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 8.0))
    }
}

#if DEBUG
struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TransactionView(transaction: ModelData.sampleTransactions[0], isPinned: true, viewModel: TransactionsViewModel())
            TransactionView(transaction: ModelData.sampleTransactions[1], isPinned: false, viewModel: TransactionsViewModel())
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
#endif
