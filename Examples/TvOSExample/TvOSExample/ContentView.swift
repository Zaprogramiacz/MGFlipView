import SwiftUI
import MGFlipView

struct ContentView: View {

  @State var flipped = false

  var body: some View {
    VStack {
      FlipView(frontView: {
        Text("?")
          .foregroundColor(.white)
          .font(.system(size: 100))
          .frame(width: 150, height: 150)
          .background(Color.gray)
          .mask(Circle())
      }, backView: {
        Text("🕵🏻‍♂️")
          .font(.system(size: 100))
          .frame(width: 150, height: 150)
          .background(Color.yellow)
          .mask(Circle())
      }, flipped: $flipped)
    }
    Button(action: { flipped.toggle() }) {
      Text("Flip!")
    }
  }


}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
