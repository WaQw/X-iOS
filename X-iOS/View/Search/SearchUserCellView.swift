//
//  SearchUserCellView.swift
//  X-iOS
//
//  Created by Anqi on 2023/10/16.
//

import SwiftUI

struct SearchUserCellView: View {
    var body: some View {
        HStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text("John")
                    .fontWeight(.heavy)
                Text("@john")
            }
            
            Spacer(minLength: 0)
        }
    }
}

struct SearchUserCellView_Previews: PreviewProvider {
    static var previews: some View {
        SearchUserCellView()
    }
}
