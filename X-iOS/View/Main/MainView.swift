//
//  MainView.swift
//  X-iOS
//
//  Created by Anqi on 2023/10/17.
//

import SwiftUI

struct MainView: View {
    
    let user: User
    @State var width = UIScreen.main.bounds.width - 90
    @State var x = -UIScreen.main.bounds.width + 90
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                    VStack() {
                        TopBar(x: $x)
                        Home(user: user)
                    }
                    .offset(x: x + width)
                    
                    SlideMenu()
                        .shadow(color: Color.black.opacity(x == 0 ? 0 : 0.1), radius: 5, x: 5, y: 0)
                        .offset(x: x) // for open and hide the menu
                        .background(Color.black.opacity(x == 0 ? 0.5 : 0))
                        .ignoresSafeArea(.all, edges: .vertical)
                        .onTapGesture { // hide the menu
                            withAnimation{
                                x = -width
                            }
                        }
                })
                .gesture(DragGesture().onChanged({ (value) in
                    withAnimation {
                        if value.translation.width > 0 { // drag to the right
                            if x < 0 {
                                x = value.translation.width - width
                            }
                        } else { // drag to the left
                            if x != -width {
                                x = value.translation.width
                            }
                        }
                    }
                }).onEnded({ (value) in
                    withAnimation {
                        if -x < width / 2 { // drag more than half
                            x = 0
                        } else { // drag less than half
                            x = -width
                        }
                    }
                }))
            }
        }
    }
}
