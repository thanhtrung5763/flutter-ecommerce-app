import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:final_project/amplifyconfiguration.dart';
import 'package:final_project/models/ModelProvider.dart';
import 'package:final_project/models/User.dart';
import 'package:final_project/services/cloud/bloc/bag/bag_bloc.dart';
import 'package:final_project/services/repo/bag_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'dart:io' show Platform;
class MockAmplify extends Mock implements AmplifyAPI {}


void main() {
  late BagRepository bagRepository;

  setUp(() {
    bagRepository = BagRepository();
  });
  group('ListOrders when not logged in', () {
    
    blocTest<BagBloc, BagState>(
      'emits [BagErrorState] when BagListOrdersEvent is added.',
      build: () => BagBloc(),
      act: (bloc) => bloc.add(BagListOrdersEvent()),
      expect: () =>  [isA<BagErrorState>()],
    );
  });
  // group('Bag Repository', () { 
  //   group('called getUserByID(String id)', () { 
  //     test('return a user', () async {
  //       WidgetsFlutterBinding.ensureInitialized();
  //       await Amplify.addPlugins([
  //         AmplifyAuthCognito(),
  //         AmplifyDataStore(modelProvider: ModelProvider.instance),
  //         AmplifyAPI(modelProvider: ModelProvider.instance),
  //       ]);

  //       await Amplify.configure(amplifyconfig);
  //       print(Platform.operatingSystem);
  //       final mockAmplify = MockAmplify();
  //       final id = 'c53504e3-715d-4a52-8a51-1ba88813168a';
  //       final user = await bagRepository.getUserByID(id);
  //       expect(user, isA<User>());
  //     });
  //   });
  // });
  group('ListOrders when logged in', () { 
    group('called getOrders()', () { 
      test('return a List<Bag>', () async {
        WidgetsFlutterBinding.ensureInitialized();
        await Amplify.addPlugins([
          AmplifyAuthCognito(),
          AmplifyDataStore(modelProvider: ModelProvider.instance),
          AmplifyAPI(modelProvider: ModelProvider.instance),
        ]);

        await Amplify.configure(amplifyconfig);
        print(Platform.operatingSystem);
        final session = await Amplify.Auth.fetchAuthSession(
        );
        if (session.isSignedIn == false) { 
          await Amplify.Auth.signIn(username: 'testaccount1', password: 'Thanhtrung1');
        }
        final orders = await bagRepository.getOrders();
        expect(orders, everyElement(isA<Bag>()));
      });
    });
  });
}