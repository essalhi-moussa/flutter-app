import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/modules/counter/cubit/states.dart';

class CounterCubit extends Cubit<CounterStates>
{
  int counter = 1;
  CounterCubit() : super(CounterInitialState());

  static CounterCubit get(context) => BlocProvider.of(context);

  void minus(){
    counter--;
    emit(CounterMinusState(counter));
  }
  void plus(){
    counter++;
    emit(CounterPlusState(counter ));
  }

}