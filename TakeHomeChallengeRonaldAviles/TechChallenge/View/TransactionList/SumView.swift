//
//  SumView.swift
//  TechChallenge
//
//  Created by Ronald Aviles on 9/15/21.
//

import SwiftUI

struct SumView: View {
    
    @ObservedObject var viewModel: TransactionsViewModel
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Text(self.viewModel.selectedCategory?.rawValue ?? "all")
                    .foregroundColor(self.viewModel.selectedCategory?.color ?? .black)
            }
            .padding([.horizontal, .top], 15)
            HStack {
                Text("Total Spent:")
                    .secondary()
                Spacer()
                Text("$\(self.viewModel.sum.formatted())")
                
            }
            .padding([.horizontal, .bottom], 15)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 8.0)
                .stroke(Color.accentColor, lineWidth: 2)
        )
    }
    
}

struct SumView_Previews: PreviewProvider {
    static var previews: some View {
        SumView(viewModel: TransactionsViewModel())
            .previewLayout(.sizeThatFits)
    }
}
