import 'dart:io';

void main() {
  List <String> servicos = ['corte social', 'moicano', 'corte degrade', 'corte elaborado'];
  List<double> precos = [20, 30, 23, 28];
  List<String> itensEscolhidos = [];
  int documento = 0;
  int number = 0;

  print("Bem-vindo a barbearia");
  print("Primeiro me informe seu nome: ");
  String ? nome = stdin.readLineSync();

  while(nome == null || nome.trim().isEmpty){
    print("Tente novamente");
    print("Digite seu nome: ");
    nome = stdin.readLineSync();
  }

  while (true){
    print("Informe seu documento: (apenas números)");
    try{
      documento = int.parse(stdin.readLineSync()!);
      break;
    }on FormatException{
      print("Digite apenas números!");
    }
  }

  String ? continuar;
  do{
    menu();

    print("Digite o número do item que deseja comprar: ");
    number = int.parse(stdin.readLineSync()!);

    if(number >= 1 && number <= servicos.length){
      itensEscolhidos.add(servicos[number - 1]);
    }else{
      print("Opção inválida");
    }

    print("Deseja adicionar mais um item?(sim/nao)");
    continuar = stdin.readLineSync();

  }while(continuar != null && continuar == 'sim' );

  print("Escolha a forma de pagamento: ");
  int pagamento = 0;
  int total = 0;
  double desconto = 0;
  double valorAtualizado = 0;

  do{
    print("1-Dinheiro");
    print("2-Cartão de débito");
    print("3-Cartão de crédito");
    print("4-PIX");

    pagamento = int.parse(stdin.readLineSync()!);
    switch(pagamento){
      case 1:
        desconto = total * 0.10;
        valorAtualizado = total - desconto;
    }
  }
}

void menu(){
  print("1-Corte Social");
  print("2-Corte moicano");
  print("3-Corte degrade");
  print("4-Corte elaborado");
}