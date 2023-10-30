//
//  WelcomeView.swift
//  X-iOS
//
//  Created by Anqi on 2023/10/21.
//

import SwiftUI

struct WelcomeView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer(minLength: 0)
                    Image("Twitter")
                        .resizable()
                        .scaledToFill()
                        .padding(.trailing)
                        .frame(width: 20, height: 20)
                    Spacer(minLength: 0)
                }
                
                Spacer(minLength: 0)
                
                Text("See what's happening in the world right now.")
                    .font(.system(size: 30, weight: .heavy, design: .default))
                    .frame(width: getRect().width * 0.9, alignment: .center)
                
                Spacer(minLength: 0)
                
                VStack(alignment: .center, spacing: 20, content: {
                    Button(action: {
                        
                    }, label: {
                        HStack(spacing: -1) {
                            Image("google")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                            Text("Continue with Google")
                                .foregroundColor(.black)
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding()
                        }
                        .overlay(content: {
                            RoundedRectangle(cornerRadius: 36)
                                .stroke(Color.black, lineWidth: 1)
                                .opacity(0.3)
                                .frame(width: 320, height: 60, alignment: .center)
                        })
                    })
                    
                    Button(action: {
                        
                    }, label: {
                        HStack(spacing: -1) {
                            Image("apple")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                            Text("Continue with Apple")
                                .foregroundColor(.black)
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding()
                        }
                        .overlay(content: {
                            RoundedRectangle(cornerRadius: 36)
                                .stroke(Color.black, lineWidth: 1)
                                .opacity(0.3)
                                .frame(width: 320, height: 60, alignment: .center)
                        })
                    })
                    
                    HStack {
                        Rectangle()
                            .foregroundColor(.gray)
                            .frame(width: getRect().width * 0.35, height: 1)
                            .opacity(0.5)
                        
                        Text("OR")
                            .foregroundColor(.gray)
                        
                        Rectangle()
                            .foregroundColor(.gray)
                            .frame(width: getRect().width * 0.35, height: 1)
                            .opacity(0.5)
                    }
                    
                    RoundedRectangle(cornerRadius: 36)
                        .frame(width: 320, height: 60, alignment: .center)
                        .foregroundColor(Color(red: 29/255, green: 161/255, blue: 242/255))
                        .overlay(
                            NavigationLink(destination: RegisterView().navigationBarHidden(true), label: {
                                Text("Create account")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding()
                            })
                        )
                })
                .padding()
                
                VStack {
                    VStack {
                        Text("By signing up, you agree to our ")
                        + Text("Terms")
                            .foregroundColor(Color(red: 29/255, green: 161/255, blue: 242/255))
                        + Text(",")
                        + Text(" Privacy Policy")
                            .foregroundColor(Color(red: 29/255, green: 161/255, blue: 242/255))
                        + Text(", Cookie Use")
                            .foregroundColor(Color(red: 29/255, green: 161/255, blue: 242/255))
                    }
                    .padding(.bottom, 7)
                    .frame(width: 350)
                    
                    HStack {
                        Text("Have an account already?")
                        NavigationLink(destination: LoginView().navigationBarHidden(true), label: {
                            Text("Log in")
                                .foregroundColor(Color(red: 29/255, green: 161/255, blue: 242/255))
                        })
                    }
                }
                    
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
