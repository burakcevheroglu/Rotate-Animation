import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final rotateProvider = StateProvider<bool>((ref) => false);
final rotateDegreeProvider = StateProvider<int>((ref) => 10);

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(ref.watch(rotateDegreeProvider).toString()+" degree"),
        backgroundColor: Colors.green,
      ),
      body: Center(child:
        SizedBox(
          width: double.infinity,
          height: 450,
          child: Column(
            children: [
              RotationTransition(
                turns: AlwaysStoppedAnimation(ref.watch(rotateDegreeProvider)/360),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    boxShadow: const [ BoxShadow(
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                      blurRadius: 60,
                    )]
                  ),
                  child: Container(
                    width: 350,
                    height: 350,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(1000),
                      border: Border.all(
                          color: Colors.black,
                          width: 5
                      ),
                      image: const DecorationImage(
                          image: NetworkImage('https://upload.wikimedia.org/wikipedia/en/b/bb/Skrillex_-_Bangarang_%28EP%29.png'),
                          fit: BoxFit.fill
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1000),
                            boxShadow:   [
                              BoxShadow(
                                color: Colors.grey.shade500
                              ),
                              const BoxShadow(
                                color: Colors.white60,
                                spreadRadius: -30.0,
                                blurRadius: 12.0,
                              ),
                            ],
                            border: Border.all(
                                color: Colors.black,
                                width: 15
                            )
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50,),
              ElevatedButton(onPressed: (){
                ref.read(rotateProvider.notifier).update((state) => !state);
                print(ref.read(rotateProvider));

                final periodicTimer = Timer.periodic(
                  const Duration(milliseconds: 20),
                      (timer) {
                    ref.read(rotateDegreeProvider.notifier).update((state) => state+1);
                    if(ref.read(rotateDegreeProvider)>=360){
                      ref.read(rotateDegreeProvider.notifier).update((state) => state-360);
                    }
                    if(!ref.read(rotateProvider)) timer.cancel();
                  },
                );

                if(ref.read(rotateProvider)){
                  periodicTimer;
                }
                else{
                  periodicTimer.cancel();
                }
              }, child: !ref.watch(rotateProvider) ? const Text('Rotate') : const Text('Stop'))
            ],
          ),
        )
      ),
    );
  }
}
