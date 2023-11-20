import SwiftUI
import Firebase

class AppViewModel: ObservableObject {
    let auth = Auth.auth()
    @Published var isAuthenticated = false
    @Published var showSplash = true

    init() {
        auth.addStateDidChangeListener { [weak self] _, user in
            self?.isAuthenticated = user != nil
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {  //splash screen
                self?.showSplash = false
            }
        }
    }
}

struct ContentView: View {
    @StateObject var viewModel = AppViewModel()

    var body: some View {
        NavigationView {
            if viewModel.showSplash {
                SplashScreenView()
            } else {
                if viewModel.isAuthenticated {
                    ListofNotesView()
                        .navigationBarTitle("Your Notes", displayMode: .inline)
                        .navigationBarItems(trailing: Button("Sign Out") {
                            try? viewModel.auth.signOut()
                        })
                } else {
                    LoginView()
                        .navigationBarTitle("Login", displayMode: .inline)
                        .navigationBarItems(trailing: NavigationLink("Register", destination: RegisterView()))
                }
            }
        }
    }
}
