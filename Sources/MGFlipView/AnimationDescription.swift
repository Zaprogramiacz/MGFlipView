public struct AnimationDescription {
  let type: AnimationType
  let duration: Double
}

public extension AnimationDescription {

  static var `default`: AnimationDescription {
    .init(type: .linear, duration: 0.25)
  }

}
