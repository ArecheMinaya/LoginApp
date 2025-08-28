import 'package:login_app/src/features/auth/%20models/user.dart';

enum AuthStatus { unauthenticated, loading, authenticated, error }

class AuthState {
  final AuthStatus status;
  final UserModel? userInfo;
  final String? errorMessage;

  const AuthState({required this.status, this.userInfo, this.errorMessage});

  factory AuthState.initial() =>
      const AuthState(status: AuthStatus.unauthenticated);

  AuthState copyWith({
    AuthStatus? status,
    UserModel? userInfo,
    String? errorMessage,
  }) => AuthState(
    status: status ?? this.status,
    userInfo: userInfo ?? this.userInfo,
    errorMessage: errorMessage,
  );

  Map<String, dynamic> toJson() => {
    'status': status.index,
    'userInfo': userInfo?.toJson(),
    'errorMessage': errorMessage,
  };

  static AuthState fromJson(Map<String, dynamic> json) => AuthState(
    status: AuthStatus.values[(json['status'] ?? 0) as int],
    userInfo: UserModel.fromJson(
      (json['userInfo'] ?? {}) as Map<String, dynamic>,
    ),
    errorMessage: json['errorMessage'] as String?,
  );
}
