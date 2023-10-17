//
//  SearchCellView.swift
//  X-iOS
//
//  Created by Anqi on 2023/10/16.
//

import SwiftUI

struct SearchCellView: View {
    
    var tag = ""
    var tweetsNum = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Spider-Man 2").fontWeight(.bold)
            Text(tweetsNum + " posts").fontWeight(.light)
        }
    }
}

struct SearchCellView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCellView()
    }
}
