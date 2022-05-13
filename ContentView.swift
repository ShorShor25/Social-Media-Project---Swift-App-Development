//
//  ContentView.swift
//  SocialMedia
//
//  Created by Shaurya Baranwal on 3/7/22.
//

import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject{
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func signUp(email: String, password: String){
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func signOut(){
        try? auth.signOut()
        self.signedIn = false
    }
}

struct ContentView: View {
    var messageArray: Array = ["Hello", "How are you doing?", "I've been having fun building a social media app!"]
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView{
            if viewModel.signedIn{
                VStack{
                    TItleRow()
                }.background(Color("Red"))
                
                ScrollView {
                    ForEach(messageArray, id: \.self) {
                        text in MessageBubble(message: Message(id: "12345", text: text, received: true, timestamp: Date()))
                    }
                }.padding(.top, 10).background(.white)
            }
            else{
                SignInView()
            }
        }.onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }.background(Color.gray)
    }
}

struct SignInView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        
        VStack{
            Image("logo").resizable().scaledToFit().frame(width: 150, height: 150)
            
            VStack{
                TextField("Email Address", text: $email).disableAutocorrection(true).autocapitalization(.none).padding().background(Color(.secondarySystemBackground))
                
                SecureField("Password", text: $password).padding().background(Color(.secondarySystemBackground))
                
                
                Button {
                    guard !email.isEmpty, !password.isEmpty else{
                        return
                    }
                    viewModel.signIn(email: email, password: password)
                } label: {
                    Text("Sign In").foregroundColor(Color.white).frame(width:200, height:50).background(Color.blue).cornerRadius(8.0)
                }
                NavigationLink("Create Account", destination: SignUpView()).padding()
            }
            .padding()
            Spacer()
        }
        .navigationTitle("Sign In")
        
    }
}

struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack{
            Image("logo").resizable().scaledToFit().frame(width: 150, height: 150)
            VStack{
                TextField("Email Address", text: $email).disableAutocorrection(true).autocapitalization(.none).padding().background(Color(.secondarySystemBackground))
                
                SecureField("Password", text: $password).padding().background(Color(.secondarySystemBackground))
                
                
                Button {
                    guard !email.isEmpty, !password.isEmpty else{
                        return
                    }
                    viewModel.signUp(email: email, password: password)
                } label: {
                    Text("Create Account").foregroundColor(Color.white).frame(width:200, height:50).background(Color.blue).cornerRadius(8.0)
                }
            }
            .padding()
            Spacer()
        }
        .navigationTitle("Create Account")
    }
}

struct WelcomeView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        
        VStack{
            Image("logo").resizable().scaledToFit().frame(width: 150, height: 150)
            Spacer()
            VStack{
                NavigationLink("Math", destination: MathView()).padding().background(Color(.secondarySystemBackground)).frame(width:200, height:50).cornerRadius(8.0)
                NavigationLink("Science", destination: ScienceView()).padding().background(Color(.secondarySystemBackground)).frame(width:200, height:50).cornerRadius(8.0)
                NavigationLink("English", destination: EnglishView()).padding().background(Color(.secondarySystemBackground)).frame(width:200, height:50).cornerRadius(8.0)
                NavigationLink("History", destination: HistoryView()).padding().background(Color(.secondarySystemBackground)).frame(width:200, height:50).cornerRadius(8.0)
                NavigationLink("Foreign Language", destination: ForeignLanguageView()).padding().background(Color(.secondarySystemBackground)).frame(width:200, height:50).cornerRadius(8.0)
                NavigationLink("Art", destination: ArtView()).padding().background(Color(.secondarySystemBackground)).frame(width:200, height:50).cornerRadius(8.0)
                NavigationLink("Music", destination: MusicView()).padding().background(Color(.secondarySystemBackground)).frame(width:200, height:50).cornerRadius(8.0)
                Button {
                    viewModel.signOut()
                } label: {
                    Text("Sign Out").frame(width: 200, height: 50 ).background(Color.gray).foregroundColor(Color.blue).cornerRadius(8.0).padding()
                }
            }.padding(.horizontal)
        }.padding()
        Spacer()
    }
}

struct MathView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        Text("This is the Math Server")
    }
}

struct ScienceView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        Text("This is the Science Server")
    }
}

struct EnglishView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        Text("This is the English Server")
    }
}

struct HistoryView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        Text("This is the History Server")
    }
}

struct ForeignLanguageView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        Text("This is the Foreign Language Server")
    }
}

struct ArtView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        Text("This is the Art Server")
    }
}

struct MusicView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        Text("This is the Music Server")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
