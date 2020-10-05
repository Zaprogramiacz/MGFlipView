import SwiftUI
import MGFlipView

struct ContentView: View {

  @State var flipped = false

  var body: some View {
    FlipView(frontView: {
      Text("?")
        .foregroundColor(.white)
        .font(.system(size: 30))
        .frame(width: 100, height: 100)
        .background(Color.gray)
        .mask(Circle())
    }, backView: {
      Text("🕵🏻‍♂️")
        .font(.system(size: 30))
        .frame(width: 100, height: 100)
        .background(Color.yellow)
        .mask(Circle())
    }, fliped: $flipped)
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
