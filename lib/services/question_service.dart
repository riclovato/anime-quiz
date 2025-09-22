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
      throw Exception("No questions found in the database.");
    }
  }

  Future<List<Question>> getRandomQuestions({int limit = 10}) async {
    try {
      var snapshot = await _db.collection("questions").get();

      List<Question> allQuestions = snapshot.docs.map((doc) {
        return Question.fromMap(doc.data());
      }).toList();

      allQuestions.shuffle();

      return allQuestions.take(limit).toList();
    } catch (e) {
      print("Error fetching questions: $e");
      return [];
    }
  }

  Future<void> addQuestion(Map<String, dynamic> questionJson) async {
    try {
      Question question = Question.fromMap(questionJson);
      await _db.collection('questions').add(question.toMap());
    } catch (e) {
      print("Error adding question: $e");
    }
  }

  Future<void> addQuestions(List<Map<String, dynamic>> questionsJson) async {
    try {
      for (var questionJson in questionsJson) {
        await addQuestion(questionJson);
      }
    } catch (e) {
      print("Error adding questions: $e");
    }
  }
}
