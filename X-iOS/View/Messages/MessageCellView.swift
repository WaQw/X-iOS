//
//  MessageCellView.swift
//  X-iOS
//
//  Created by Anqi on 2023/10/17.
//

import SwiftUI

struct MessageCellView: View {
    
    @State var width = UIScreen.main.bounds.width
    
    var body: some View {
        VStack(alignment: .leading, spacing: nil, content: {
            Rectangle()
                .frame(width: width, height: 1, alignment: .center)
                .foregroundColor(.gray)
                .opacity(0.3)
            
            HStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .cornerRadius(30)
                    .padding(.leading)
                
                VStack(alignment: .leading, spacing: 0, content: {
                    HStack {
                        Text("John ")
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        +
                        Text("@john")
                            .foregroundColor(.gray)
                        
                        Spacer(minLength: 0)
                        
                        Text("10/17/23")
                            .foregroundColor(.gray)
                            .padding(.trailing)
                    }
                    Text("Hey! How is it going?")
                        .foregroundColor(.gray)
                    Spacer()
                })
            }
            .padding(.top, 5)
        })
        .frame(width: width, height: 84)
    }
}

struct MessageCellView_Previews: PreviewProvider {
    static var previews: some View {
        MessageCellView()
    }
}
