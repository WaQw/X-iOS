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
    @State var imagePickerPresented = false
    @State var selectedImage: UIImage?
    @State var postImage: Image?
    
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
            
            if postImage == nil { // Before selection: add button
                Button(action: {
                    self.imagePickerPresented.toggle()
                }, label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                        .clipped()
                        .padding(.top)
                        .foregroundColor(.black)
                })
                .sheet(isPresented: $imagePickerPresented) {
                    loadImage()
                } content: {
                    ImagePicker(image: $selectedImage)
                }
            } else if let image = postImage { // After selection: image preview
                VStack {
                    HStack(alignment: .top) {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: getRect().width * 0.9)
                            .padding(.horizontal)
                            .cornerRadius(16)
                            .clipped()
                    }
                    .padding()
                    
                    Spacer()
                }
            }
        }
        .padding()
    }
}

extension CreateTweetView {
    // Turn UIImage into SwiftUI Image
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        postImage = Image(uiImage: selectedImage)
    }
}
