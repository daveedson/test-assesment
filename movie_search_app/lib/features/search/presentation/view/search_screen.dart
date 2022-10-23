// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors, override_on_non_overriding_member, must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_search_app/features/search/domain/search_movie_model.dart';
import 'package:movie_search_app/features/search/domain/search_movie_repository_impl.dart';
import 'package:movie_search_app/features/search/domain/useCases/search_movie_usecase.dart';
import 'package:movie_search_app/features/search/presentation/controller/searchMovie_controller.dart';
import 'package:movie_search_app/features/widgets/movietile.dart';

class SearchScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String searchText = "";
     
      return ref.watch(searchMovieControllerProvider).movies.when(
          loading: () => Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          data: (List<MovieModel> data) => Scaffold(
                backgroundColor: Color(0xFFFEF9F3),
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 55.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 30.0),
                        Row(
                          children: [
                            Text("Movies",
                                style: TextStyle(
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45)),
                            Spacer(),
                            Icon(
                              Icons.equalizer_outlined,
                              size: 35.0,
                              color: Colors.black45,
                            ),
                            SizedBox(width: 10.0),
                            CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: 20.0,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                        SizedBox(height: 15.0),
                        SizedBox(
                          height: 50.0,
                          child: TextFormField(
                            controller: ref
                                .read(searchMovieControllerProvider)
                                .textEditingController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                prefixIcon: IconButton(
                                  color: Colors.black45,
                                  icon: Icon(Icons.search),
                                  onPressed: () {
                                    searchText = ref
                                        .watch(searchMovieControllerProvider)
                                        .textEditingController
                                        .text;
                                    ref
                                        .watch(searchMovieControllerProvider
                                            .notifier)
                                        .searchMovies(searchText);
                                    SystemChannels.textInput
                                        .invokeMethod('TextInput.hide');
                                  },
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    borderSide:
                                        BorderSide(color: Colors.black54)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    borderSide:
                                        BorderSide(color: Colors.black54)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    borderSide:
                                        BorderSide(color: Colors.black54)),
                                hintStyle: TextStyle(
                                  color: Colors.black54,
                                ),
                                filled: true,
                                fillColor: Colors.white70,
                                hintText: 'Search'),
                          ),
                        ),
                        SizedBox(height: 100.0),
                        Lottie.asset("images/search.json"),
                        MovieTile(),
                        Text(
                          "Search for your favourite movies or shows",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ),
          error: (e ,error) => Scaffold(
            backgroundColor: Color(0xFFFEF9F3),
            body: Center(
              child: Lottie.asset("images/somethingerror.json"),
            ),
          ));
    }
  }





         