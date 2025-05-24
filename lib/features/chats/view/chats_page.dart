// ignore_for_file: deprecated_member_use

import 'package:app_ui/app_ui.dart';
import 'package:chats_repository/chats_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snap_alanaam/app/app_bloc/app_bloc.dart';
import 'package:flutter_snap_alanaam/features/chats/bloc/chats_bloc.dart';
import 'package:flutter_snap_alanaam/features/chats/widgets/chat_inbox_tile.dart';
import 'package:flutter_snap_alanaam/features/home/presentation/home.dart';
import 'package:flutter_snap_alanaam/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key, this.hasbackbtn = true});
final bool hasbackbtn;
  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return BlocProvider(
      create: (context) =>
          ChatsBloc(chatsRepository: context.read<ChatsRepository>())
            ..add(ChatsSubscriptionRequested(userId: user.id)),
      child:  ChatsView(hasbackbtn: hasbackbtn,),
    );
  }
}

class ChatsView extends StatelessWidget {
  const ChatsView({super.key ,required this.hasbackbtn});
  final bool hasbackbtn;

  @override
  Widget build(BuildContext context) {
    return  AppScaffold(
      body: CustomScrollView(
        slivers: [
          ChatsAppBar(hasbackbtn: hasbackbtn,),
          const ChatsListView(),
        ],
      ),
    );
  }
}

class ChatsAppBar extends StatelessWidget {
  const ChatsAppBar({super.key ,required this.hasbackbtn});
final bool hasbackbtn;
  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return SliverAppBar(
      leading: hasbackbtn? IconButton(
        onPressed: () => HomeProvider().animateToPage(1),
        icon: Icon(
          Icons.adaptive.arrow_back,
          size: AppSize.iconSizeMedium,
        ),
      ) : Container(),
      centerTitle: false,
      pinned: true,
      title: Text(
        user.displayUsername,
        style: context.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
      actions: [
        Tappable.faded(
          onTap: () async {
            void createChat(String participantId) =>
                context.read<ChatsBloc>().add(
                      ChatsCreateChatRequested(
                        userId: user.id,
                        participantId: participantId,
                      ),
                    );

            final participantId =
                await context.push('/timeline/search', extra: true) as String?;
            if (participantId == null) return;
            createChat(participantId);
          },
          child: const Icon(Icons.add, size: AppSize.iconSize),
        ),
      ],
    );
  }
}

class ChatsListView extends StatelessWidget {
  const ChatsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final chats = context.select((ChatsBloc bloc) => bloc.state.chats);
    if (chats.isEmpty) return const ChatsEmpty();
    return SliverList.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        return ChatInboxTile(chat: chat);
      },
    );
  }
}

class ChatsEmpty extends StatelessWidget {
  const ChatsEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return SliverFillRemaining(
      child: Center(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: md),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.flip(
                flipX: true,
                child: Assets.icons.chatCircle.svg(
                  height: 86,
                  width: 86,
                  colorFilter: ColorFilter.mode(
                    context.adaptiveColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              Text(
                context.l10n.noChatsText,
                style: context.headlineLarge
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
              AppButton(
                text: context.l10n.startChatText,
                onPressed: () async {
                  final participantId = await context.push(
                    '/timeline/search',
                    extra: true,
                  ) as String?;
                  if (participantId == null) return;
                  void createChat() => context.read<ChatsBloc>().add(
                        ChatsCreateChatRequested(
                          userId: user.id,
                          participantId: participantId,
                        ),
                      );
                  createChat();
                },
              ),
            ].spacerBetween(height: s),
          ),
        ),
      ),
    );
  }
}
