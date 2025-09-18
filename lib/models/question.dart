class Question{
  final String question;
  final List<String> options;
  final int correctAnswerIndex;


  Question(
    {
      required this.question,
      required this.options,
      required this.correctAnswerIndex
    }
  );

  bool isCorrect(int selectedIndex){
    return selectedIndex == correctAnswerIndex;
  }

  factory Question.fromMap(Map<String, dynamic> data){
    return Question(
      question: data['question'] ?? '',
      options: List<String>.from(data['options'] ?? []),
       correctAnswerIndex: data['correct_answer_index'] ?? 0, 
    );
  }
   Map<String, dynamic> toMap() {
    return {
      'question': question,
      'options': options,
      'correctAnswerIndex': correctAnswerIndex,
    };
  }
}