import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon/bloc/home_bloc.dart';
import 'package:pokemon/ob/pokemon_ob.dart';
import 'package:pokemon/ob/response_ob.dart';
import 'package:pokemon/utlis/app_constant.dart';
import 'package:pokemon/widget/pokemon_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _bloc = HomeBloc();

  @override
  void initState() {
    _bloc.getData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokemon App"),
      ),
      body: StreamBuilder<ResponseOb>(
        stream: _bloc.getPokemonStream(),
        initialData: ResponseOb(msgState: MsgState.loading),
        builder: (BuildContext context, AsyncSnapshot<ResponseOb> snapshot){
          ResponseOb? respOb = snapshot.data;
          if(respOb!.msgState == MsgState.data){
            List<PokemonOb> pmList = respOb.data;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2
              ),
              itemCount: pmList.length,
              itemBuilder: (context, index){
                return PokenmonCard(pmList[index]);
              }
            );

          }
          else if (respOb.msgState == MsgState.error){
            if(respOb.errState == ErrState.serverErr){
              return const Center(
                child: Text("500\nServer Error"),
              );
            }
            else if(respOb.errState == ErrState.noFoundErr){
              return const Center(
                child: Text("404\nPage not found"),
              );
            }
            else{
              return const Center(
                child: Text("Unknow Error"),
              );
            }
          }
          else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          
        
        },
      )
    );
  }
}

