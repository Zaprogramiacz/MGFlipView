import SwiftUI
import MGFlipView

@main
struct IOSExampleApp: App {

  var body: some Scene {
    WindowGroup {
      ExampleView(itemSize: .init(width: 120, height: 120))
    }
  }

}

struct ExampleView: View {

  init(itemSize: CGSize) {
    self.itemSize = itemSize
  }

  let itemSize: CGSize

  @State var flipped: Bool = false

  var body: some View {
    VStack {
      HStack {
        flipView(flipAxis: .x, animationType: .easeIn)
        flipView(flipAxis: .y, animationType: .easeOut)
      }
      HStack {
        flipView(flipAxis: .xy, animationType: .easeInOut)
        flipView(flipAxis: .custom(x: 0.1, y: 0.5), animationType: .linear)
      }
      FlipView(frontView: {
        Text("?")
          .foregroundColor(.white)
          .font(.system(size: 30))
          .frame(width: itemSize.width, height: itemSize.height)
          .background(Color.gray)
          .mask(Circle())
      }, backView: {
        Image("1")
          .resizable()
          .frame(width: itemSize.width, height: itemSize.height)
          .mask(Circle())
      }, fliped: $flipped, animation: .init(type: .linear, duration: 0.25))
      Button(action: { flipped.toggle() }) {
        Text("Flip!")
      }
    }
  }

  func flipView(flipAxis: FlipAxis, animationType: AnimationType) -> some View {
    FlipView(frontView: { cardView(front: true, flipAxis: flipAxis, animationType: animationType) },
             backView: { cardView(front: false, flipAxis: flipAxis, animationType: animationType) },
             fliped: $flipped, flipAxis: flipAxis, animation: .init(type: animationType, duration: 2))
  }

  func cardView(front: Bool, flipAxis: FlipAxis, animationType: AnimationType) -> some View {
    var cardSide = front ? "Front\n" : "Back\n"
    cardSide += "axis: \(flipAxis.humanReadable)\n"
    cardSide += "anim: \(animationType.humanReadable)"

    return Text(cardSide)
      .frame(width: itemSize.width, height: itemSize.height)
      .background(Color.yellow)
      .cornerRadius(min(itemSize.width, itemSize.height) * 0.25)
  }

}

private extension FlipAxis {

  var humanReadable: String {
    switch self {
    case .x:
      return "x"
    case .y:
      return "y"
    case .xy:
      return "xy"
    case .custom(let x, let y):
      return "x:\(x),y:\(y)"
    }
  }

}

private extension AnimationType {

  var humanReadable: String {
    switch self {
    case .linear:
      return "linear"
    case .easeIn:
      return "easeIn"
    case .easeOut:
      return "easeOut"
    case .easeInOut:
      return "easeInOut"
    }
  }

}
