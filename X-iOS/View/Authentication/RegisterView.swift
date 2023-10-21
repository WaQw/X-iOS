//
//  RegisterView.swift
//  X-iOS
//
//  Created by Anqi on 2023/10/21.
//

import SwiftUI

struct RegisterView: View {
    
    @State var name = ""
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Button(action: {
                        
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(.blue)
                    })
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                Image("Twitter")
                    .resizable()
                    .scaledToFill()
                    .padding(.trailing)
                    .frame(width: 20, height: 20)
            }
            
            Text("Create your account")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 50)
            
            Spacer()
            
            VStack {
                CustomAuthTextField(placeholder: "Name", text: $name)
                    .padding(.bottom)
                    .padding(.top, -20)
                CustomAuthTextField(placeholder: "Email", text: $email)
                    .padding(.bottom)
                SecureAuthTextField(placeholder: "Password", text: $password)
            }
            
            Spacer()
            
            VStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                
                HStack {
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        Capsule()
                            .frame(width: 60, height: 30, alignment: .center)
                            .foregroundColor(Color("bg"))
                            .overlay(
                                Text("Next")
                                    .foregroundColor(.white)
                            )
                    })
                }
                .padding(.trailing, 24)
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
