import 'package:bloc/bloc.dart';
import 'package:commy/viewmodel/database/network/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../database/network/end_points.dart';

part 'speech_state.dart';

class SpeechCubit extends Cubit<SpeechState> {
  static SpeechCubit get(context)=>BlocProvider.of(context);
  SpeechCubit() : super(SpeechInitial());
  Future speechtotext()async{
    DioHelper.postData(url: speechEndPoint,data:{
       
        "name":"x"
    } ).then((value) => {
      print(value.data),print(value.statusCode)
    });
  }
}
