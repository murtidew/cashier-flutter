import 'package:flutter/material.dart';
import 'checkout_page.dart';

class CashierPage extends StatefulWidget {
  const CashierPage({super.key});

  @override
  State<CashierPage> createState() => _CashierPageState();
}

class _CashierPageState extends State<CashierPage> {
  List<Map<String, dynamic>> products = [
    {
      "image": "assets/images/cokelatmil.jpg",
      "name": "Cokelat Milshake",
      "price": 20000,
      "stock": 20,
      "quantity": 0,
    },
    {
      "image": "assets/images/mangga.jpg",
      "name": "Manggo Smoothies",
      "price": 25000,
      "stock": 15,
      "quantity": 0,
    },
    {
      "image": "assets/images/matcha.jpg",
      "name": "Matcha Latte",
      "price": 28000,
      "stock": 25,
      "quantity": 0,
    },
    {
      "image": "assets/images/stroberi.jpg",
      "name": "Strawberry Smoothies",
      "price": 20000,
      "stock": 20,
      "quantity": 0,
    },
  ];

  int _totalItem = 0;
  int _totalHarga = 0;

  Future<void> _TambahItemBeli(int index) async {
    setState(() {
      if (products[index]['stock'] > 0) {
        products[index]['stock']--;
        products[index]['quantity']++;
        _totalItem++;
        _totalHarga +=
            (products[index]['price'] as num).toInt(); // Konversi ke int
      } else {
        // If stock is 0, show an alert dialog after the frame is built
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Out of Stock"),
                content: Text(
                    "${products[index]['name']} is out of stock. Please try again later."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the alert dialog
                    },
                    child: const Text("OK"),
                  ),
                ],
              );
            },
          );
        });
      }
    });
  }

  Future<void> _KurangItemBeli(int index) async {
    setState(() {
      if (products[index]['quantity'] > 0) {
        products[index]['stock']++;
        products[index]['quantity']--;
        _totalItem--;
        _totalHarga -=
            (products[index]['price'] as num).toInt(); // Konversi ke int
      }
    });
  }

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 50,
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Cashier App",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const Text(
                  "Semoga Harimu Selalu Menyenangkan :)",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                  width: 10,
                ),
                TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Cari Produk...',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        )),
                  ),
                ),
                // Menambahkan jarak antara form pencarian dan daftar produk
                const SizedBox(height: 20),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 15,
                        );
                      },
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.grey[300],
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "${products[index]['image']}",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    bottomLeft: Radius.circular(8.0),
                                  ),
                                  color: Colors.blueGrey[400],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${products[index]['name']}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            "Stock = ${products[index]['stock']}",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Rp. ${products[index]['price']}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 10,
                                ),
                                child: Row(
                                  children: [
                                    // Tombol Kurang (hanya tampil jika quantity > 0)
                                    Visibility(
                                      visible: products[index]['quantity'] > 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          _KurangItemBeli(index);
                                        },
                                        child: SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: Icon(
                                            Icons.remove_circle_outline_rounded,
                                            color: Colors.red[400],
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Menampilkan quantity produk
                                    SizedBox(
                                      width: 40,
                                      child: Center(
                                        child: Text(
                                          "${products[index]['quantity']}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Tombol Tambah (hanya tampil jika stock > 0)
                                    Visibility(
                                      visible: products[index]['stock'] > 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          _TambahItemBeli(index);
                                        },
                                        child: const SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: Icon(
                                            Icons.add_circle_outline_outlined,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () {
                if (_totalItem > 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckoutPage(
                        cartItems: products
                            .where((product) => product['quantity'] > 0)
                            .toList(),
                        totalHarga: _totalHarga,
                        totalItem: _totalItem,
                      ),
                    ),
                  );
                }
              },
              child: Container(
                margin: const EdgeInsets.all(20),
                height: 55,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total ($_totalItem item) = Rp. $_totalHarga",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
