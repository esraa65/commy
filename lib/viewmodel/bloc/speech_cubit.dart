import 'package:bloc/bloc.dart';
import 'package:commy/model/speechmodel.dart';
import 'package:commy/viewmodel/database/network/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../database/network/end_points.dart';

part 'speech_state.dart';

class SpeechCubit extends Cubit<SpeechState> {
  static SpeechCubit get(context)=>BlocProvider.of(context);
  OutputText?outputtext;
   String ?sentance;
  SpeechCubit() : super(SpeechInitial());
  Future speechtotext()async{
  await  DioHelper.postData(url: speechEndPoint,data:{
        "text": sentance?.toLowerCase(),
    } ).then((value) => {
      print(value.data),
        if(value.statusCode == 200){
          print('successful ya bakii'),
          outputtext=OutputText.fromJson(value.data)
        }
    }) .catchError((erorr) {
      print(erorr);
    });
  }
}
//
