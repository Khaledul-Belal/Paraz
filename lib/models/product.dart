
import 'package:flutter/material.dart';

class Product {
  final int id;
  final String name;
  final double price;
  final IconData icon;
  final Color color;
  final String category;
  final String image;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.icon,
    required this.color,
    required this.category,
    required this.image,
  });
}



const List<Product> sampleProducts = [
  Product(
    id: 1,
    name: 'Smartphone',
    price: 18500,
    icon: Icons.phone_android,
    color: Colors.blue,
    category: 'Electronics',
    image: 'assets/smartphone.png',
  ),
  Product(
    id: 2,
    name: 'Headphones',
    price: 1500,
    icon: Icons.headphones,
    color: Colors.purple,
    category: 'Electronics',
    image: 'assets/headphones.png',
  ),
  Product(
    id: 3,
    name: 'Smart Watch',
    price: 2500,
    icon: Icons.watch,
    color: Colors.teal,
    category: 'Electronics',
    image: 'assets/watch.png',
  ),
  Product(
    id: 4,
    name: 'Running Shoes',
    price: 2200,
    icon: Icons.directions_run,
    color: Colors.orange,
    category: 'Fashion',
    image: 'assets/shoes.png',
  ),
  Product(
    id: 5,
    name: 'Backpack',
    price: 1200,
    icon: Icons.backpack,
    color: Colors.brown,
    category: 'Fashion',
    image: 'assets/backpack.png',
  ),
  Product(
    id: 6,
    name: 'Sunglasses',
    price: 800,
    icon: Icons.remove_red_eye,
    color: Colors.indigo,
    category: 'Fashion',
    image: 'assets/sunglasses.png',
  ),
  Product(
    id: 7,
    name: 'Camera',
    price: 12000,
    icon: Icons.camera_alt,
    color: Colors.green,
    category: 'Electronics',
    image: 'assets/camera.png',
  ),
  Product(
    id: 8,
    name: 'T-Shirt',
    price: 650,
    icon: Icons.checkroom,
    color: Colors.pink,
    category: 'Fashion',
    image: 'assets/tshirt.png',
  ),
];
