import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:monetra/models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoginUser>((event, emit) async {
      try {
        auth.UserCredential userCredential = await auth.FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: event.user.email, password: event.user.password!);

        if (userCredential.user != null) {
          auth.User? firebaseUser = userCredential.user;

          if (firebaseUser != null) {
            // ambil data user dari firestore
            DocumentSnapshot userDoc = await FirebaseFirestore.instance
                .collection("users")
                .doc(firebaseUser.uid)
                .get();

            if (userDoc.exists) {
              // konversi ke model user
              User loggedInUser =
                  User.fromJson(userDoc.data() as Map<String, dynamic>);
              emit(UserAuthenticated(
                  uid: loggedInUser.uid,
                  email: loggedInUser.email,
                  username: loggedInUser.username));
              log("User ${firebaseUser.email} logged in");
            } else {
              emit(UserError("User not Found"));
            }
          }
        }
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<LogoutUser>((event, emit) {
      auth.FirebaseAuth.instance.signOut();
      emit(UserUnauthenticated());
    });

    on<AddUser>((event, emit) async {
      try {
        auth.UserCredential userCredential = await auth.FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: event.newUser.email, password: event.newUser.password!);
        auth.User? firebaseUser = userCredential.user;

        if (firebaseUser != null) {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(firebaseUser.uid)
              .set({
            "uid": firebaseUser.uid,
            "email": firebaseUser.email,
            "username": firebaseUser.email!.split("@")[0],
            "createdAt": FieldValue.serverTimestamp(),
          });
          emit(UserAdded(event.newUser));
          log("User ${firebaseUser.email} added");
        }
      } catch (e) {
        emit(UserError(e.toString()));
        log(e.toString());
      }
    });
  }
}
