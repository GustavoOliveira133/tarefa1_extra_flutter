import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:t1_ponto_extra/usuario.dart';
import 'package:t1_ponto_extra/adicionar_usuario.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
    },
  ));
}

class Home extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trabalho Flutter',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: MyHomePage(title: 'Lista de Usuários'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Usuario> usuarios = [
    Usuario(nome: "Bruno Amaral", aniversario: DateTime.now()),
    Usuario(nome: "Jorge Aragão", aniversario: DateTime.utc(1975, 03, 14)),
    Usuario(nome: "Pablo Vittar", aniversario: DateTime.utc(1990, 12, 21)),
    Usuario(nome: "Jorge Vercilo", aniversario: DateTime.utc(1978, 05, 04)),
    Usuario(nome: "Bruna Marquezine", aniversario: DateTime.utc(1988, 07, 29)),
  ];

  // Função que espera o Usuario ser criado
  _esperaDoNovoUsuario(BuildContext context, Widget page) async {
    Usuario addUsuario;
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        )) as Usuario;
    if (result != null) {
      addUsuario = result;
      setState(() {
        usuarios.add(addUsuario);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          child: ListView.builder(
              itemCount: usuarios.length,
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  child: ListTile(
                    title: Text(
                      'Nome:\t${usuarios[index].nome}',
                    ),
                    subtitle: Text('Aniversário:\t' +
                        DateFormat('dd/MM/yyyy')
                            .format(usuarios[index].aniversario)),
                  ),
                  background: arrastarParaDireitaBackground(),
                  secondaryBackground: arrastarParaEsquerdaBackground(),
                  key: UniqueKey(),
                  onDismissed: (DismissDirection direction) {
                    if (direction == DismissDirection.endToStart) {
                      setState(() {
                        usuarios.removeAt(index);
                      });
                    } else {
                      setState(() {
                        print('edit não foi feito ainda');
                      });
                    }
                  },
                );
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _esperaDoNovoUsuario(context, CriarUsuario()),
        child: Icon(Icons.add),
      ),
    );
  }
}

// Arrastar para a direita para Editar o Usuario (Não IMPLEMENTADO - Apenas visual)
Widget arrastarParaDireitaBackground() {
  return Container(
    color: Colors.green,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.edit,
            color: Colors.white,
          ),
          Text(
            " Editar",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
    ),
  );
}

// Arrastar para a esquerda para Deletar o Usuario
Widget arrastarParaEsquerdaBackground() {
  return Container(
    color: Colors.red,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          Text(
            " Deletar",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      alignment: Alignment.centerRight,
    ),
  );
}
