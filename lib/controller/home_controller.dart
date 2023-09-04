import 'package:get/get.dart';
import 'package:uol_new/model/add_banner.dart';
import 'package:uol_new/model/best_seller_product.dart';
import 'package:uol_new/model/category.dart';
import 'package:uol_new/model/popular_product.dart';
import 'package:uol_new/service/remote_banner_service.dart';
import 'package:uol_new/service/remote_best_seller_product_service.dart';
import 'package:uol_new/service/remote_category_services.dart';
import 'package:uol_new/service/remote_popular_product_service.dart';


class HomeController extends GetxController{
  static HomeController instance = Get.find();
  RxList<AdBanner> bannerList = List<AdBanner>.empty(growable: true).obs;
  RxList<CategoryList> categoryList = List<CategoryList>.empty(growable:true).obs;
  RxList<PopularProductList> popularProductsList = List<PopularProductList>.empty(growable:true).obs;
  RxList<BestSellerProducttList> bestSellerProductsList = List<BestSellerProducttList>.empty(growable:true).obs;
  RxBool isBannerLoading = false.obs;
  RxBool isCategoryLoading = false.obs;
  RxBool isPopularProductLoading = false.obs;

  @override
  void onInit() async {
    getAdBanners();
    getCategories();
    getPopularProducts();
    getBestSellerProducts();
    super.onInit();
  }

  void getAdBanners() async {
    try{
      isBannerLoading(true);
      var result = await RemoteBannerService().get();
      if (result != null) {
        bannerList.assignAll(adBannerListFromJson(result.body));
      }
    } finally {
      isBannerLoading(false);
    }
  }

  void getCategories() async {
    try{
      isCategoryLoading(true);
      var result = await RemoteCategoryService().get();
      if (result != null){
        categoryList.assignAll(categoryListFromJson(result.body));
      }
    } finally {
      isCategoryLoading(false);
    }
  }

  void getPopularProducts() async {
    try{
      isPopularProductLoading(true);
      var result = await RemotePopularProductService().get();
      if (result != null){
        popularProductsList.assignAll(popularProductListFromJson(result.body));
      }
    } finally {
      isPopularProductLoading(false);
    }
  }

  void getBestSellerProducts() async {
    try{
      isPopularProductLoading(true);
      var result = await RemoteBestSellerProductService().get();
      if (result != null){
        bestSellerProductsList.assignAll(bestSellerProductListFromJson(result.body));
      }
    } finally {
      isPopularProductLoading(false);
    }
  }
}