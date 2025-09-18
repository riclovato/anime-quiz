import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz/models/question.dart';


class QuestionService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  
  Future<Question> getFirstQuestion() async {
   
    var snapshot = await _db.collection("questions").limit(1).get();

    if (snapshot.docs.isNotEmpty) {
      var data = snapshot.docs.first.data();
      return Question.fromMap(data);
    } else {
      throw Exception("Nenhuma questão encontrada no banco.");
    }
  }

  Future<List<Question>> getRandomQuestions({int limit = 10}) async {
  var snapshot = await _db.collection("questions").get();

  List<Question> allQuestions = snapshot.docs.map((doc) {
    return Question.fromMap(doc.data());
  }).toList();

  allQuestions.shuffle(); 

  return allQuestions.take(limit).toList(); 
}

Future<void> addQuestion(Map<String, dynamic> questionJson) async {
    Question question = Question.fromMap(questionJson);
    await _db.collection('questions').add(question.toMap());
  }

  Future<void> addQuestions(List<Map<String, dynamic>> questionsJson) async {
    for (var questionJson in questionsJson) {
      await addQuestion(questionJson);
    }
  }
}
