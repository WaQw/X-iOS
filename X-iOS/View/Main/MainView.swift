//
//  MainView.swift
//  X-iOS
//
//  Created by Anqi on 2023/10/17.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            TopBar()
            Home()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
