import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz/services/question_service.dart';


class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController _controller = TextEditingController();
  final QuestionService _service = QuestionService();

  String? role;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserRole();
  }

  Future<void> fetchUserRole() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // redireciona para login após o primeiro frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/login');
      });
      return;
    }

    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

    setState(() {
      role = userDoc.exists ? userDoc.get('role') : null;
      isLoading = false;
    });

    if (role != 'admin' && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Acesso negado. Você não é administrador.')),
        );
      });
    }
  }

  Future<void> _addFromJsonText() async {
    try {
      List<dynamic> jsonData = jsonDecode(_controller.text);
      List<Map<String, dynamic>> questions =
          jsonData.map((e) => Map<String, dynamic>.from(e)).toList();

      await _service.addQuestions(questions);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Questões adicionadas com sucesso!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Erro: $e")));
    }
  }

  Future<void> _addFromFile() async {
    try {
      String data = await rootBundle.loadString('assets/questions.json');
      List<dynamic> jsonData = jsonDecode(data);
      List<Map<String, dynamic>> questions =
          jsonData.map((e) => Map<String, dynamic>.from(e)).toList();

      await _service.addQuestions(questions);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Questões do arquivo adicionadas com sucesso!"),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Erro ao ler arquivo: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Admin - Adicionar Questões")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Cole o JSON das questões:"),
            TextField(
              controller: _controller,
              maxLines: 8,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText:
                    '[{ "question": "...", "options": ["..."], "correctAnswerIndex": 0 }]',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addFromJsonText,
              child: const Text("Adicionar do campo de texto"),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _addFromFile,
              icon: const Icon(Icons.file_open),
              label: const Text("Adicionar do arquivo JSON"),
            ),
          ],
        ),
      ),
    );
  }
}
