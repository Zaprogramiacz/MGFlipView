import SwiftUI
import MGFlipView

struct ContentView: View {

  @State var flipped = false

  var body: some View {
    FlipView(frontView: {
      Text("?")
        .foregroundColor(.white)
        .font(.system(size: 60))
        .frame(width: 80, height: 80)
        .background(Color.gray)
        .mask(Circle())
    }, backView: {
      Text("🕵🏻‍♂️")
        .font(.system(size: 60))
        .frame(width: 80, height: 80)
        .background(Color.yellow)
        .mask(Circle())
    }, flipped: $flipped)
    .onTapGesture {
      flipped.toggle()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
