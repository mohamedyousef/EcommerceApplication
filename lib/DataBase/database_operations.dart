import 'dart:async';
import 'package:ecommerceApp/Models/product.dart';
import 'package:ecommerceApp/Models/settings.dart';
import 'package:ecommerceApp/Models/shipping_biilling.dart';
import 'package:ecommerceApp/Models/variation.dart';
import 'package:ecommerceApp/Models/wishlist_models/board.dart';
import 'file:///D:/MyWork/Work/programming/APPS/Ecommerce%20App/code/ecommerceApp/lib/Models/notification/NotificationModel.dart';
import 'package:sembast/sembast.dart';
import 'data_op.dart';

class DataOP {
  final _favourite = intMapStoreFactory.store("favourite");
  final _boards = intMapStoreFactory.store("boards");
  final _userSettings = intMapStoreFactory.store("settings");
  final _recent = intMapStoreFactory.store("recent");
  final _recentView = intMapStoreFactory.store("recentView");
  final _addressBook = intMapStoreFactory.store("addressBook");
  final _notifications = intMapStoreFactory.store("notifications");

  void data()async{
    _boards.drop(await _db);
  }
  Future<Database> get _db async => await AppDatabase.instance.database;

  insertAddressBook(Ing shipping, {bool isdefault}) async {
    if (isdefault)
      _addressBook.update(await _db, {"isDefault": false},
          finder: Finder(filter: Filter.equals("isDefault", true)));

    return _addressBook.add(await _db, shipping.toJson(isdefault: isdefault));
  }

  updateAddressBook(Ing shipping, {bool isdefault}) async {
    if (isdefault)
     await _addressBook.update(await _db, {"isDefault": false}, finder: Finder(filter: Filter.equals("isDefault", true)));

    await _addressBook.update(await _db, shipping.toJson(isdefault: isdefault),
        finder: Finder(filter: Filter.byKey(shipping.id)));

  }

  insertItemToRecentSearch(String searchKey) async {
    _recent.add(await _db, {"key": searchKey});
  }

  insertItemToRecentView(Product product) async {
   // final record = await _recentView.findFirst(await _db,finder: ));
     await _recentView.delete(await _db,finder:Finder(filter: Filter.equals("id", product.id)));

//    if();

     _recentView.add(await _db, product.toJson());
//    int count = await _recentView.count(await _db);
//    if(count>10)
//    _recentView.delete(_db,)
  }

  Future<bool> hasWishList() async {
    int count = await _favourite.count(await _db);
    count += await _boards.count(await _db);
    return count > 0;
  }

//
//  Stream<RecordSnapshot<int,Map<String,dynamic>>> listenToRecentView()async*{
//   yield* _recentView.stream(await _db,filter:Filter.byKey("time"));
//  }

  final recentView = StreamTransformer<
      List<RecordSnapshot<int, Map<String, dynamic>>>,
      List<Product>>.fromHandlers(handleData: (snapshotList, sink) {
    List<Product>data = List();
    for(var item in snapshotList) {
      final product = Product.fromJson(item.value);
      // An ID is a key of a record from the database.
      product.localID = item.key;
      data.add(product);
    }
    sink.add(data);
  });

  Stream<List<Product>> getRecentView() async* {
//    final recordSnapshots = await _recentView.find(await _db,
//        finder: Finder(
//           // filter: Filter.byKey("timeRecent"),
//            limit: 10));
    yield*    _recentView.query(finder:Finder(
      limit: 10,
      sortOrders: [
        SortOrder(
            "timeRecent",
          false
        )
      ]
    )).onSnapshots(await _db)
        .transform(recentView);

    // Making a List<Fruit> out of List<RecordSnapshot>

  }

  Future<List<String>> getAllRecentSearch() async {
    final recordSnapshots = await _favourite.find(
      await _db,
    );

    // Making a List<Fruit> out of List<RecordSnapshot>
    return recordSnapshots.map((snapshot) {
      final rest = snapshot.value["key"];
      return rest;
    }).toList();
  }

