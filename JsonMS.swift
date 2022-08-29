import Foundation
// Json Manage System

// JsonSQL 
class JsonSQL {
  
// Get JSON
  func getJsonData(fileName: String) -> Data? {
      // func readLocalAccountJSONFile() 
    do {
      if let filePath = Bundle.main.path(forResource: fileName, ofType: "json") {
          let fileUrl = URL(fileURLWithPath: filePath)
          let data = try Data(contentsOf: fileUrl)
          return data
      }
    } catch {
      print("error: \(error)")
    }
    return nil
  };

    func parseStudent(jsonData: Data) -> SampleStudents? {
    do {
      let decodedData = try JSONDecoder().decode(SampleStudents.self, from: jsonData)
      return decodedData
    } catch {
      print("error: \(error)")
    }
    return nil
  };
  
  func parseCycles(jsonData: Data) -> SampleCycles? {
    do {
      let decodedData = try JSONDecoder().decode(SampleCycles.self, from: jsonData)
      return decodedData
    } catch {
      print("error: \(error)")
    }
    return nil
  };
  
// Post JSON
func postJson(_ dataSampleRecord: Data, fileName: String) -> Bool {
    do {
      if let filePath = Bundle.main.path(forResource: fileName, ofType: "json"){
        let fileUrl = URL(fileURLWithPath: filePath)
        try! dataSampleRecord.write(to: fileUrl)
        return true
      }
    }
    return false
  }
  func deleteAll() {
    let newSampleStudents = SampleStudents.init(students: [])
    let dataSampleStudents = try! JSONEncoder().encode(newSampleStudents)
      
    var _ = self.postJson(dataSampleStudents, fileName: "alunos")
    
    let newSampleCycles = SampleCycles.init(ciclos: [])
    let dataSampleCycles = try! JSONEncoder().encode(newSampleCycles)

    _ = self.postJson(dataSampleCycles, fileName: "ciclos")
    
    return 
  }
}


// struct BankAccount: Codable {
//   let id: Int
//   var savedMoney: Float
//   let juros: Float
//   let lastModify: String //TODO:: Colocar tipo data
//   let idUser: Int

//   init(id: Int, savedMoney: Float, juros: Float, idUser: Int){
//     self.id = id
//     self.savedMoney = savedMoney
//     self.juros = juros
//     self.lastModify = "08/06/2022"
//     self.idUser = idUser
//   }
//   public mutating func updateSavedMoney(money: Float){
//     self.savedMoney = money
//   }
// }

// struct SampleRecordAccount: Codable {
//   var accounts: [BankAccount]
//   init(bankAccount: Array<BankAccount>){
//     self.accounts = bankAccount
//   }
// }

// struct SampleRecordAccount: Codable {
//   var accounts: [String]
//   init(bankAccount: Array<String>){
//     self.accounts = bankAccount
//   }
// }