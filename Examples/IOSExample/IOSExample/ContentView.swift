import SwiftUI

struct ContentView: View {
  var body: some View {
    GameView(itemSize: .init(width: 70, height: 70), fontSize: 20)
  }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
#endif

struct Offset: Identifiable {
  let id = UUID()
  let x: CGFloat
  let y: CGFloat
}

struct GameView: View {

  init(itemSize: CGSize, fontSize: CGFloat) {
    self.itemSize = itemSize
    self.fontSize = fontSize
  }

  let itemSize: CGSize
  let fontSize: CGFloat

  var body: some View {
    GeometryReader { geometry in
      ForEach(generateOffsets(width: geometry.size.width, height: geometry.size.height)) { offset in
        ItemView(itemSize: itemSize, fontSize: 20, emoji: allEmojis.first!)
          .offset(x: offset.x, y: offset.y)
      }
    }.padding()
  }

  func generateOffsets(width: CGFloat, height: CGFloat) -> [Offset] {
    let numberOfColumns = Int(width / itemSize.width)
    let numberOfRows = Int(height / itemSize.height)
    var numberOfItems = numberOfColumns * numberOfRows
    numberOfItems = numberOfItems % 2 == 0 ? numberOfItems : numberOfItems - 1

    let horizaontalSpacing = width / (CGFloat(numberOfColumns) * itemSize.width)
    let verticalSpacing = height / (CGFloat(numberOfRows) * itemSize.height)

    let startSpacingColumn = (width - (CGFloat(numberOfColumns) * itemSize.width + CGFloat(max(numberOfColumns, numberOfColumns - 1)) * horizaontalSpacing)) / 2
    let startSpacingRow = (height - (CGFloat(numberOfRows) * itemSize.height + CGFloat(max(numberOfRows, numberOfRows - 1)) * verticalSpacing)) / 2

    var offsets: [Offset] = []

    for column in 0..<numberOfColumns {
      for row in 0..<numberOfRows {
        if numberOfItems - 1 >= offsets.count {
          let offsetX = (CGFloat(column) * itemSize.width + CGFloat(max(column, column - 1)) * horizaontalSpacing) + startSpacingColumn
          let offsetY = CGFloat(row) * itemSize.height + CGFloat(max(row, row - 1)) * verticalSpacing + startSpacingRow
          offsets.append(.init(x: offsetX, y: offsetY))
        }
      }
    }

    return offsets
  }

}

import MGFlipView

struct ItemView: View {

  init(itemSize: CGSize, fontSize: CGFloat, emoji: Character) {
    self.itemSize = itemSize
    self.fontSize = fontSize
    self.emoji = emoji
  }

  let itemSize: CGSize
  let fontSize: CGFloat
  let emoji: Character

  @State var flipped = false

  var body: some View {
    FlipView(frontView: {
      Color.yellow
        .frame(width: itemSize.width, height: itemSize.height)
        .cornerRadius(min(itemSize.height, itemSize.width) * 0.25)
    }, backView: {
      Text(String(emoji))
        .font(.system(size: fontSize))
        .frame(width: itemSize.width, height: itemSize.height)
        .background(Color.yellow)
        .cornerRadius(min(itemSize.height, itemSize.width) * 0.25)
    }, fliped: $flipped)
      .onTapGesture {
        flipped.toggle()
      }
  }

}

let allEmojis = "🧳🌂☂️🧵🧶👓🕶🥽🥼🦺👔👕👖🧣🧤🧥🧦👗👘🥻🩱🩲🩳👙👚👛👜👝🎒👞👟🥾🥿👠👡🩰👢👑👒🎩🎓🧢⛑💄💍💼"
