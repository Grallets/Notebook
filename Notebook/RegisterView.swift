import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
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

            Button("Register") {
                FirebaseManager.shared.registerUser(email: email, password: password) { success, error in
                    if success {
                        alertMessage = "Registration successful!"
                        showingAlert = true
                    } else {
                        alertMessage = error ?? "An unknown error occurred"
                        showingAlert = true
                    }
                }
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding()

            Spacer()
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Registration"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .navigationBarTitle("Register", displayMode: .inline)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
