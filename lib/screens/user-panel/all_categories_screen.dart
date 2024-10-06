import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loot_bazar/models/categories_model.dart';
import 'package:loot_bazar/utils/app_constant.dart';
import 'package:loot_bazar/widgets/product_widget.dart';

class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({super.key});

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstant.appBackgroundColor,
        appBar: AppBar(
            backgroundColor: AppConstant.appMainColor,
            title: const Text(
              "All Categories",
              style: TextStyle(
                color: AppConstant.appWhiteColor,
              ),
            ),
            iconTheme:
                const IconThemeData(color: AppConstant.appWhiteColor, size: 30),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () => Navigator.of(context).pop())),
        body: FutureBuilder(
            future: FirebaseFirestore.instance.collection('category').get(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapShot) {
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
                return GridView.builder(
                    itemCount: snapShot.data!.docs.length,
                    shrinkWrap: true,
                    physics: const  BouncingScrollPhysics(),
                    gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 30,
                        crossAxisSpacing: 20,
                        childAspectRatio: .8),
                    itemBuilder: (context, index) {
                      CategoriesModel categoriesModel = CategoriesModel(
                        categoryId: snapShot.data!.docs[index]['categoryId'],
                        categoryImage: snapShot.data!.docs[index]
                            ['categoryImage'],
                        categoryName: snapShot.data!.docs[index]
                            ['categoryName'],
                        createdAt: snapShot.data!.docs[index]['createdAt'],
                        updatedAt: snapShot.data!.docs[index]['updatedAt'],
                      );
                      return ProductWidget(
                          categoryImage: categoriesModel.categoryImage,
                          categoryName: categoriesModel.categoryName,
                          height: 4.5,
                          width: 2.5);
                    });
              }

              return Container();
            }));
  }
}
