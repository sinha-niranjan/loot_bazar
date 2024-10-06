import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loot_bazar/models/categories_model.dart';
import 'package:loot_bazar/utils/app_constant.dart';
import 'package:loot_bazar/widgets/product_widget.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('category').get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapShot) {
          if (snapShot.hasError) {
            return const Center(
                child: Row(
              children: [Text("Error"), Icon(Icons.error)],
            ));
          }

          if (snapShot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: Get.height / 5,
              child: const Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }

          if (snapShot.data!.docs.isEmpty) {
            return const Center(
                child: Row(
              children: [Text("No category found!"), Icon(Icons.android)],
            ));
          }
          if (snapShot.data != null) {
            return Container(
              height: Get.height / 5.5,
              child: ListView.builder(
                  itemCount: snapShot.data!.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    CategoriesModel categoriesModel = CategoriesModel(
                      categoryId: snapShot.data!.docs[index]['categoryId'],
                      categoryImage: snapShot.data!.docs[index]
                          ['categoryImage'],
                      categoryName: snapShot.data!.docs[index]['categoryName'],
                      createdAt: snapShot.data!.docs[index]['createdAt'],
                      updatedAt: snapShot.data!.docs[index]['updatedAt'],
                    );
                    return ProductWidget(
                        categoryImage: categoriesModel.categoryImage,
                        categoryName: categoriesModel.categoryName,
                        height: 7,
                        width: 3);
                  }),
            );
          }

          return Container();
        });
  }
}
