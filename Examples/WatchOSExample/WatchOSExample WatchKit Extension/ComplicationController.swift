import ClockKit

class ComplicationController: NSObject, CLKComplicationDataSource {

  func getComplicationDescriptors(handler: @escaping ([CLKComplicationDescriptor]) -> Void) {
    let descriptors = [
      CLKComplicationDescriptor(
        identifier: "complication",
        displayName: "WatchOSExample",
        supportedFamilies: CLKComplicationFamily.allCases
      )
    ]

    handler(descriptors)
  }

  func handleSharedComplicationDescriptors(_ complicationDescriptors: [CLKComplicationDescriptor]) {

  }

  func getTimelineEndDate(for complication: CLKComplication,
                          withHandler handler: @escaping (Date?) -> Void) {
    handler(nil)
  }

  func getPrivacyBehavior(for complication: CLKComplication,
                          withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
    handler(.showOnLockScreen)
  }

  func getCurrentTimelineEntry(for complication: CLKComplication,
                               withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
    handler(nil)
  }

  func getTimelineEntries(for complication: CLKComplication,
                          after date: Date,
                          limit: Int,
                          withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
    handler(nil)
  }

  func getLocalizableSampleTemplate(for complication: CLKComplication,
                                    withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
    handler(nil)
  }
}
