// ignore_for_file: constant_identifier_names, library_private_types_in_public_api

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NowPlayingTvsPage extends StatefulWidget {
  static const ROUTE_NAME = '/on-the-air-tv';

  const NowPlayingTvsPage({super.key});

  @override
  _NowPlayingTvsPageState createState() => _NowPlayingTvsPageState();
}

class _NowPlayingTvsPageState extends State<NowPlayingTvsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<OnTheAirTvsBloc>().add(FetchOnTheAirTvs()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On the air'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<OnTheAirTvsBloc, TvState>(
          builder: (context, state) {
            if (state is TvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.tvs[index];
                  return TvCard(tv);
                },
                itemCount: state.tvs.length,
              );
            } else if (state is TvHasError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Text('Failed');
            }
          },
        ),
      ),
    );
  }
}
