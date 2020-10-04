import SwiftUI

public struct FlipView<Content: View>: View {

  public init(@ViewBuilder frontView: @escaping () -> Content,
              @ViewBuilder backView: @escaping () -> Content,
                           fliped: Binding<Bool>,
                           flipAxis: FlipAxis = .x,
                           animation: AnimationDescription = .default) {
    self.frontView = frontView
    self.backView = backView
    self._fliped = fliped
    self.flipAxis = flipAxis
    self.animation = animation
  }

  let frontView: () -> Content
  let backView: () -> Content
  let flipAxis: FlipAxis
  let animation: AnimationDescription

  @Binding var fliped: Bool

  public var body: some View {
    ZStack {
      frontView()
        .rotation3DEffect(.init(radians: fliped ? (.pi / 2) : 0), axis: flipAxis.value)
        .animation(animation.type.front(duration: animation.duration / 2).delay(fliped ? 0 : animation.duration / 2))
      backView()
        .rotation3DEffect(.init(radians: fliped ? 0 : -.pi / 2), axis: flipAxis.value)
        .animation(animation.type.back(duration: animation.duration / 2).delay(fliped ? animation.duration / 2 : 0))
    }
  }

}

private extension AnimationType {

  func front(duration: Double) -> Animation {
    switch self {
    case .linear, .easeOut:
      return .linear(duration: duration)
    case .easeIn, .easeInOut:
      return .easeIn(duration: duration)
    }
  }

  func back(duration: Double) -> Animation {
    switch self {
    case .linear, .easeIn:
      return .linear(duration: duration)
    case .easeOut, .easeInOut:
      return .easeOut(duration: duration)
    }
  }

}

private extension FlipAxis {

  var value: (x: CGFloat, y: CGFloat, z: CGFloat) {
    switch self {
    case .x:
      return (x: 1, y: 0, z: 0)
    case .y:
      return (x: 0, y: 1, z: 0)
    case .xy:
      return (x: 1, y: 1, z: 0)
    case .custom(let x, let y):
      return (x: x, y: y, z: 0)
    }
  }

}
