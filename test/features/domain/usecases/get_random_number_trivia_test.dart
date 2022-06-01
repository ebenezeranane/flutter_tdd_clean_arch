// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_arch/core/usecase/usecase.dart';
import 'package:flutter_tdd_clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_tdd_clean_arch/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_tdd_clean_arch/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetRandomNumberTrivia usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

//mock data
  final tNumberTrivia = NumberTrivia(number: 1, text: "testing..");

  test('should get trivia for the number from the repository', () async {
    // when the GetConcreteNumberTrivia is called with any argument, always
    // return the right side of the Either which returns a NumberTrivia test object
    when(mockNumberTriviaRepository.getRandomNumberTrivia())
        .thenAnswer((_) async => Right(tNumberTrivia));

    final result = await usecase(NoParams());

    //use case should return whatever was returned from the repository
    expect(result, Right(tNumberTrivia));

// verify that the method has been called on the repository
    verify(mockNumberTriviaRepository.getRandomNumberTrivia());

//only the above method should be called and nothing more
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
