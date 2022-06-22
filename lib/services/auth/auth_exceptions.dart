
//login exception
class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

//register exception

class InvalidEmailAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

class WeakPasswordAuthException implements Exception {}

//generic exception

class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}
