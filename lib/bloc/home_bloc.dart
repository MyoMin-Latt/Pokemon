import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokemon/ob/pokemon_ob.dart';
import 'package:pokemon/ob/response_ob.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon/utlis/app_constant.dart';

class HomeBloc{
  StreamController<ResponseOb> _controller = StreamController<ResponseOb>();
  Stream<ResponseOb> getPokemonStream() => _controller.stream;

   
  getData()async{
    ResponseOb respOb = ResponseOb(msgState: MsgState.loading);
    _controller.sink.add(respOb);
    var response = await http.get(Uri.parse(baseUrl));
    debugPrint(response.statusCode.toString());
 
    if(response.statusCode==200){
      List<dynamic> list = jsonDecode(response.body);
      List<PokemonOb> pmList = [];
      for (var element in list) {
        pmList.add(PokemonOb.fromJson(element));
      }
      respOb.msgState = MsgState.data;
      respOb.data = pmList;
      _controller.sink.add(respOb);
    }
    else if(response.statusCode == 500){
      respOb.msgState = MsgState.error;
      respOb.errState = ErrState.serverErr;
      _controller.sink.add(respOb);
    }
    else if(response.statusCode ==404){
      respOb.msgState = MsgState.error;
      respOb.errState = ErrState.noFoundErr;
      _controller.sink.add(respOb);
    }
    else{
      respOb.msgState = MsgState.other;
      respOb.errState = ErrState.noFoundErr;
      _controller.sink.add(respOb);
    }
  }
  dispose(){
    _controller.close();
  }

}