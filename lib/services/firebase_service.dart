// services/firebase_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/question.dart';

class FirebaseService {
  // Instância do Firestore (pode ser mockada para testes)
  final FirebaseFirestore _firestore;
  
  // Construtor que permite injetar uma instância do Firestore
  FirebaseService({FirebaseFirestore? firestoreInstance})
      : _firestore = firestoreInstance ?? FirebaseFirestore.instance;
  
  // Método para buscar todas as questions
  Future<List<Question>> getQuestionsFromFirestore() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('questions').get();
      
      return querySnapshot.docs.map((doc) {
        return Question.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Erro ao buscar perguntas: $e');
      return [];
    }
  }
  
  // Método adicional para buscar uma question específica por ID
  Future<Question?> getQuestionById(String id) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('questions').doc(id).get();
      
      if (doc.exists) {
        return Question.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Erro ao buscar pergunta: $e');
      return null;
    }
  }
  
  // Outros métodos relacionados ao Firebase podem ser adicionados aqui
}