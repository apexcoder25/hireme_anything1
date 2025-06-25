import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hire_any_thing/data/models/user_side_model/CategoryBannerList.dart';
import 'package:hire_any_thing/data/models/user_side_model/CategoryModel.dart';
import 'package:hire_any_thing/data/models/user_side_model/FAQModels.dart';
import 'package:hire_any_thing/data/models/user_side_model/OffersModel.dart';
import 'package:hire_any_thing/data/models/user_side_model/ServiceListModel.dart';
import 'package:hire_any_thing/data/models/user_side_model/SubcategoryModel.dart';
import 'package:hire_any_thing/data/models/vender_side_model/VendorServiceListModel.dart';

import '../../models/user_side_model/CommenTermsPrivacyAboutusModel.dart';
import '../../models/user_side_model/HomeBannerFirst.dart';

class UserBasicGetxController extends GetxController  {


  HomeBannerFirstList _getHomebannerFirstList =HomeBannerFirstList.fromJson([]);
  HomeBannerFirstList? get getHomebannerFirstList => _getHomebannerFirstList;

  setGetHomebannerFirstList(value){
    _getHomebannerFirstList=HomeBannerFirstList.fromJson(value);
    update();
  }

  HomeFooterBannerFirstList _getHomeFooterbannerFirstList =HomeFooterBannerFirstList.fromJson([]);
  HomeFooterBannerFirstList? get getHomeFooterbannerFirstList => _getHomeFooterbannerFirstList;

  setGetHomeFooterbannerFirstList(value){
    _getHomeFooterbannerFirstList=HomeFooterBannerFirstList.fromJson(value);
    update();

  }

  OffersList _getOffersList =OffersList.fromJson([]);
  OffersList? get getoffersList => _getOffersList;

  setOffersListList(value){
    _getOffersList=OffersList.fromJson(value);
    update();

  }

  CategoryList _getCategoryListList =CategoryList.fromJson([]);
  CategoryList? get getCategoryListList => _getCategoryListList;

  setCategoryList(value){
    _getCategoryListList=CategoryList.fromJson(value);
    update();
  }

  SubcategoryList _getSubcategoryList =SubcategoryList.fromJson([]);
  SubcategoryList? get getSubcategoryList => _getSubcategoryList;
  clearSubCategoryBannerList(){
    _getSubcategoryList.subcategoryList.clear();
    update();
  }

  setSubCategoryList(value){

    _getSubcategoryList=SubcategoryList.fromJson(value);
    update();
  }

  int _homePageNavigation = 0;

  int get homePageNavigation => _homePageNavigation;

  setHomePageNavigation(value){
    _homePageNavigation=value;
    update();
  }


  // CategoryBannerList



  List<CategoryBannerList> _categoryBannerList= <CategoryBannerList>[];

  List<CategoryBannerList> get categoryBannerList => _categoryBannerList;

  clearCategoryBannerList(){
    categoryBannerList.clear();
    update();
  }

  setCategoryBannerList(value){

    value.forEach((value){
      _categoryBannerList.add(CategoryBannerList.fromJson(value));
    });
    update();
  }

  String? _categoryName;

  String? get categoryName => _categoryName;

  setCategoryName(value){
    _categoryName=value;
    update();
  }



  FaqModelsList _getFaqModelsListList =FaqModelsList.fromJson([]);
  FaqModelsList? get getFaqModelsListList => _getFaqModelsListList;

  setFaqModelsListList(value){
    _getFaqModelsListList=FaqModelsList.fromJson(value);
    update();
  }


  CommenTermsPrivacyAboutusModel? _commenTermsPrivacyAboutusModel=CommenTermsPrivacyAboutusModel();

  CommenTermsPrivacyAboutusModel? get commenTermsPrivacyAboutusModel => _commenTermsPrivacyAboutusModel;

  setCommenTermsPrivacyAboutusModel(value){
    _commenTermsPrivacyAboutusModel=CommenTermsPrivacyAboutusModel.fromJson(value);
    update();
  }


  List<ServiceListModel> _getServiceListModel= <ServiceListModel>[];

  List<ServiceListModel> get getServiceListModel => _getServiceListModel;

  setServiceList(data){
    data.forEach((element){
      _getServiceListModel.add(ServiceListModel.fromJson(element));
    });
    update();
  }


  clearServiceList(){
    _getServiceListModel=<ServiceListModel>[];
    update();
  }


  ServiceListModel _getServiceSeriveDetailSingle= ServiceListModel();

  ServiceListModel get getServiceSeriveDetailSingle => _getServiceSeriveDetailSingle;

  setServiceSeriveDetailSingle(data){
    _getServiceSeriveDetailSingle=data;
    update();
  }

// CategoryList

}





