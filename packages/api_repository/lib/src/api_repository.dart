/// {@template api_repository}
/// A fake api repository
/// {@endtemplate}
class ApiRepository {
  /// {@macro api_repository}
  const ApiRepository();

  /// function to fetch todos
  List<String> fetchTodos() => ['cook', 'clean', 'kill hema'];
}
