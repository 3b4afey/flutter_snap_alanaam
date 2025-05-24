import 'package:chats_repository/chats_repository.dart';
import 'package:database_client/database_client.dart';
import 'package:env/env.dart';
import 'package:flutter_snap_alanaam/app/di/di.dart';
import 'package:flutter_snap_alanaam/app/view/app.dart';
import 'package:flutter_snap_alanaam/bootstrap.dart';
import 'package:flutter_snap_alanaam/firebase_options_stg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:posts_repository/posts_repository.dart';
import 'package:search_repository/search_repository.dart';
import 'package:shared/shared.dart';
import 'package:supabase_authentication_client/supabase_authentication_client.dart';
import 'package:token_storage/token_storage.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  bootstrap((powerSyncRepository, firebaseRemoteConfigRepository) async {
    final tokenStorage = InMemoryTokenStorage();

    final IosClientId = getIt<AppFlavor>().getEnv(Env.iOSClientId);
    final WebClientId = getIt<AppFlavor>().getEnv(Env.webClientId);
    final powerSyncDatabaseClient =
        PowerSyncDatabaseClient(powerSyncRepository: powerSyncRepository);
    final googleSignIn = GoogleSignIn(
      clientId: IosClientId,
      serverClientId: WebClientId,
    );
    final searchRepository= SearchRepository(databaseClient: powerSyncDatabaseClient);

    final supabaseAuthenticationClient = SupabaseAuthenticationClient(
      googleSignIn: googleSignIn,
      powerSyncRepository: powerSyncRepository,
      tokenStorage: tokenStorage,
    );
    final userRepository = UserRepository(
        authenticationClient: supabaseAuthenticationClient,
        databaseClient: powerSyncDatabaseClient);
    final postsRepository =
        PostsRepository(databaseClient: powerSyncDatabaseClient);
    final chatsRepository = ChatsRepository(databaseClient: powerSyncDatabaseClient);

    return App(
      chatsRepository: chatsRepository,
      searchRepository: searchRepository,
      postsRepository: postsRepository,
      user: await userRepository.user.first,
      firebaseRemoteConfigRepository: firebaseRemoteConfigRepository,
      userRepository: userRepository,
    );
  },
      options: DefaultFirebaseOptions.currentPlatform,
      appFlavor: AppFlavor.staging());
}
