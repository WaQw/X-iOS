//
//  LoginView.swift
//  X-iOS
//
//  Created by Anqi on 2023/10/21.
//

import SwiftUI

struct LoginView: View {
    
    @State var email = ""
    @State var password = ""
    @State var emailDone = false
    
    var body: some View {
        if !emailDone {
            VStack {
                VStack {
                    ZStack { // to ensure icon is in the center
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
                    
                    Text("To get started, first enter your phone, email, or @username")
                        .fontWeight(.heavy)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding(.top, 30)
                    
                    CustomAuthTextField(placeholder: "Phone, email, or username", text: $email)
                }
                
                Spacer()
                
                VStack {
                    Button(action: {
                        self.emailDone.toggle()
                    }, label: {
                        Capsule()
                            .frame(width: 360, height: 40, alignment: .center)
                            .foregroundColor(Color("bg"))
                            .overlay(Text("Next").foregroundColor(.white))
                    })
                    .padding(.bottom, 4)
                    
                    Text("Forgot Password")
                        .foregroundColor(.blue)
                }
            }
        } else {
            VStack {
                VStack {
                    ZStack { // to ensure icon is in the center
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
                    
                    Text("Enter your password")
                        .fontWeight(.heavy)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding(.top, 30)
                    
                    SecureAuthTextField(placeholder: "Password", text: $password)
                }
                
                Spacer()
                
                VStack {
                    Button(action: {
                        self.emailDone.toggle()
                    }, label: {
                        Capsule()
                            .frame(width: 360, height: 40, alignment: .center)
                            .foregroundColor(Color("bg"))
                            .overlay(Text("Login").foregroundColor(.white))
                    })
                    .padding(.bottom, 4)
                    
                    Text("Forgot Password")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
