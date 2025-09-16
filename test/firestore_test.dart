// test/firestore_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz/services/firebase_service.dart';
import 'package:quiz/models/question.dart';

// Gera os mocks
@GenerateMocks([
  FirebaseFirestore,
  CollectionReference,
  QuerySnapshot, 
  QueryDocumentSnapshot
])
import 'firestore_service_test.mocks.dart';

void main() {
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference mockCollection;
  late MockQuerySnapshot mockQuerySnapshot;
  late FirebaseService firebaseService;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockCollection = MockCollectionReference();
    mockQuerySnapshot = MockQuerySnapshot();
    
    firebaseService = FirebaseService(firestoreInstance: mockFirestore);
    
    // Configuração básica dos mocks
    when(mockFirestore.collection('questions')).thenReturn(mockCollection);
  });

  test('getQuestionsFromFirestore retorna lista de Questions com dados válidos', () async {
    // 1. Configurar os documentos mock
    final mockDoc1 = MockQueryDocumentSnapshot();
    when(mockDoc1.data()).thenReturn({
      'question': 'What is Flutter?',
      'options': ['Framework', 'IDE', 'Software', 'Programming Language'],
      'correct_answer_index': 0
    });

    final mockDoc2 = MockQueryDocumentSnapshot();
    when(mockDoc2.data()).thenReturn({
      'question': 'What is Dart?',
      'options': ['Programming Language', 'Database', 'Framework', 'Browser'],
      'correct_answer_index': 0
    });

    // 2. Configurar o QuerySnapshot
    when(mockQuerySnapshot.docs).thenReturn([mockDoc1, mockDoc2]);
    
    // 3. Configurar a coleção para retornar o QuerySnapshot mock
    when(mockCollection.get()).thenAnswer((_) async => mockQuerySnapshot);

    // 4. Executar o teste
    final questions = await firebaseService.getQuestionsFromFirestore();

    // 5. Verificar os resultados
    expect(questions, hasLength(2));
    
    // Verificar primeira pergunta
    expect(questions[0].question, 'What is Flutter?');
    expect(questions[0].options, hasLength(4));
    expect(questions[0].options[0], 'Framework');
    expect(questions[0].correctAnswerIndex, 0);
    
    // Verificar segunda pergunta
    expect(questions[1].question, 'What is Dart?');
    expect(questions[1].options, hasLength(4));
    expect(questions[1].options[0], 'Programming Language');
    expect(questions[1].correctAnswerIndex, 0);
    
    // 6. Verificar se os métodos foram chamados
    verify(mockFirestore.collection('questions')).called(1);
    verify(mockCollection.get()).called(1);
  });

  test('getQuestionsFromFirestore lida com erro e retorna lista vazia', () async {
    // Configurar para lançar uma exceção
    when(mockCollection.get()).thenThrow(FirebaseException(plugin: 'firestore'));

    // Executar o teste
    final questions = await firebaseService.getQuestionsFromFirestore();

    // Verificar que retorna lista vazia em caso de erro
    expect(questions, isEmpty);
    
    // Verificar se os métodos foram chamados
    verify(mockFirestore.collection('questions')).called(1);
    verify(mockCollection.get()).called(1);
  });

  test('getQuestionsFromFirestore retorna lista vazia para coleção vazia', () async {
    // Configurar QuerySnapshot vazio
    when(mockQuerySnapshot.docs).thenReturn([]);
    when(mockCollection.get()).thenAnswer((_) async => mockQuerySnapshot);

    // Executar o teste
    final questions = await firebaseService.getQuestionsFromFirestore();

    // Verificar que retorna lista vazia
    expect(questions, isEmpty);
  });

  test('getQuestionsFromFirestore converte dados corretamente com valores padrão', () async {
    // Configurar documento com dados incompletos
    final mockDoc = MockQueryDocumentSnapshot();
    when(mockDoc.data()).thenReturn({
      'question': 'Test Question',
      'options': ['A', 'B'],
      // correct_answer_index faltando - deve usar valor padrão
    });

    when(mockQuerySnapshot.docs).thenReturn([mockDoc]);
    when(mockCollection.get()).thenAnswer((_) async => mockQuerySnapshot);

    // Executar o teste
    final questions = await firebaseService.getQuestionsFromFirestore();

    // Verificar conversão com valores padrão
    expect(questions, hasLength(1));
    expect(questions[0].question, 'Test Question');
    expect(questions[0].options, hasLength(2));
    expect(questions[0].correctAnswerIndex, 0); // Valor padrão
  });
}