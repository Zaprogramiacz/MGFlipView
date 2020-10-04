public struct AnimationDescription {

  public init(type: AnimationType, duration: Double) {
    self.type = type
    self.duration = duration
  }

  let type: AnimationType
  let duration: Double

}

public extension AnimationDescription {

  static var `default`: AnimationDescription {
    .init(type: .linear, duration: 0.25)
  }

}
