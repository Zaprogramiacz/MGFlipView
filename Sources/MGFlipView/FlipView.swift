import SwiftUI

public struct FlipView<ContentFront: View, ContentBack: View>: View {

  public init(@ViewBuilder frontView: @escaping () -> ContentFront,
              @ViewBuilder backView: @escaping () -> ContentBack,
                           fliped: Binding<Bool>,
                           flipAxis: FlipAxis = .x,
                           animation: AnimationDescription = .default) {
    self.frontView = frontView
    self.backView = backView
    self._fliped = fliped
    self.flipAxis = flipAxis
    self.animation = animation
  }

  let frontView: () -> ContentFront
  let backView: () -> ContentBack
  let flipAxis: FlipAxis
  let animation: AnimationDescription

  @Binding var fliped: Bool

  public var body: some View {
    ZStack {
      frontView()
        .rotation3DEffect(.init(radians: fliped ? (.pi / 2).closeValue : 0.closeValue), axis: flipAxis.value)
        .animation(
          animation.type.front(duration: animation.duration / 2, reversed: !fliped)
            .delay(fliped ? 0 : animation.duration / 2)
        )
      backView()
        .rotation3DEffect(.init(radians: fliped ? 0.closeValue : (-.pi / 2).closeValue), axis: flipAxis.value)
        .animation(
         animation.type.back(duration: animation.duration / 2, reversed: !fliped)
          .delay(fliped ? animation.duration / 2 : 0)
        )
    }
  }

}

private extension AnimationType {

  func front(duration: Double, reversed: Bool) -> Animation {
    switch self {
    case .linear:
      return .linear(duration: duration)
    case .easeOut:
      return reversed ? .easeOut(duration: duration) : .linear(duration: duration)
    case .easeIn:
      return reversed ? .linear(duration: duration) : .easeIn(duration: duration)
    case .easeInOut:
      return reversed ? .easeOut(duration: duration) : .easeIn(duration: duration)
    }
  }

  func back(duration: Double, reversed: Bool) -> Animation {
    switch self {
    case .linear:
      return .linear(duration: duration)
    case .easeIn:
      return reversed ? .easeIn(duration: duration) : .linear(duration: duration)
    case .easeOut:
      return reversed ? .linear(duration: duration) : .easeOut(duration: duration)
    case .easeInOut:
      return reversed ? .easeIn(duration: duration) : .easeOut(duration: duration)
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

private extension Double {

  var closeValue: Double {
    self - pow(10, -6)
  }

}
