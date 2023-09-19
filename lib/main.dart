import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_connection/ios_channel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String result = 'null';
  int time = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'MethodChannel Result:',
            ),
            Text(
              result,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Processing Time[μs]:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.deepOrange
              ),
            ),
            Text(
              time.toString(),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.deepOrange
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final watch = Stopwatch();
                watch.start();
                result = 'onPressed';
                watch.stop();
                time = watch.elapsed.inMicroseconds;
                setState(() {});
              },
              child: const Text('onPressed'),
            ),
            ElevatedButton(
              onPressed: () async {
                final watch = Stopwatch();
                watch.start();
                try {
                  final result = await IOSMethodChannel.getBatteryLevel();
                  this.result = result.toString();
                } on PlatformException catch (e) {
                  result = e.message ?? 'PlatformException';
                } catch (e) {
                  result = e.toString();
                }
                watch.stop();
                time = watch.elapsed.inMicroseconds;
                setState(() {});
              },
              child: const Text('BatteryLevel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final watch = Stopwatch();
                watch.start();
                try {
                  final result = await IOSMethodChannel.getSimpleString();
                  this.result = result.toString();
                } on PlatformException catch (e) {
                  result = e.message ?? 'PlatformException';
                } catch (e) {
                  result = e.toString();
                }
                watch.stop();
                time = watch.elapsed.inMicroseconds;
                setState(() {});
              },
              child: const Text('SimpleString'),
            ),
            ElevatedButton(
              onPressed: () async {
                final watch = Stopwatch();
                watch.start();
                try {
                  final result = await IOSMethodChannel.getSimpleBool();
                  this.result = result.toString();
                } on PlatformException catch (e) {
                  result = e.message ?? 'PlatformException';
                } catch (e) {
                  result = e.toString();
                }
                watch.stop();
                time = watch.elapsed.inMicroseconds;
                setState(() {});
              },
              child: const Text('SimpleBool'),
            ),
            ElevatedButton(
              onPressed: () async {
                final watch = Stopwatch();
                watch.start();
                try {
                  final result = await IOSMethodChannel.getSimpleMap();
                  this.result = result.toString();
                } on PlatformException catch (e) {
                  result = e.message ?? 'PlatformException';
                } catch (e) {
                  result = e.toString();
                }
                watch.stop();
                time = watch.elapsed.inMicroseconds;
                setState(() {});
              },
              child: const Text('SimpleMap'),
            ),
          ],
        ),
      ),
    );
  }
}
