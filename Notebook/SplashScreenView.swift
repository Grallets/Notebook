import SwiftUI

struct SplashScreenView: View {
    
    @State private var isAnimating = false

    var body: some View {
        VStack {
            Image("splash")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
                .scaleEffect(isAnimating ? 1.3 : 1.0) // Zoom in and out
                .onAppear {
            
                    withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                        isAnimating = true
                    }
                }

            Text("The Notebook")
                .font(.largeTitle)
                .bold()
                .foregroundColor(Color.blue)
                .padding()
        }
        .padding()
        .background(Color.white)
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
