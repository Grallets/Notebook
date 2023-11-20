import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("The Notebook")
                .font(.largeTitle)
                .bold()
                .foregroundColor(Color.blue)
                .padding()
            TextField("Email", text: $email)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)

            SecureField("Password", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)

            Button("Login") {
                FirebaseManager.shared.loginUser(email: email, password: password) { success, error in
                    if success {
                        alertMessage = "Login successful!"
                        showingAlert = true
                    } else {
                        alertMessage = error ?? "error"
                        showingAlert = true
                    }
                }
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding()

            Spacer()
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Login"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .navigationBarTitle("Login", displayMode: .inline)
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(configuration.isPressed ? Color.blue.opacity(0.5) : Color.blue)
            .cornerRadius(8)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
