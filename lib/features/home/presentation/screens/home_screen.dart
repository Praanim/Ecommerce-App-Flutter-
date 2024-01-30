import 'package:eccomerce_frontend/features/home/presentation/providers/product_providers.dart';
import 'package:eccomerce_frontend/features/home/presentation/providers/state/product_state.dart';
import 'package:eccomerce_frontend/features/home/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Keep Search Bar here"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 200,
            child: Center(child: Text("Keep Sliding Images Here")),
          ),
          Divider(
            thickness: 2.0,
          ),
          SizedBox(
            height: 250,
            child: Consumer(builder: (context, ref, child) {
              final state = ref.watch(productNotifierProvider);
              
              if(state is ProductSuccess){
                return ListView.builder(
                  scrollDirection: Axis.horizontal
                  ,itemCount: state.products.length,
                itemBuilder:(context, index) {
                 final product = state.products[index]; 
                 return ProductCard(product: product);
                } ,);
              }else if(state is ProductFailure){
                return Text(state.appException.identifier);
              }else{
                //TODO:make it common widget
                return const CircularProgressIndicator();
            
              }
            },),
          )
          
        ],
      ),
    );
  }
}