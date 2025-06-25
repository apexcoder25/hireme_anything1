
import 'package:get/get.dart';
import 'package:hire_any_thing/data/models/user_side_model/ServiceListModel.dart';
import 'package:hire_any_thing/data/models/vender_side_model/CommonForTermsPrivacyContactUsAndAboutUs.dart';
import 'package:hire_any_thing/data/models/vender_side_model/ContactUsModel.dart';
import 'package:hire_any_thing/data/models/vender_side_model/ServiceListMode.dart';
import 'package:hire_any_thing/data/models/vender_side_model/VendorDashboardDataModel.dart';
import 'package:hire_any_thing/data/models/vender_side_model/VendorServiceListModel.dart';
import 'package:hire_any_thing/data/models/vender_side_model/VendorSideDetailsModel.dart';

import '../../models/vender_side_model/CategoryModel.dart';
import '../../models/vender_side_model/SubcategoryModel.dart';

class VenderSidetGetXController extends GetxController {

  VendorSideDetailsModel _vendorSideDetailsModel=VendorSideDetailsModel();

  VendorSideDetailsModel get vendorSideDetailsModel => _vendorSideDetailsModel;

  setVendorSideDetailsModel(data){
    _vendorSideDetailsModel=VendorSideDetailsModel.fromJson(data);
    update();
  }


  String? _initalvalue;

  String? get initalvalue => _initalvalue;

  setinitalvalue(value){
    _initalvalue=value;
    update();
  }

  CategoryList _getCategoryList =CategoryList.fromJson([]);
  CategoryList? get getCategoryList => _getCategoryList;

  setCategoryList(value){
    _getCategoryList=CategoryList.fromJson(value);

    _initalvalue=_getCategoryList.subcategoryList[0].categoryId.toString();

    update();
  }

  String? _initalvalueSubCategory;

  String? get initalvalueSubCategory => _initalvalueSubCategory;

  setinitalSubCategoryvalue(value){
    _initalvalueSubCategory=value;
    update();
  }


  // SubCategoryList _getSubCategoryList =SubCategoryList.fromJson([]);
  // SubCategoryList? get getSubCategoryList => _getSubCategoryList;

  List<SubcategoryModel>_getSubCategoryList =<SubcategoryModel>[];
  List<SubcategoryModel>? get getSubCategoryList => _getSubCategoryList;

  setSubCategoryList(value){
    getSubCategoryList?.clear();
    // _getSubCategoryList=SubCategoryList.fromJson(value);
    value.forEach((element) {
      _getSubCategoryList.add( SubcategoryModel.fromJson(element) );
    });
    if(getSubCategoryList!.isNotEmpty){
      _initalvalueSubCategory=getSubCategoryList![0].subcategoryId;

    }
    update();
  }
  // clearSubCategoryList(){
  //   getSubCategoryList?.subcategoryList.clear();
  //     update();
  // }


  int _selectedIndexVenderHomeNavi = 0;

  int get selectedIndexVenderHomeNavi => _selectedIndexVenderHomeNavi;

  setselectedIndexVenderHomeNavi(int value){
    _selectedIndexVenderHomeNavi=value;
    update();
  }

  VendorServiceList _getServiceList =VendorServiceList.fromJson([]);
  VendorServiceList? get getServiceList => _getServiceList;

  setServiceList(value){
    _getServiceList=VendorServiceList.fromJson(value);
    update();
  }

  VendorServiceListModel _getVendorServiceSingleDetail= VendorServiceListModel();

  VendorServiceListModel get getVendorServiceSingleDetail => _getVendorServiceSingleDetail;

  setVendorServiceSingleDetail(value){
    _getVendorServiceSingleDetail=value;
    update();
  }

  VendorDashboardDataModel _getVendorDashboardDataModelDetail= VendorDashboardDataModel();

  VendorDashboardDataModel get getVendorDashboardDataModelDetail => _getVendorDashboardDataModelDetail;

  setVendorDashboardDataModelDetail(value){
    _getVendorDashboardDataModelDetail=VendorDashboardDataModel.fromJson(value);
    update();
  }

  CommonForTermsPrivacyContactUsAndAboutUs _getCommonForTermsPrivacyContactUsAndAboutUs= CommonForTermsPrivacyContactUsAndAboutUs();

  CommonForTermsPrivacyContactUsAndAboutUs get getCommonForTermsPrivacyContactUsAndAboutUs => _getCommonForTermsPrivacyContactUsAndAboutUs;

  setCommonForTermsPrivacyContactUsAndAboutUs(value){
    _getCommonForTermsPrivacyContactUsAndAboutUs=CommonForTermsPrivacyContactUsAndAboutUs.fromJson(value);
    update();
  }

  ContactUsModel _getContactUsModel= ContactUsModel();

  ContactUsModel get getContactUsModel => _getContactUsModel;

  setContactUsModel(value){
    _getContactUsModel=ContactUsModel.fromJson(value);
    update();
  }




// ServiceList

}