import 'package:eccomerce_frontend/core/constants/constants.dart';
import 'package:eccomerce_frontend/core/routes/route_constants.dart';
import 'package:eccomerce_frontend/features/home/presentation/providers/product_providers.dart';
import 'package:eccomerce_frontend/features/home/presentation/providers/state/product_state.dart';
import 'package:eccomerce_frontend/features/home/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
            height: 170,
            child: Center(child: Text("Keep Sliding Images Here")),
          ),
          Divider(
            thickness: 2.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.pad8),
            child: Column(
              children: [
                productFilterRow(filterCategory: 'Recently Added',
                onTap:  (){
                  context.goNamed(RouteConstants.productScreen);
            }),
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
                ),
              ],
            ),
          )
          
        ],
      ),
    );
  }
  Widget productFilterRow({
    required String filterCategory,
    void Function()? onTap,
  }){
    return Padding(
      padding: const EdgeInsets.symmetric(
      horizontal:AppConstants.pad4,
      vertical: AppConstants.pad4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(filterCategory),
          InkWell(
            onTap:onTap
            ,child: Text('View All'))
        ],
      ),
    );
  }
}