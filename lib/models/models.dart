class Person {
  final int id;
  final String firstName;
  final String lastName;
  final String maidenName;
  final int age;
  final String gender;
  final String email;
  final String phone;
  final String username;
  final String password;
  final String birthDate;
  final String image;
  final String bloodGroup;
  final double height;
  final double weight;
  final String eyeColor;
  final Hair hair;
  final String domain;
  final String ip;
  final Address address;
  final String macAddress;
  final String university;
  final Bank bank;
  final Company company;
  final String ein;
  final String ssn;
  final String userAgent;

  Person({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.maidenName,
    required this.age,
    required this.gender,
    required this.email,
    required this.phone,
    required this.username,
    required this.password,
    required this.birthDate,
    required this.image,
    required this.bloodGroup,
    required this.height,
    required this.weight,
    required this.eyeColor,
    required this.hair,
    required this.domain,
    required this.ip,
    required this.address,
    required this.macAddress,
    required this.university,
    required this.bank,
    required this.company,
    required this.ein,
    required this.ssn,
    required this.userAgent,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'maidenName': maidenName,
      'age': age,
      'gender': gender,
      'email': email,
      'phone': phone,
      'username': username,
      'password': password,
      'birthDate': birthDate,
      'image': image,
      'bloodGroup': bloodGroup,
      'height': height,
      'weight': weight,
      'eyeColor': eyeColor,
      'hair': hair.toJson(),
      'domain': domain,
      'ip': ip,
      'address': address.toJson(),
      'macAddress': macAddress,
      'university': university,
      'bank': bank.toJson(),
      'company': company.toJson(),
      'ein': ein,
      'ssn': ssn,
      'userAgent': userAgent,
    };
  }

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      maidenName: json['maidenName'],
      age: json['age'],
      gender: json['gender'],
      email: json['email'],
      phone: json['phone'],
      username: json['username'],
      password: json['password'],
      birthDate: json['birthDate'],
      image: json['image'],
      bloodGroup: json['bloodGroup'],
      height: json['height'].toDouble(),
      weight: json['weight'].toDouble(),
      eyeColor: json['eyeColor'],
      hair: Hair.fromJson(json['hair']),
      domain: json['domain'],
      ip: json['ip'],
      address: Address.fromJson(json['address']),
      macAddress: json['macAddress'],
      university: json['university'],
      bank: Bank.fromJson(json['bank']),
      company: Company.fromJson(json['company']),
      ein: json['ein'],
      ssn: json['ssn'],
      userAgent: json['userAgent'],
    );
  }
}

class Hair {
  final String color;
  final String type;

  Hair({required this.color, required this.type});

  Map<String, dynamic> toJson() {
    return {
      'color': color,
      'type': type,
    };
  }

  factory Hair.fromJson(Map<String, dynamic> json) {
    return Hair(
      color: json['color'],
      type: json['type'],
    );
  }
}

class Address {
  final String address;
  final String city;
  final Coordinates coordinates;
  final String postalCode;
  final String state;

  Address({
    required this.address,
    required this.city,
    required this.coordinates,
    required this.postalCode,
    required this.state,
  });

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'city': city,
      'coordinates': coordinates.toJson(),
      'postalCode': postalCode,
      'state': state,
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json['address'],
      city: json['city'],
      coordinates: Coordinates.fromJson(json['coordinates']),
      postalCode: json['postalCode'],
      state: json['state'],
    );
  }
}

class Coordinates {
  final double lat;
  final double lng;

  Coordinates({required this.lat, required this.lng});

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      lat: json['lat'].toDouble(),
      lng: json['lng'].toDouble(),
    );
  }
}

class Bank {
  final String cardExpire;
  final String cardNumber;
  final String cardType;
  final String currency;
  final String iban;

  Bank({
    required this.cardExpire,
    required this.cardNumber,
    required this.cardType,
    required this.currency,
    required this.iban,
  });

  Map<String, dynamic> toJson() {
    return {
      'cardExpire': cardExpire,
      'cardNumber': cardNumber,
      'cardType': cardType,
      'currency': currency,
      'iban': iban,
    };
  }

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      cardExpire: json['cardExpire'],
      cardNumber: json['cardNumber'],
      cardType: json['cardType'],
      currency: json['currency'],
      iban: json['iban'],
    );
  }
}

class Company {
  final Address address;
  final String department;
  final String name;
  final String title;

  Company({
    required this.address,
    required this.department,
    required this.name,
    required this.title,
  });

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'department': department,
      'name': name,
      'title': title,
    };
  }

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      address: Address.fromJson(json['address']),
      department: json['department'],
      name: json['name'],
      title: json['title'],
    );
  }
}

class ProductModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      discountPercentage: json['discountPercentage'].toDouble(),
      rating: json['rating'].toDouble(),
      stock: json['stock'],
      brand: json['brand'],
      category: json['category'],
      thumbnail: json['thumbnail'],
      images: List<String>.from(json['images']),
    );
  }
}

class CategoryModel {
  final String title;

  CategoryModel({
    required this.title,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      title: json['title'],
    );
  }
}

class CartItemModel {
  final int id;
  final String title;
  final double price;
  int quantity;
  double total;
  double discountPercentage;
  double discountedPrice;

  CartItemModel({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.total,
    required this.discountPercentage,
    required this.discountedPrice,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      total: json['total'].toDouble(),
      discountPercentage: json['discountPercentage'].toDouble(),
      discountedPrice: json['discountedPrice'].toDouble(),
    );
  }
}

class PostModel {
  int id;
  String title;
  String body;
  int userId;
  List<String> tags;
  int reactions;

  PostModel({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    required this.tags,
    required this.reactions,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      userId: json['userId'],
      tags: List<String>.from(json['tags']),
      reactions: json['reactions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'userId': userId,
      'tags': tags,
      'reactions': reactions,
    };
  }
}

class CommentModel {
  final int id;
  final String body;
  final int postId;
  final CommentUserModel user;

  CommentModel({
    required this.id,
    required this.body,
    required this.postId,
    required this.user,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      body: json['body'],
      postId: json['postId'],
      user: CommentUserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'body': body,
      'postId': postId,
      'user': user.toJson(),
    };
  }
}

class CommentUserModel {
  final int id;
  final String username;

  CommentUserModel({
    required this.id,
    required this.username,
  });

  factory CommentUserModel.fromJson(Map<String, dynamic> json) {
    return CommentUserModel(
      id: json['id'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
    };
  }
}
