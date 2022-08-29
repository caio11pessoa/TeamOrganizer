import Foundation
struct Cycle: Codable {
  let ciclo: [[String]]
  init(ciclo: [[String]]){
    self.ciclo = ciclo
  }
}

struct SampleCycles: Codable {
  let ciclos: [Cycle]
  init(ciclos: [Cycle]){
    self.ciclos = ciclos
  }
}

/*** Extras:
  - Parece um pouco estranha essa forma de fazer, mas,
eu estou tentando separar cada ciclo de um ciclo de ciclos rsrs
ou seja Samplecycles contém todos os ciclos
fica mais fácil para decodificar depois
***/

class Cycles {

  func getAll () -> Array<Cycle>? {
    guard let initialData = JsonSQL().getJsonData(fileName: "ciclos") else {
      return nil
    }
    guard let response = JsonSQL().parseCycles(jsonData: initialData) else {
      return nil
    }
    return response.ciclos
  }

  func add (ciclo: [[String]]) {
  
    let newCycle = Cycle.init(ciclo: ciclo)

    guard var allCycles = getAll() else {return }
    allCycles.append(newCycle)

    let newSampleRecord = SampleCycles.init(ciclos: allCycles)

    let dataSampleRecord = try! JSONEncoder().encode(newSampleRecord)

    let _ = JsonSQL().postJson(dataSampleRecord, fileName: "ciclos")
  
  return 
  }

  func calculateCycle(groupSize: Int) -> [[String]]?{
    guard let allStudents: Array<Student> = Students().getAll() else {
      return nil
    }

    var estudantesFaltantes: [String] = []

    for student in allStudents {
      estudantesFaltantes.append(student.name)
    }
    
    let amostra = generateArrayWithGroupSize(groupSize: groupSize, totalSize: allStudents.count)
    print("AMOSTRA", amostra)
    var newGroup: [String] = []
    var newCycle: [[String]] = []

    for grupoDaAmostra in amostra {
      for _ in grupoDaAmostra {
        let EstudanteViavel =  self.checkViableStudent(estudantesFaltantes, newGroup)
        newGroup.append(EstudanteViavel)

        if let index = estudantesFaltantes.firstIndex(of: EstudanteViavel) {
          estudantesFaltantes.remove(at: index)
        }
      }
      newCycle.append(newGroup)
      newGroup = []
    }
    
    self.add(ciclo: newCycle)
    return newCycle
  }
  func generateArrayWithGroupSize(groupSize: Int, totalSize: Int) -> [[String]]{
    var newCycle: [[String]] = []
    var newArrange: Array<String> = []
    for i in 0..<totalSize {
      if(i != 0 && i%groupSize == 0){
        newCycle.append(newArrange)
        newArrange = []
      }else if (i == totalSize - 1){
        print("Second If")
        newArrange.append("0")
        newCycle.append(newArrange)
      }
      newArrange.append("0")
    }
    return newCycle
  }

  func checkViableStudent (_ estudantesFaltantes: [String], _ currentGroup: [String]) -> String {
    var estudantesFaltantesSorteds = estudantesFaltantes
    estudantesFaltantesSorteds.sort()
    if(currentGroup.count == 0){
      return estudantesFaltantesSorteds[0]
    }
    for student in estudantesFaltantesSorteds{
      if(checkNameInGroup(name: student, group: currentGroup)){
        return student
      }
    }
    return estudantesFaltantesSorteds.randomElement()!
  }

  func checkNameInGroup (name: String, group: [String]) -> Bool {
    for member in group {
      guard let groupStudent = Students().getByName(name: member) else {
        return false
      }
      
      if(groupStudent.studentsInPreviousCycles.contains(name)){
        return false
      }
    }
    return true
  }
  
}  