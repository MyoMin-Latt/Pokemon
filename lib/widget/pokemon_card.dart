// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/ob/pokemon_ob.dart';
import 'package:pokemon/utlis/app_constant.dart';
import 'package:url_launcher/url_launcher.dart';

class PokenmonCard extends StatelessWidget {
  PokemonOb pokemonOb;
  PokenmonCard(this.pokemonOb, {Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    // print(pokemonOb.variations![0].image!);
    return Card(
      
      child: InkWell(
        onTap: (){
          showDetail(context);
        },
        child: Column(
          children: [
          
            Expanded(
            child: CachedNetworkImage(
              imageUrl: imgUrl+pokemonOb.variations![0].image!,
              progressIndicatorBuilder: (context, url, downloadProgress) => 
                Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),

            ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                pokemonOb.name!,
                style: const TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
}

  showDetail(context){
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(pokemonOb.name!),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(imgUrl+pokemonOb.variations![0].image!, height: 100, width: 100,),
              const Text("Types"),
              Row(
                children: pokemonOb.variations![0].types!.map((e){
                  return Container(
                    child: Text(
                      e
                    ),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(5),
                  );
                }).toList(),
              ),
              Text("Attach : ${pokemonOb.variations![0].stats!.attack!}"),
              Text("Defense : ${pokemonOb.variations![0].stats!.defense!}"),
              TextButton(
                onPressed: ()async{
                  if(await canLaunch(pokemonOb.link!)){
                    await launch(pokemonOb.link!);
                  }
                  else{
                    debugPrint('Cannot launch');
                  }
                }, 
                child: const Text("More Details")
              )
            ]
            ,
          ),
        );
      }
    );
  }
}