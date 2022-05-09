import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:together_app/model/CartModel.dart';
import 'package:together_app/model/ProdModel.dart';

import '../model/CartItemModel.dart';
import '../model/CategoryModel.dart';
import '../model/Cart.dart';
import '../model/GroupUsersModel.dart';
import '../model/OrderModel.dart';
import '../model/ProdGroupModel.dart';
import '../model/UserList.dart';
import 'func.dart';
import 'package:together_app/utils/globals.dart' as globals;

class APIService {
  Future<UserListResponse> userList(int userId) async {
    String url = "/prods";
    if (userId != 0) url = url + "/" + userId.toString();
    UserListResponse res = new UserListResponse(list: []);

    try {
      final response = await http.get(new Uri.http(globals.apiURL, url));
      //await http.post(Uri.parse(url), headers: headers,body: "");
      if (response.statusCode == 200) {
        final jsonResp = jsonDecode(response.body);
        res = UserListResponse.fromJson(jsonResp);
      }
    } catch (e) {
      //
      print(e.toString());
    } finally {
      globals.showProgress = false;
    }
    return res;
  }

  Future<ProductListResponse> prodList(int prodId) async {
    String url = "/prods";
    if (prodId != 0) url = url + "/" + prodId.toString();
    ProductListResponse res = new ProductListResponse(list: []);

    try {
      final response = await http.get(new Uri.http(globals.apiURL, url));
      //await http.post(Uri.parse(url), headers: headers,body: "");
      if (response.statusCode == 200) {
        final jsonResp = jsonDecode(response.body);
        res = ProductListResponse.fromJson(jsonResp);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      globals.showProgress = false;
    }
    return res;
  }


  Future<bool> createCart(CartModel cart, bool isEdit) async {
    bool result = false;
    String urlProd = "/addCart";
    if (isEdit) urlProd = urlProd + "/" + cart.Cart_ID.toString();

    try {
      var url = Uri.http(globals.apiURL, urlProd);

      var requestMethod = isEdit ? "PUT" : "POST";
      var request = http.MultipartRequest(requestMethod, url);
      final headers = {"Content-type": "application/json;charset=UTF-8"};
      var response;

      if (cart.imageUrl !=null){
        http.MultipartFile multipartFile = await http.MultipartFile.fromPath('imageUrl', cart.imageUrl!,);
        request.files.add(multipartFile);
      }
      if (isEdit)
        response = await http.put(
          new Uri.http(globals.apiURL, urlProd),
          headers: headers,
          body: jsonEncode(<String, String>{
            'Cart_ID': Func.toStr(cart.Cart_ID!),
            'User_ID': globals.userId,
            'status': Func.toStr(cart.status!),
            'User_Fname': cart.User_Fname!,
            'User_Lname': cart.User_Lname!,
            'User_Phone1': Func.toStr(cart.User_Phone1!),
            'User_Email': Func.toStr(cart.User_Email!),
            'line1': Func.toStr(cart.line1!),
            'line2': Func.toStr(cart.line2!),
            'City': cart.City!,
            'province': cart.province!,
            'Country': cart.Country!,
            'content': Func.toStr(cart.province!),
            'imageUrl': Func.toStr(cart.Country!)
          }),
        );
      else
        response = await http.post(
          new Uri.http(globals.apiURL, urlProd),
          headers: headers,
          body: jsonEncode(<String, String>{
            'Cart_ID': Func.toStr(cart.Cart_ID!),
            'User_ID': globals.userId,
            'status': Func.toStr(cart.status!),
            'User_Fname': cart.User_Fname!,
            'User_Lname': cart.User_Lname!,
            'User_Phone1': Func.toStr(cart.User_Phone1!),
            'User_Email': Func.toStr(cart.User_Email!),
            'line1': Func.toStr(cart.line1!),
            'line2': Func.toStr(cart.line2!),
            'City': cart.City!,
            'province': cart.province!,
            'Country': cart.Country!,
            'content': Func.toStr(cart.province!),
            'imageUrl': Func.toStr(cart.Country!)
          }),
        );
      if (response.statusCode == 200) {
        result = true;
      }
    } catch (e) {
      print(e.toString());
    } finally {
      globals.showProgress = false;
    }
    return result;
  }


  Future<CategoryListResponse> categoryList() async {
    String url = "/category";
    CategoryListResponse res = new CategoryListResponse(list: []);

    try {
      final headers = {"Content-type": "application/json;charset=UTF-8"};
      final response = await http.get(new Uri.http(globals.apiURL, url));
      //await http.post(Uri.parse(url), headers: headers,body: "");
      if (response.statusCode == 200) {
        final jsonResp = jsonDecode(response.body);
        res = CategoryListResponse.fromJson(jsonResp);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      globals.showProgress = false;
    }
    return res;
  }

  Future<ProductListResponse> prodByCategoryList(int catId) async {
    String url = "/prodbycategory";
    if (catId != 0) url = url + "/" + catId.toString();
    ProductListResponse res = new ProductListResponse(list: []);

    try {
      final response = await http.get(new Uri.http(globals.apiURL, url));
      //await http.post(Uri.parse(url), headers: headers,body: "");
      if (response.statusCode == 200) {
        final jsonResp = jsonDecode(response.body);
        res = ProductListResponse.fromJson(jsonResp);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      globals.showProgress = false;
    }
    return res;
  }


  Future<ProdGroupResponse> prodGroupList(int prodId) async {
    String url = "/prodGroups";
    if (prodId != 0) url = url + "/" + prodId.toString();
    ProdGroupResponse res = new ProdGroupResponse(list: []);

    try {
      final response = await http.get(new Uri.http(globals.apiURL, url));
      if (response.statusCode == 200) {
        final jsonResp = jsonDecode(response.body);
        res = ProdGroupResponse.fromJson(jsonResp);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      globals.showProgress = false;
    }
    return res;
  }

  Future<GroupUsersResponse> GroupUsersList(int grpId) async {
    String url = "/groupUsers";
    if (grpId != 0) url = url + "/" + grpId.toString();
    GroupUsersResponse res = new GroupUsersResponse(list: []);

    try {
      final response = await http.get(new Uri.http(globals.apiURL, url));
      if (response.statusCode == 200) {
        final jsonResp = jsonDecode(response.body);
        res = GroupUsersResponse.fromJson(jsonResp);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      globals.showProgress = false;
    }
    return res;
  }

  /* Бүтээгдэхүүн хадгалах INSERT, UPDATE 2-лаа хийгдэнэ */
  Future<bool> saveProdInfo(ProductModel prod, bool isEdit) async {
    bool result = false;
    String urlProd = "/saveProd";
    if (isEdit) urlProd = urlProd + "/" + prod.productID.toString();

    try {
      var url = Uri.http(globals.apiURL, urlProd);

      var requestMethod = isEdit ? "PUT" : "POST";
      var request = http.MultipartRequest(requestMethod, url);

/*      if (!isEdit)
        request.fields["User_id"] = globals.userId;
      request.fields["prodcut_title"] = prod.prodcutTitle!;
      request.fields["summary"] = prod.summary!;
      request.fields["product_price"] = Func.toStr(prod.productPrice!);
      request.fields["discount"] = Func.toStr(prod.discount!);
      request.fields["quantity"] = Func.toStr(prod.quantity!);
      request.fields["group_qty"] = Func.toStr(prod.groupQty!);
      request.fields["content"] = prod.content!;
      request.fields["serial_no"] = prod.serialNo!;
      request.fields["image_path"] = prod.imagePath!;
      var response = await request.send();*/
      final headers = {"Content-type": "application/json;charset=UTF-8"};
      var response;

      if (prod.imageUrl !=null){
        http.MultipartFile multipartFile = await http.MultipartFile.fromPath('imageUrl', prod.imageUrl!,);
        request.files.add(multipartFile);
      }
      if (isEdit)
        response = await http.put(
          new Uri.http(globals.apiURL, urlProd),
          headers: headers,
          body: jsonEncode(<String, String>{
            'ProductId': Func.toStr(prod.productID!),
            'CategoryID': Func.toStr(prod.categoryID!),
            'User_ID': globals.userId,
            'prodcut_title': prod.prodcutTitle!,
            'metaTitle': prod.prodcutTitle!,
            'summary': prod.summary!,
            'product_price': Func.toStr(prod.productPrice!),
            'discount': Func.toStr(prod.discount!),
            'quantity': Func.toStr(prod.quantity!),
            'group_qty': Func.toStr(prod.groupQty!),
            'status': "1",
            'content': prod.content!,
            'serial_no': prod.serialNo!,
            'image_url': prod.imageUrl!
          }),
        );
      else
        response = await http.post(
          new Uri.http(globals.apiURL, urlProd),
          headers: headers,
          body: jsonEncode(<String, String>{
            'CategoryID': Func.toStr(prod.categoryID!),
            'User_ID': globals.userId,
            'prodcut_title': prod.prodcutTitle!,
            'metaTitle': prod.prodcutTitle!,
            'summary': prod.summary!,
            'product_price': Func.toStr(prod.productPrice!),
            'discount': Func.toStr(prod.discount!),
            'quantity': Func.toStr(prod.quantity!),
            'group_qty': Func.toStr(prod.groupQty!),
            'status': "1",
            'content': prod.content!,
            'serial_no': prod.serialNo!,
            'image_url': prod.imageUrl!
          }),
        );
      if (response.statusCode == 200) {
        result = true;
      }
    } catch (e) {
      print(e.toString());
    } finally {
      globals.showProgress = false;
    }
    return result;
  }

  /* Хэрэглэгчийн захиалгын жагсаалт авах */
  Future<OrderListResponse> getUserOrder() async {
    String url = "/orders/" + globals.userId;
    OrderListResponse res = new OrderListResponse(list: []);

    try {
      final response = await http.get(new Uri.http(globals.apiURL, url));
      //await http.post(Uri.parse(url), headers: headers,body: "");
      if (response.statusCode == 200) {
        final jsonResp = jsonDecode(response.body);
        res = OrderListResponse.fromJson(jsonResp);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      globals.showProgress = false;
    }
    return res;
  }

  /* Захиалга өгөх буюу INSERT */
  Future<bool> createOrder(OrderModel model) async {
    bool result = false;
    String urlOrder = "/order";

    try {
      var url = Uri.http(globals.apiURL, urlOrder);

      var request = http.MultipartRequest("POST", url);

      final headers = {"Content-type": "application/json;charset=UTF-8"};
      var response = await http.post(
          new Uri.http(globals.apiURL, urlOrder),
          headers: headers,
          body: jsonEncode(<String, String>{
            'User_ID': globals.userId,
            'discount': Func.toStr(model.discount!),
            'ProductID': Func.toStr(model.productID!),
            'quantity': Func.toStr(model.quantity!),
            'grandTotal': Func.toStr(model.grandTotal!)
          }),
        );
      if (response.statusCode == 200) {
        result = true;
      }
    } catch (e) {
      print(e.toString());
    } finally {
      globals.showProgress = false;
    }
    return result;
  }

  /* Захиалга засах буюу UPDATE */
  Future<bool> updateOrder(OrderModel model) async {
    bool result = false;
    String urlOrder = "/order/"+ Func.toStr(model.orderPersonID!);

    try {
      var url = Uri.http(globals.apiURL, urlOrder);
      var request = http.MultipartRequest("PUT", url);
      final headers = {"Content-type": "application/json;charset=UTF-8"};
      var response = await http.post(
        new Uri.http(globals.apiURL, urlOrder),
        headers: headers,
        body: jsonEncode(<String, String>{
          'Order_person_ID': Func.toStr(model.orderPersonID!),
          'User_ID': globals.userId,
          'discount': Func.toStr(model.discount!),
          'ProductID': Func.toStr(model.productID!),
          'quantity': Func.toStr(model.quantity!),
          'grandTotal': Func.toStr(model.grandTotal!)
        }),
      );
      if (response.statusCode == 200) {
        result = true;
      }
    } catch (e) {
      print(e.toString());
    } finally {
      globals.showProgress = false;
    }
    return result;
  }

  /* Захиалга цуцлах буюу DELETE */
  Future<bool> deleteOrder(String orderPersonID) async {
    bool result = false;
    String urlOrder = "/order/"+ Func.toStr(orderPersonID);

    try {
      var url = Uri.http(globals.apiURL, urlOrder);
      var request = http.MultipartRequest("DELETE", url);
      final headers = {"Content-type": "application/json;charset=UTF-8"};
      var response = await http.post(
        new Uri.http(globals.apiURL, urlOrder),
        headers: headers,
        body: jsonEncode(<String, String>{
          'Order_person_ID': orderPersonID
        }),
      );
      if (response.statusCode == 200) {
        result = true;
      }
    } catch (e) {
      print(e.toString());
    } finally {
      globals.showProgress = false;
    }
    return result;
  }


  Future<CartItemListResponse> cartItemList(int id) async {
    String url = "/cart";
    if (id != 0) url = url + "/" + id.toString();
    CartItemListResponse res = new CartItemListResponse(list: []);

    try {
      final response = await http.get(new Uri.http(globals.apiURL, url));
      //await http.post(Uri.parse(url), headers: headers,body: "");
      if (response.statusCode == 200) {
        final jsonResp = jsonDecode(response.body);
        res = CartItemListResponse.fromJson(jsonResp);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      globals.showProgress = false;
    }
    return res;
  }
  Future<bool> addToCart(OrderModel model) async {
    bool result = false;
    String urlOrder = "/addCart";

    try {
      var url = Uri.http(globals.apiURL, urlOrder);

      var request = http.MultipartRequest("POST", url);

      final headers = {"Content-type": "application/json;charset=UTF-8"};
      var response = await http.post(
        new Uri.http(globals.apiURL, urlOrder),
        headers: headers,
        body: jsonEncode(<String, String>{
          'ProductID': Func.toStr(model.productID!)
        }),
      );
      if (response.statusCode == 200) {
        result = true;
      }
    } catch (e) {
      print(e.toString());
    } finally {
      globals.showProgress = false;
    }
    return result;
  }

}
