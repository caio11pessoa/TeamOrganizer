class Utilities {
  func readInt() -> Int?{
    guard let someNumber = readLine() else {
      Error().readLineError()
      return nil
    }
    guard let someNumber = Int(someNumber) else {
      Error().impossibleToConvertInNumber()
      return nil
    }
    return someNumber
  };
}