import Glibc

class Error {
  func invalidOption(){
    system("clear")
    print("Você não escolheu uma opção válida\n")
    pressEnter()
  }
  func readLineError(){
    system("clear")
    print("Aconteceu algo de errado com a leitura do seu dado")
    pressEnter()
  }
  func impossibleToConvertInNumber(){
    system("clear")
    print("É impossível converter esse valor em um number, por favor, tente outro.")
    pressEnter()
  }
  func negativeBalance(){
    system("clear")
    print("Saldo negativo. tente outro valor.\n")
    pressEnter()
  }
  func loginUsed(){
    system("clear")
    print("Login já em uso, tente outro.\n")
    pressEnter()
  }
}

func pressEnter(){
  print("pressione enter para continuar...")
  _ = readLine()
}