//
//  SearchView.swift
//  X-iOS
//
//  Created by Anqi on 2023/10/15.
//

import SwiftUI

struct SearchView: View {
    
    @State var text = ""
    @State var isEditing = false
    
    var body: some View {
        VStack {
            SearchBar(text: $text, isEditing: $isEditing)
                .padding(.horizontal)
            
            if !isEditing {
                List(0..<9) { i in
                    SearchCellView(tag: "spider", tweetsNum: String(i))
                }
            } else {
                List(0..<9) { _ in
                    SearchUserCellView()
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
