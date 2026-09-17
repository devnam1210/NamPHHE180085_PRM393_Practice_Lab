import 'dart:async';


class Product {
  int id;
  String name;
  double price;
  Product(this.id, this.name, this.price);
}

class ProductRepository {
  
  Future<List<Product>> getAll() async {
    await Future.delayed(Duration(milliseconds: 10));
    return [Product(1, "Watermelon", 10.0), Product(2, "Apple", 499.99)];
  }
  
  final StreamController<Product> _controller = StreamController<Product>.broadcast();
 
  Stream<Product> liveAdded() => _controller.stream;

  void addProduct(Product p) {
    _controller.sink.add(p);
  }
}

void main() async {
  var repo = ProductRepository();
  repo.liveAdded().listen((p) => print("Stream Update: Thêm mới ${p.name} giá \$${p.price}"));
  
  List<Product> products = await repo.getAll();
  print("Future Data: Có ${products.length} sản phẩm ban đầu.");
  repo.addProduct(Product(3, "Banana", 75.0));
  await Future.delayed(Duration(milliseconds: 100));
  
}