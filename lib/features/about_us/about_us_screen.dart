import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
            'Easy Shop: Your One-Stop Shop for Everything You Need\n\n'

            'Easy Shop is a leading e-commerce app that offers a wide selection of products at competitive prices. We make it easy for you to find and purchase the products you need, with convenient delivery options and excellent customer service.\n\n'

            'We are committed to providing our customers with the best possible shopping experience. That\'s why we offer a variety of features that make it easy to find and purchase the products you need, including:\n\n'

            '+ A user-friendly search function\n'
            '+ Detailed product descriptions and images\n'
            '+ Secure payment options\n'
            '+ Fast and reliable delivery\n'
            '+ Excellent customer service\n\n'
            'Whether you\'re looking for new clothes, electronics, home goods, or anything else, you\'re sure to find it on Easy Shop. We offer a wide range of products from top brands, so you can shop with confidence.\n\n'

            'Our Mission\n\n'

            'Our mission is to make it easy for our customers to find and purchase the products they need at the best possible prices. We are committed to providing our customers with a convenient and hassle-free shopping experience.\n\n'

            'Our Team\n\n'

            'Easy Shop is run by a team of experienced and passionate e-commerce professionals. We are dedicated to providing our customers with the best possible shopping experience.\n\n'

            'Contact Us\n\n'

            'If you have any questions or feedback, please feel free to contact us. We are always happy to hear from our customers.\n\n'

            'Thank you for choosing Easy Shop!',style:TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400
            ) ),
          ),
        ),
      )),
    );
  }
}
