import Glibc

class View {
  func lounchScreen() {
    print("Team Organizer!\n\nOlá, estamos aqui para ajudar no seu próximo challenge!\n\nVocê só precisa registrar os alunos no nosso sistema e pedir para ele criar o primeiro ciclo.\n\nDepois disso é só nos informar quando desejar fazer outro ciclo.\n\nVamos começar?")
  }
  func initialScreen() {
    print("\n\nVocê deseja Reiniciar o sistema?")
    print("\nA: Sim")
    print("\nB: Não")

    if let option = readLine() {

      switch (option)  {
      
        case "a", "A":
          self.resetSystemScreen()

        case "b", "B":
          self.menuScreen()

        default:
          Error().invalidOption()
          self.initialScreen()
      }
    } 
  }

  func menuScreen(){
    system("clear")
    print("Show!\n\n então o que você deseja fazer?\n")
    print("\nA: Visualizar ciclos anteriores")
    print("\nB: Visualizar todos os alunos")
    print("\nC: Adicionar um aluno")
    print("\nD: gerar um novo ciclo")
    print("\nE: Limpar histórico de ciclos passados de alunos ")

    if let option = readLine() {

      switch (option)  {
      
        case "a", "A":
          self.viewPreviousCyclesScreen()

        case "b", "B":
          self.viewAllStudentsScreen()
        
        case "c", "C":
          self.addStudentsScreen()
        
        case "d", "D":
          self.addCycleScreen()

        case "e", "E":
          self.cleanHistoryScreen
    ()

        default:
          Error().invalidOption()
          self.menuScreen()
      }
    } 
    
  }
  func viewPreviousCyclesScreen() {
    let allCycles = Cycles().getAll()!

    print("Esses são todos os ciclos até agora:\n\n")
    for cycle in allCycles {
      print("ciclo: ", cycle.ciclo)
    }
    pressEnter()
    self.menuScreen()
    
  }
  
  func viewAllStudentsScreen() {
    system("clear")
    let allStudents = Students().getAll()!
    print("Esses são todos os alunos:\n\n")
    for student in allStudents {
      print("estudante: ", student.name)
    }
    pressEnter()
    self.menuScreen()
  }

  func addCycleScreen(){
    system("clear")

    print("\n\nOk, então vamos gerar um novo ciclo para você\n\n")
    print("Algumas coisas para ficar atento.\n")
    print("Caso n exista mais possibilidade de organização que um aluno não tenha estado com outro a organização se torna aleatória")
    print("Então certifique-se de limpar o histórico dos alunos")

    print("O próximo ciclo deverá ser de grupo com quantos alunos?\n")
    print("Digite um número entre 2 e 5:")
    guard let groupSizeSet = Utilities().readInt() else {
      return self.addCycleScreen()
    }
    
    guard let newCycle = Cycles().calculateCycle(groupSize: groupSizeSet) else {
      return
    }
    system("clear")
    print("esse foi o novo ciclo:\n")
    for cycle in newCycle {
      print(cycle)
    }
    Students().updatePreviousGroup(newCycle)
    pressEnter()
    self.menuScreen()
  }

  func resetSystemScreen(){
    system("clear")

    JsonSQL().deleteAll() 

    print("Certo, então nos diga os dados dos alunos")

    self.addStudentsScreen()
  }

  func addStudentsScreen() {
    
    print("\n\nDigite o nome do aluno:")
    
    guard let name = readLine() else {
      Error().readLineError()
      return self.addStudentsScreen()
    }
    let checkAddStudents = Students().add(name:name, lastCycle: [])
    if(!checkAddStudents){
      print("\n\nUsuário já existente ou em formato incorreto.\nColoque o sobrenome caso tenha mais de um aluno com o mesmo nome.\n\n")
    }
    
    print("Deseja continuar Adicionando?")
    print("\nA: Sim")
    print("\nB: Não")

    if let option = readLine() {

      switch (option)  {
      
        case "a", "A":
          self.addStudentsScreen()

        case "b", "B":
          self.menuScreen()

        default:
          Error().invalidOption()
          self.menuScreen()
      }
    } 
  }

  func cleanHistoryScreen() {
    print("Você tem certeza que deseja limpar seu histórico?")
    print("\nA: Sim")
    print("\nB: Não")

    if let option = readLine() {

      switch (option)  {
      
        case "a", "A":
          Students().clearHistory()
          print("Histórico apagado")
          pressEnter()
          self.menuScreen()

        case "b", "B":
          self.menuScreen()

        default:
          Error().invalidOption()
          self.menuScreen()
      }
    } 
  }
}