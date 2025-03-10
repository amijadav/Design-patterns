// Mocks generated by Mockito 5.4.4 from annotations
// in design_patterns/test/singleton_pattern_test/mocks.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i2;

import 'package:design_patterns/design_patterns/singleton_pattern_example.dart'
    as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeFuture_0<T> extends _i1.SmartFake implements _i2.Future<T> {
  _FakeFuture_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [LoadingManager].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoadingManager extends _i1.Mock implements _i3.LoadingManager {
  MockLoadingManager() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Future<R> showLoading<R>(
    _i4.BuildContext? context,
    _i2.Future<R> Function()? process,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #showLoading,
          [
            context,
            process,
          ],
        ),
        returnValue: _i5.ifNotNull(
              _i5.dummyValueOrNull<R>(
                this,
                Invocation.method(
                  #showLoading,
                  [
                    context,
                    process,
                  ],
                ),
              ),
              (R v) => _i2.Future<R>.value(v),
            ) ??
            _FakeFuture_0<R>(
              this,
              Invocation.method(
                #showLoading,
                [
                  context,
                  process,
                ],
              ),
            ),
      ) as _i2.Future<R>);

  @override
  void errorLoading(
    _i4.BuildContext? context,
    dynamic error,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #errorLoading,
          [
            context,
            error,
          ],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [AuthenticationApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthenticationApi extends _i1.Mock implements _i3.AuthenticationApi {
  MockAuthenticationApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Future<Map<String, String>> signinUser({
    required String? username,
    required String? password,
    required String? role,
    required _i3.UserState? userState,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #signinUser,
          [],
          {
            #username: username,
            #password: password,
            #role: role,
            #userState: userState,
          },
        ),
        returnValue: _i2.Future<Map<String, String>>.value(<String, String>{}),
      ) as _i2.Future<Map<String, String>>);

  @override
  _i2.Future<void> signOutUser() => (super.noSuchMethod(
        Invocation.method(
          #signOutUser,
          [],
        ),
        returnValue: _i2.Future<void>.value(),
        returnValueForMissingStub: _i2.Future<void>.value(),
      ) as _i2.Future<void>);
}
