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
  double valorTotal = calcularTotal(itensEscolhidos, servicos, precos);
  double desconto = 0;
  double valorAtualizado = 0;

  bool pagamentoValido = false;

  do{
    print("1-Dinheiro");
    print("2-Cartão de débito");
    print("3-Cartão de crédito");
    print("4-PIX");

    pagamento = int.parse(stdin.readLineSync()!);
    switch(pagamento){
      case 1:
        desconto = valorTotal * 0.10;
        valorAtualizado = valorTotal - desconto;

        print("Total com desconto: R\$ $valorAtualizado");

        bool pagamentoDinheiroValido = false;

        while (!pagamentoDinheiroValido) {
          print("Informe o valor pago pelo cliente: ");
          double valorPago = double.parse(stdin.readLineSync()!);

          double troco = valorPago - valorAtualizado;
          if (troco < 0){
            print("Valor pago insuficiente! Faltam R\$ ${-troco}");
          } else {
            print("Troco: R\$ $troco");
            pagamentoDinheiroValido = true;
            pagamentoValido = true;
          }
        }
        break;

      case 2:
        pagamentoValido = true;
        desconto = 0;
        valorAtualizado = valorTotal;

        print("Total a pagar (débito): R\$ $valorAtualizado");
        break;
      case 3:
        pagamentoValido = true;
        double juros = valorTotal * 0.10;
        valorAtualizado = valorTotal + juros;

        print("Total com juros (crédito): R\$ $valorAtualizado");
        break;
      case 4:
        pagamentoValido = true;
        desconto = valorTotal * 0.05;
        valorAtualizado = valorTotal - desconto;

        print("Total com desconto (PIX): R\$ $valorAtualizado");
        break;

      default:
        print("Forma de pagamento inválida");
    }
  }while (!pagamentoValido);

  print("--RECIBO FINAL--");
  print("Serviços escolhidos: ");
  for (String item in itensEscolhidos){
    print("- $item");
  }
  print("Total a pagar: R\$ $valorAtualizado");
}

void menu(){
  print("1-Corte Social");
  print("2-Corte moicano");
  print("3-Corte degrade");
  print("4-Corte elaborado");
}

double calcularTotal(List<String> itensEscolhidos, List<String> servicos, List<double> precos){
    double total = 0;

    for (int i = 0; i < itensEscolhidos.length; i++){
      String item = itensEscolhidos[i];

      for (int j = 0; j < servicos.length; j++ ){
        if (item == servicos[j]){
          total += precos[j];
          break;
        }
      }
    }

    return total;
  }