  Future<int>countRecent()async{
    return await _recentView.count(await _db);
  }
  Future<bool> checkProductFAV(int productID) async {
    bool result;
    final finder = Finder(filter: Filter.equals("id", productID));
    await _favourite.findKey(await _db, finder: finder).then((onvalue) async {
      if (onvalue == null) {
        result = true;
      } else {
        result = false;
      }
    });

    print(result);
    return result;
  }

  Future<bool> addProductToFAV(Product product) async {
    bool res = false;
    checkProductFAV(product.id).then((value) async {
      if (value)
        _favourite.add(await _db, product.toJson());
      else {
        _favourite.delete(await _db,
            finder: Finder(filter: Filter.equals("id", product.id)));
      }

      res = true;
    });
    return res;
  }

  Future deleteProductFromFav(int id) async {
    _favourite.delete(await _db, finder: Finder(filter: Filter.byKey(id)));
  }

  Future<int> deleteAddress(int id) async {
    return await _addressBook.delete(await _db,
        finder: Finder(filter: Filter.byKey(id)));
  }

  Stream<List<Product>> getAllProducts() async* {
    final recordSnapshots = await _favourite.find(
      await _db,
    );
    // Making a List<Fruit> out of List<RecordSnapshot>
    // print(Product.fromJson(products[0].value));

    yield recordSnapshots.map((snapshot) {
      final rest = Product.fromJson(snapshot.value);
      // An ID is a key of a record from the database.
      rest.localID = snapshot.key;
      return rest;
    }).toList();
  }


  var boardsTransformer = StreamTransformer<
      List<RecordSnapshot<int, Map<String, dynamic>>>,
      List<Board>>.fromHandlers(handleData: (snapshotList, sink) {
    List<Board>data = List();
    for(var item in snapshotList) {
      print(Board.fromJson(item.value).toJson());

      Board board = Board.fromJson(item.value);
      board.id = item.key;

      data.add(board);
    }
    sink.add(data);
  });

  Stream<List<Board>> getAllBoards() async* {
    yield*    _boards.query().onSnapshots(await _db)
        .transform(boardsTransformer);
  }



  var streamTransformer = StreamTransformer<
      List<RecordSnapshot<int, Map<String, dynamic>>>,
      List<Ing>>.fromHandlers(handleData: (snapshotList, sink) {
        List<Ing>data = List();
        for(var item in snapshotList) {
          Ing ing = Ing.fromJson(item.value);
          ing.id = item.key;
          data.add(ing);
        }
        sink.add(data);
  });


  Stream<List<Ing>> getAllAddressFromDataBase()async*{
    yield*    _addressBook.query().onSnapshots(await _db)
        .transform(streamTransformer);
  }

  saveBoard(Board board) async {
    return _boards.add(await _db, board.toJson());
  }

  deleteBoard(int id)async{
    return _boards.delete(await _db,finder: Finder(filter: Filter.byKey(id)));
  }

  updateBoard(int id,Product product)async{
    final record =  await _boards.record(id).get(await _db);
    Board board = Board.fromJson(record);
    if(board.productsIds!=null&&board.productsIds.isNotEmpty)
      board.productsIds.removeWhere((element) => element.id==product.id);
    if(board.images!=null&&board.images.isNotEmpty)
    board.images.removeWhere((element) => element==product.images[0].src);

    board.productsIds.add(product);
    board.images.add(product.images[0].src);
    return _boards.record(id).update(await  _db, board.toJson());
  }
  removeFromBoard(Board board)async{
     return _boards.record(board.id).update(await  _db, board.toJson());
  }

  Future<void> saveUserSettings(UserSettings userSettings) async {
    _userSettings.delete(await _db,
        finder: Finder(filter: Filter.equals("id", 0)));
    _userSettings.add(await _db, userSettings.toJson());
  }

  Future<UserSettings> getSettings() async {
    UserSettings userSettings;

    final recordSnapshots = await _userSettings.find(
      await _db,
    );
    try {
      recordSnapshots.map((snapshot) {
        final rest = UserSettings.fromJson(snapshot.value);
        // An ID is a key of a record from the database.
        rest.id = snapshot.key;
        userSettings = rest;
      }).toList()[0];
    } catch (e) {}
    return userSettings;
  }

  void addNotification(NotificationModel notificationModel) async{
    _notifications.add(await _db, notificationModel.toMap());
  }
}
