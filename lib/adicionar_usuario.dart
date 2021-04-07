import 'package:flutter/material.dart';
import 'package:t1_ponto_extra/usuario.dart';

class CriarUsuario extends StatefulWidget {
  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CriarUsuario> {
  final _formKey = GlobalKey<FormState>();
  String nome;
  TextEditingController _dataNovoUsuario = TextEditingController();
  DateTime dtSelecionada = DateTime.now();

  //Validação e Salvamento na lista
  void _salvarForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Navigator.pop(
        context,
        Usuario(nome: nome, aniversario: dtSelecionada),
      );
    }
  }

  //Cuida de Passar a Data de Nascimento no formato dd/mm/yyyy
  _selectDate(BuildContext context) async {
    final DateTime escolhida = await showDatePicker(
        context: context,
        initialDate: dtSelecionada,
        firstDate: DateTime.utc(1900),
        lastDate: DateTime.now());
    if (escolhida != null && escolhida != dtSelecionada)
      setState(() {
        dtSelecionada = escolhida;
        var date =
            "${escolhida.toLocal().day}/${escolhida.toLocal().month}/${escolhida.toLocal().year}";
        _dataNovoUsuario.text = date;
      });
  }

//Buildar a Segunda tela referente ao cadastro do Novo Usuario
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Adicionar Usuário",
            style: TextStyle(color: Colors.white),
          ),
          leadingWidth: 90,
          leading: TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancelar",
              style: TextStyle(color: Colors.red[700], fontSize: 16),
            ),
          ),
        ),
        body: SafeArea(
          minimum: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: 50,
                ),
                TextFormField(
                    onSaved: (val) => nome = val,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      icon: Icon(
                        Icons.account_circle,
                        color: Colors.black,
                        size: 24.0,
                        semanticLabel: 'Nome do Usuário',
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) return "Por favor insira seu nome!";
                      return null;
                    }),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      onSaved: (val) {
                        dtSelecionada = dtSelecionada;
                      },
                      controller: _dataNovoUsuario,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        labelText: "Aniversario",
                        icon: Icon(
                          Icons.celebration,
                          color: Colors.black,
                          size: 24.0,
                          semanticLabel: 'Data de Nascimento do Usuário',
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty)
                          return "Por favor insira sua data de Nascimento!";
                        return null;
                      },
                    ),
                  ),
                ),
                Container(
                  height: 50,
                ),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _salvarForm,
                    label: Text('Confirmar'),
                    icon: Icon(Icons.check),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
