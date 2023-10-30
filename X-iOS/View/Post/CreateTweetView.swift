//
//  CreateTweetView.swift
//  X-iOS
//
//  Created by Anqi on 2023/10/15.
//

import SwiftUI

struct CreateTweetView: View {
    
    @State var text = ""
    @Binding var show: Bool
    @ObservedObject var viewModel = CreateTweetViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.show.toggle()
                }, label: {
                    Text("Cancel")
                })
                
                Spacer()
                
                Button(action: {
                    if text != "" {
                        self.viewModel.uploadPost(text: text)
                    }
                    self.show.toggle()
                }, label: {
                    Text("Tweet").padding()
                })
                .background(Color("bg"))
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
            
            MultilineTextField(text: $text)
        }
        .padding()
    }
}
