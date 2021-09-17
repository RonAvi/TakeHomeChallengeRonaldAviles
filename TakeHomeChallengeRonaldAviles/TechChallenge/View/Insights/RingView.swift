//
//  RingView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 29/7/21.
//

import SwiftUI

fileprivate typealias Category = TransactionModel.Category

struct RingView: View {
    
    @ObservedObject var viewModel: TransactionsViewModel
        
    private func ratio(for category: TransactionModel.Category) -> Double {
        
        let categoryTotal = self.viewModel.calcSum(per: category)
        let pinnedTotal = self.viewModel.pinnedSum
        
        return categoryTotal / pinnedTotal
    }
    
    private func offset(for category: TransactionModel.Category) -> Double {
        
        var offSet = 0.0
        for element in Category.allCases {
            if element == category {
                break
            }
            offSet += self.ratio(for: element)
        }
        
        return offSet
    }

    private func gradient(for category: TransactionModel.Category) -> AngularGradient {
        let color = category.color
        return AngularGradient(
            gradient: Gradient(colors: [color.unsaturated, color]),
            center: .center,
            startAngle: .init(
                offset: offset(for: category),
                ratio: 0
            ),
            endAngle: .init(
                offset: offset(for: category),
                ratio: ratio(for: category)
            )
        )
    }
    
    private func percentageText(for category: TransactionModel.Category) -> String {
        "\((ratio(for: category) * 100).formatted(hasDecimals: false))%"
    }
    
    var body: some View {
        ZStack {
            ForEach(Category.allCases) { category in
                if self.ratio(for: category) > 0.0 {
                    PartialCircleShape(
                        offset: offset(for: category),
                        ratio: ratio(for: category)
                    )
                    .stroke(
                        gradient(for: category),
                        style: StrokeStyle(lineWidth: 28.0, lineCap: .butt)
                    )
                    .overlay(
                        PercentageText(
                            offset: offset(for: category),
                            ratio: ratio(for: category),
                            text: percentageText(for: category)
                        )
                    )
                }
                
            }
        }
    }
}

extension RingView {
    struct PartialCircleShape: Shape {
        let offset: Double
        let ratio: Double
        
        func path(in rect: CGRect) -> Path {
            Path(offset: offset, ratio: ratio, in: rect)
        }
    }
    
    struct PercentageText: View {
        let offset: Double
        let ratio: Double
        let text: String
        
        private func position(for geometry: GeometryProxy) -> CGPoint {
            let rect = geometry.frame(in: .local)
            let path = Path(offset: offset, ratio: ratio / 2.0, in: rect)
            return path.currentPoint ?? .zero
        }
        
        var body: some View {
            GeometryReader { geometry in
                Text(text)
                    .percentage()
                    .position(position(for: geometry))
            }
        }
    }
}

#if DEBUG
struct RingView_Previews: PreviewProvider {
    static var sampleRing: some View {
        ZStack {
            RingView.PartialCircleShape(offset: 0.0, ratio: 0.15)
                .stroke(
                    Color.red,
                    style: StrokeStyle(lineWidth: 28.0, lineCap: .butt)
                )
            
            RingView.PartialCircleShape(offset: 0.15, ratio: 0.5)
                .stroke(
                    Color.green,
                    style: StrokeStyle(lineWidth: 28.0, lineCap: .butt)
                )
                
            RingView.PartialCircleShape(offset: 0.65, ratio: 0.35)
                .stroke(
                    Color.blue,
                    style: StrokeStyle(lineWidth: 28.0, lineCap: .butt)
                )
        }
    }
    
    static var previews: some View {
        VStack {
            sampleRing
                .scaledToFit()
            
            RingView(viewModel: TransactionsViewModel())
                .scaledToFit()
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
#endif
