import 'package:flutter/material.dart';

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListaPessoasPantalla(),
    );
  }
}

class Pessoa {
  final String nome;
  
  final String cpf;
  final int idade;
  final int telefone;

  Pessoa({
    required this.nome,
    required this.idade,
    required this.cpf,
    required this.telefone,
  });
}

class ListaPessoasPantalla extends StatefulWidget {
  @override
  _ListaPessoasPantallaState createState() => _ListaPessoasPantallaState();
}

class _ListaPessoasPantallaState extends State<ListaPessoasPantalla> {
  List<Pessoa> pessoas = [];


  void _addPessoa(Pessoa pessoa) {
    setState(() {
      pessoas.add(pessoa);
    });
    Navigator.pop(context);
  }



  void _mostrarModalCadastro(BuildContext context) {
    String nuevoNome = '';
    String nuevoCpf = '';
    int nuevaIdade = 0;
    int nuevoTelefone = 0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Nome'),
                  onChanged: (value) {
                    nuevoNome = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'CPF'),
                  onChanged: (value) {
                    nuevoCpf = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Idade'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    nuevaIdade = int.tryParse(value) ?? 0;
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Telefone'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    nuevoTelefone = int.tryParse(value) ?? 0;
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (nuevoNome.isNotEmpty && nuevoCpf.isNotEmpty && nuevoTelefone > 0 && nuevaIdade > 0) {
                      _addPessoa(Pessoa(
                        nome: nuevoNome,
                        cpf: nuevoCpf,
                        idade: nuevaIdade,
                        telefone: nuevoTelefone,
                      ));
                    }
                  },
                  child: Text('Cadastrar'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Pessoas'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        color: Colors.lightBlue[50],
        child: ListView.builder(
          itemCount: pessoas.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(pessoas[index].nome),
              subtitle: Text(
                  'CPF: ${pessoas[index].cpf}, Idade: ${pessoas[index].idade}, Telefone: ${pessoas[index].telefone}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    pessoas.removeAt(index);
                  });
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarModalCadastro(context),
        child: Icon(Icons.add),
        backgroundColor: Colors.lightBlue,
      ),
    );
  }
}
