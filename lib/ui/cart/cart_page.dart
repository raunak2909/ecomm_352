import 'package:ecomm_352/ui/product_detail/bloc/cart_bloc.dart';
import 'package:ecomm_352/ui/product_detail/bloc/cart_event.dart';
import 'package:ecomm_352/ui/product_detail/bloc/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int quantity = 1;

  @override
  initState() {
    super.initState();
    context.read<CartBloc>().add(FetchCartEvent());
  }

  Widget buildCartItem({
    required int qty,
    required String image,
    required String title,
    String category = "",
    required double price,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            //child: Image.asset(image, width: 60, height: 60),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 13.5,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Icon(Icons.delete_outline, color: Color(0xffff650e)),
                  ],
                ),
                Text(
                  category,
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${price.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (quantity > 1) quantity--;
                              });
                            },
                            child: Icon(Icons.remove, size: 18),
                          ),
                          SizedBox(width: 12),
                          Text(
                            qty.toString(),
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 12),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            child: Icon(Icons.add, size: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(Icons.chevron_left, color: Colors.black,size:30,),
            ),
          ),
        ),
        centerTitle: true,
        title: Text("My Cart", style: TextStyle(color: Colors.black, fontFamily: "Poppins", fontWeight: FontWeight.w700, fontSize: 18)),
      ),
      body: BlocBuilder<CartBloc, CartState>(builder: (_, state){
        if(state is CartLoadingState){
          return Center(child: CircularProgressIndicator(),);
        }

        if(state is CartLoadedState){
          return state.mCartList != null && state.mCartList!.isNotEmpty ? Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.mCartList!.length,
                  itemBuilder: (_, index){
                    return buildCartItem(
                      image: state.mCartList![index].image!,
                      title: state.mCartList![index].name!,
                      price: double.parse(state.mCartList![index].price!),
                      qty: state.mCartList![index].quantity!,
                    );
                  },
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 45,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Enter Discount Code",
                                hintStyle: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Apply",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                color: Color(0xffff650e),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Subtotal",
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "\$245.00",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "\$245.00",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffff650e),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          "Checkout",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ) : Center(child: Text("Cart is empty"),);
        }

        if(state is CartErrorState){
          return Center(child: Text(state.errorMsg),);
        }

        return Container();
      })
    );
  }
}
