import Foundation

struct Student: Codable{
  let name: String
  var studentsInPreviousCycles: [String]

  init(name: String, lastCycle: [String] ){
    self.name = name
    studentsInPreviousCycles = lastCycle
  }

}
struct SampleStudents: Codable {
  var students: [Student]
  init(students: [Student]){
    self.students = students
  }
}

class Students {
  func getAll () -> Array<Student>? {
    guard let initialData = JsonSQL().getJsonData(fileName: "alunos") else {
      return nil
    }
    guard let response = JsonSQL().parseStudent(jsonData: initialData) else {
      return nil
    }
    return response.students
  }

  func getByName (name: String) -> Student? {
    guard let allStudents = getAll() else {
      return nil
    }

    for student in allStudents {
      if student.name == name {
        return student
      }
    } 
    return nil
  }
  
  func add(name: String, lastCycle: [String]) -> Bool {
    
    guard var allStudents = getAll() else {
      return false
    }

    for student in allStudents {
      if student.name == name{
        return false
      }
    }
    
    let newStudent = Student.init(name: name, lastCycle: lastCycle)
    allStudents.append(newStudent)

    let newSampleRecord = SampleStudents.init(students: allStudents)
    let dataSampleRecord = try! JSONEncoder().encode(newSampleRecord)

    let result = JsonSQL().postJson(dataSampleRecord, fileName: "alunos")
    return result
  }

  func edit(name: String, studentsInPreviousCycles: [String]){
    
    guard let allStudents = getAll() else {
      return
    }
    
    var allStudentsUpdated: Array<Student> = []
    
    for student in allStudents {
      if student.name == name {
        let studentUpdated = Student.init(name: name, lastCycle: studentsInPreviousCycles)
        
        allStudentsUpdated.append(studentUpdated)
      }else {
        allStudentsUpdated.append(student)
      }
    }

    let newSampleStudents = SampleStudents.init(students: allStudentsUpdated)

    let dataSampleStudents = try! JSONEncoder().encode(newSampleStudents)
    
    let _ = JsonSQL().postJson(dataSampleStudents, fileName: "alunos")
    
  }

  func updatePreviousGroup(_ newCycle: [[String]]) {
    for group in newCycle {
      for student in group {
        var newGroup = group.filter { $0 != student }
        guard let currentStudent = Students().getByName(name: student)else {
          return 
        }
        newGroup += currentStudent.studentsInPreviousCycles
        Students().edit(name: student, studentsInPreviousCycles: newGroup)
      }
    }
  }

  func clearHistory() {
    let allStudents = self.getAll()!
    for student in allStudents {
      self.edit(name: student.name, studentsInPreviousCycles: [])
    }
  }
}