// test/firebase_service_simple_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz/services/firebase_service.dart';
import 'package:quiz/models/question.dart';

void main() {
  test('Question.fromMap converte dados corretamente', () {
    final testData = {
      'question': 'What is Flutter?',
      'options': ['Framework', 'IDE', 'Software', 'Programming Language'],
      'correct_answer_index': 0
    };

    final question = Question.fromMap(testData);

    expect(question.question, 'What is Flutter?');
    expect(question.options, hasLength(4));
    expect(question.options[0], 'Framework');
    expect(question.correctAnswerIndex, 0);
  });

  test('Question.fromMap usa valores padrão para campos nulos', () {
    final incompleteData = {
      'question': 'Test Question',
      'options': ['Option 1', 'Option 2'],
      // correct_answer_index está faltando
    };

    final question = Question.fromMap(incompleteData);

    expect(question.question, 'Test Question');
    expect(question.options, hasLength(2));
    expect(question.correctAnswerIndex, 0); // Valor padrão
  });

  test('isCorrect retorna true para resposta correta', () {
    final question = Question(
      question: 'Test',
      options: ['A', 'B', 'C'],
      correctAnswerIndex: 1,
    );

    expect(question.isCorrect(1), true);
    expect(question.isCorrect(0), false);
    expect(question.isCorrect(2), false);
  });

  test('Teste de integração simples com FirebaseService', () async {
    final service = FirebaseService();
    
    // Este teste vai tentar conectar ao Firebase real
    // Pode falhar se não houver internet/configuração
    final questions = await service.getQuestionsFromFirestore();
    
    // Pelo menos deve retornar uma lista (vazia ou com dados)
    expect(questions, isA<List<Question>>());
    
    if (questions.isNotEmpty) {
      // Se houver dados, verificar a estrutura
      expect(questions[0].question, isNotEmpty);
      expect(questions[0].options, isNotEmpty);
      expect(questions[0].correctAnswerIndex, greaterThanOrEqualTo(0));
    }
  });
}