-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: savebite
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `cart_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `food_id` int DEFAULT NULL,
  `quantity` int DEFAULT '1',
  PRIMARY KEY (`cart_id`),
  KEY `user_id` (`user_id`),
  KEY `food_id` (`food_id`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`food_id`) REFERENCES `food_items` (`food_id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_addresses`
--

DROP TABLE IF EXISTS `delivery_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery_addresses` (
  `address_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `full_address` text,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `pincode` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`address_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `delivery_addresses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_addresses`
--

LOCK TABLES `delivery_addresses` WRITE;
/*!40000 ALTER TABLE `delivery_addresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `delivery_addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donations`
--

DROP TABLE IF EXISTS `donations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donations` (
  `donation_id` int NOT NULL AUTO_INCREMENT,
  `restaurant_id` int DEFAULT NULL,
  `ngo_id` int DEFAULT NULL,
  `food_name` varchar(100) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `expiry_time` datetime DEFAULT NULL,
  `donation_status` varchar(30) DEFAULT NULL,
  `donation_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `pickup_address` text,
  PRIMARY KEY (`donation_id`),
  KEY `restaurant_id` (`restaurant_id`),
  KEY `ngo_id` (`ngo_id`),
  CONSTRAINT `donations_ibfk_1` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`restaurant_id`),
  CONSTRAINT `donations_ibfk_2` FOREIGN KEY (`ngo_id`) REFERENCES `ngos` (`ngo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donations`
--

LOCK TABLES `donations` WRITE;
/*!40000 ALTER TABLE `donations` DISABLE KEYS */;
INSERT INTO `donations` VALUES (1,1,NULL,'Veg Biryani',1,'2026-06-14 18:16:00','COLLECTED','2026-06-14 09:46:33','Bangalore'),(2,1,NULL,'Veg Biryani',1,'2026-06-15 15:20:00','COLLECTED','2026-06-14 09:50:43','Chittoor'),(3,1,NULL,'Veg Biryani',20,'2026-07-02 20:00:00','COLLECTED','2026-07-02 05:53:43','Chittoor');
/*!40000 ALTER TABLE `donations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food_items`
--

DROP TABLE IF EXISTS `food_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food_items` (
  `food_id` int NOT NULL AUTO_INCREMENT,
  `restaurant_id` int DEFAULT NULL,
  `food_name` varchar(100) NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `available_quantity` int DEFAULT '0',
  `food_status` varchar(20) DEFAULT 'AVAILABLE',
  `deliveryTime` int DEFAULT NULL,
  `rating` double DEFAULT '0',
  PRIMARY KEY (`food_id`),
  KEY `restaurant_id` (`restaurant_id`),
  CONSTRAINT `food_items_ibfk_1` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`restaurant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food_items`
--

LOCK TABLES `food_items` WRITE;
/*!40000 ALTER TABLE `food_items` DISABLE KEYS */;
INSERT INTO `food_items` VALUES (1,1,'Veg Biryani','Biryani','Mixed vegetables and spices cooked with basmati rice',120.00,'images/veg.jpg',50,'AVAILABLE',25,4),(2,1,'Chicken Dum Biryani','Rice','Fragrant basmati rice layered with tender chicken and aromatic spices',220.00,'images/chib.jpg',80,'AVAILABLE',35,4.6),(3,1,'Hyderabadi Chicken Biryani','Rice','Authentic Hyderabadi-style chicken biryani with rich flavors',250.00,'images/hyd.jpg',50,'AVAILABLE',30,4.7),(4,1,'Mutton Dum Biryani','Rice','Slow-cooked mutton layered with fragrant basmati rice',320.00,'images/mutton.jpg',45,'AVAILABLE',35,4.8),(5,1,'Mutton Keema Biryani','Rice','Flavorful minced mutton cooked with aromatic rice',340.00,'images/keema.jpg',60,'AVAILABLE',30,4.6),(6,1,'Mushroom Biryani','Rice','Fresh mushrooms cooked with fragrant rice and spices',230.00,'images/mushroom.png',30,'AVAILABLE',20,4.1),(7,1,'Prawn Biryani','Rice','Juicy prawns layered with flavorful basmati rice.',350.00,'images/prawn.jpg',35,'AVAILABLE',40,4.3),(8,1,'Family Pack Chicken Biryani','Rice','Large portion of aromatic chicken biryani, perfect for sharing with family and friends',699.00,'images/family.png',45,'AVAILABLE',50,4.8),(9,2,'Margherita Ultimate Cheese','Pizza','Rich mozzarella cheese layered over signature pizza sauce on a freshly baked crust',244.00,'images/PIZZA1.jpg',45,'AVAILABLE',25,4.6),(10,2,'Tandoori Paneer Ultimate','Pizza','Flavorful tandoori-marinated paneer, fresh vegetables, and melted mozzarella cheese',394.00,'images/PIZZA2.png',30,'AVAILABLE',25,4.5),(11,2,'Veggie Supreme','Pizza','Fresh veggies and mozzarella cheese on a crispy crust for a flavorful and satisfying bite',304.00,'images/pizzaveg.png',25,'AVAILABLE',20,4),(12,2,'Mexican Fiesta','Pizza','A zesty pizza topped with jalapeños, sweet corn, capsicum, onions, and cheese ',299.00,'images/mex.webp',20,'AVAILABLE',30,4.2),(13,2,'Paneer Makhni Masala','Pizza','Soft paneer with rich makhni sauce and melted cheese on a freshly baked pizza crust',319.00,'images/mak.jpg',25,'AVAILABLE',20,3.9),(14,2,'Garlic Bread Supreme','Sides','Freshly baked garlic bread topped with melted cheese and flavorful seasonings',149.00,'images/GARLIC.png',35,'AVAILABLE',15,4.1),(15,2,'Cheesy Pocket (2 Pc)','Sides','Crispy golden pockets stuffed with gooey melted cheese and flavorful fillings',129.00,'images/cheese.webp',40,'AVAILABLE',15,4.4),(16,2,'Classic White Sauce Pasta Veg','Pasta','Creamy white sauce pasta with vegetables ',229.00,'images/white.webp',30,'AVAILABLE',25,4.6),(17,3,'Veg Whopper','Burgers','Flame-grilled veg patty with fresh lettuce, onions, tomatoes, and creamy sauces in a soft sesame bun',179.00,'images/who.webp',25,'AVAILABLE',20,4.3),(18,3,'Crispy Veg Burger','Burgers','Crispy vegetable patty layered with fresh veggies and signature sauces.',79.00,'images/cripsy.jpg',40,'AVAILABLE',15,4.6),(19,3,'Paneer Royale Burger','Burgers','Crispy paneer patty with fresh vegetables and creamy mayo in a soft bun',199.00,'images/panb.jpg',50,'AVAILABLE',25,4.7),(20,3,'BK Veggie Burger','Burgers','Classic veg burger with a crunchy patty and flavorful sauces',99.00,'images/vegb.jpg',35,'AVAILABLE',20,4.4),(21,4,'Veg Meals','Meals','A wholesome South Indian meal served with rice, sambar, rasam, dal, vegetable curry',149.00,'images/meal.jpg',55,'AVAILABLE',30,4.2),(22,4,'Veg Fried Rice','Rice','Flavorful fried rice tossed with fresh vegetables, seasonings, and aromatic spices ',119.00,'images/fired.jpg',35,'AVAILABLE',25,3.8),(23,4,'Chicken Fried Rice','Rice','Wok-tossed rice with chicken and flavorful seasonings',120.00,'images/firedc.jpg',55,'AVAILABLE',20,4.2),(24,4,'Non-Veg Meals','Meals','Complete South Indian meal served with curries, rice, and sides',230.00,'images/nmeals.jpg',60,'AVAILABLE',30,4.5),(25,4,'Butter Chicken Masala','Curry','Tender chicken cooked in a rich and creamy tomato-based gravy',210.00,'images/butter.jpg',35,'AVAILABLE',25,4.2),(26,4,'Gobi 65','Sides','Crispy cauliflower florets coated in spicy seasonings and fried to perfection ',139.00,'images/gobi.webp',25,'AVAILABLE',20,4.6),(27,4,'Curd Rice','Rice','Soft rice mixed with fresh curd and mild seasonings, offering a refreshing',99.00,'images/Curd.jpg',35,'AVAILABLE',15,4.3),(28,4,'Sambar Rice','Rice','Steamed rice blended with flavorful sambar and traditional spices ',109.00,'images/sambar.jpg',45,'AVAILABLE',20,4.4),(29,3,'Veg Crunchy Taco','Snacks','Crispy taco shell filled with vegetables and spicy sauces',99.00,'images/tac.webp',25,'AVAILABLE',15,4.1),(30,3,'French Fries','Snacks','Golden, crispy, and lightly salted potato fries and sauce',109.00,'images/friench.jpg',30,'AVAILABLE',15,4.2),(31,3,'Peri Peri Fries','Snacks','Crispy fries tossed in spicy and flavorful peri peri seasoning',119.00,'images/peri.webp',35,'AVAILABLE',15,4.3),(32,3,'Chocolate Thick Shake','Beverage','Rich, creamy chocolate shake blended to perfection for a refreshing treat',189.00,'images/choco.png',25,'AVAILABLE',20,4.5),(33,5,'Paneer Butter Masala','Main Course','Soft paneer cubes cooked in a rich, creamy tomato gravy infused with butter',250.00,'images/paneer.png',50,'AVAILABLE',25,4.6),(34,5,'Kadai Paneer','Main Course','Fresh paneer and capsicum tossed in a spicy kadai masala for a flavorful North Indian ',239.00,'images/KADAI.webp',45,'AVAILABLE',30,4.5),(35,5,'Dal Makhani','Main Course','Slow-cooked black lentils and kidney beans simmered in butter and cream',199.00,'images/dal.jpg',50,'AVAILABLE',30,4.3),(36,5,'Butter Naan','Bread','Soft and fluffy tandoor-baked naan brushed with melted butter',49.00,'images/non.jpg',65,'AVAILABLE',15,4.4),(37,5,'Garlic Naan','Bread','Freshly baked naan topped with garlic and herbs for a flavorful and aromatic ',59.00,'images/gar.webp',55,'AVAILABLE',15,4.5),(38,5,'Veg Biryani','Biryani','Fragrant basmati rice cooked with fresh vegetables and traditional spices ',199.00,'images/vegbir.webp',70,'AVAILABLE',25,4.3),(39,5,'Chole Bhature','NorthIndian','Spicy chickpea curry served with fluffy deep-fried bhature for a classic Punjabi favorite',149.00,'images/chola.jpg',55,'AVAILABLE',20,4.3),(40,5,'Jeera Rice','Rice','Long-grain basmati rice tempered with cumin seeds and aromatic spices',129.00,'images/jeera.jpg',40,'AVAILABLE',25,4.1),(41,10,'Chocolate Truffle Cake','Cakes','Rich layers of moist chocolate sponge and smooth truffle cream',399.00,'images/truffle.jpg',20,'AVAILABLE',25,4.8),(42,6,'Gulab Jamun (2 Pcs)','Dessert','Soft and juicy milk-solid dumplings soaked in aromatic sugar syrup',89.00,'images/jamun.webp',45,'AVAILABLE',15,4.5),(43,6,'Brownie with Ice Cream','Dessert','Warm chocolate brownie topped with creamy vanilla ice cream',199.00,'images/browine.webp',35,'AVAILABLE',20,4.6),(44,6,'Chocolate Sundae','Ice cream','Smooth ice cream layered with rich chocolate sauce and delightful toppings',169.00,'images/sun.png',45,'AVAILABLE',15,4.3),(45,6,'Belgian Waffle','waffle','Freshly baked golden waffle served with chocolate drizzle and delicious toppings',229.00,'images/waffle.webp',35,'AVAILABLE',20,4.4),(46,6,'Mango Cheesecake Jar','Dessert','Creamy mango cheesecake layered in a dessert jar for a refreshing and fruity trea',179.00,'images/jar.png',40,'AVAILABLE',20,4.5),(47,6,'Vanilla Ice Cream','Ice cream','Smooth and creamy vanilla ice cream made with rich dairy goodness',99.00,'images/vanilla.webp',60,'AVAILABLE',15,4.5),(48,6,'Hot Chocolate Brownie','Dessert','Soft chocolate brownie served warm with rich chocolate sauce',189.00,'images/hotc.jpg',45,'AVAILABLE',20,4.7),(49,6,'Fruit Custard','Dessert','Creamy custard mixed with fresh fruits for a light, refreshing, and flavorful dessert',129.00,'images/fruit.jpg',55,'AVAILABLE',15,4.3),(50,7,'Cold Coffee','Beverage','A refreshing blend of chilled coffee, milk, and ice topped with a smooth and creamy finish',149.00,'images/coldcof.webp',30,'AVAILABLE',15,4.4),(51,7,'Cappuccino','coffee','Freshly brewed espresso topped with velvety milk foam for a rich and aromatic coffee ',129.00,'images/cap.jpg',25,'AVAILABLE',20,4.6),(52,7,'Veg Club Sandwich','sandwich','Layers of fresh vegetables, cheese, and sauces packed between toasted bread slices',109.00,'images/club.png',35,'AVAILABLE',25,4.2),(53,7,'Paneer Tikka Sandwich','sandwich','Grilled paneer tikka with fresh vegetables and flavorful sauces in toasted bread',199.00,'images/tikka.webp',45,'AVAILABLE',20,4.3),(54,7,'Garlic Toast','Snacks','Crispy toasted bread infused with garlic butter and herbs ',129.00,'images/toast.jpg',63,'AVAILABLE',25,3.8),(55,7,'Masala Tea','Beverage','Traditional Indian tea brewed with aromatic spices for a warm and refreshing drink',30.00,'images/tea.webp',70,'AVAILABLE',10,4.3),(56,7,'Americano','Beverage','Smooth espresso blended with hot water for a balanced and refreshing coffee.',119.00,'images/amero.webp',46,'AVAILABLE',20,4.2),(57,7,'Fresh Lime Mojito','cold drink','A refreshing blend of lime, mint, and soda served chilled for a cool and refreshing drink',99.00,'images/mojito.jpg',25,'AVAILABLE',15,4.1),(58,8,'Veg Hakka Noodles','Noodles','Stir-fried noodles tossed with fresh vegetables, sauces, and seasonings',195.00,'images/noodles.png',26,'AVALIABLE',20,4.2),(59,8,'Schezwan Noodles','Noodles','Spicy noodles cooked with vegetables and flavorful Schezwan sauce ',189.00,'images/swe.png',23,'AVAILABLE',25,4.1),(60,8,'Schezwan Fried Rice','Rice','Flavorful fried rice mixed with spicy Schezwan sauce and vegetables ',179.00,'images/swer.jpg',46,'AVAILABLE',25,4.5),(61,8,'Paneer Chilli Dry','Sides','Soft paneer cubes stir-fried with onions, capsicum, and spicy Chinese sauces',229.00,'images/chilli.jpg',48,'AVAILABLE',20,4.4),(62,8,'Honey Chilli Potato','Sides','Crispy potato strips coated in a sweet and spicy honey chilli sauce for an addictive snack',189.00,'images/hon.webp',50,'AVAILABLE',25,4.7),(63,8,'Crispy Corn','Sides','Golden fried sweet corn tossed with spices and herbs for a crunchy ',179.00,'images/corn.jpg',35,'AVAILABLE',15,4.3),(64,8,'American Chopsuey','Main course','Crispy noodles topped with sweet and tangy vegetable gravy ',229.00,'images/ame.jpg',42,'AVAILABLE',20,4.5),(65,8,'Veg Dim Sums','Sides','Soft handmade dumplings stuffed with seasoned vegetables ',229.00,'images/dim.jpg',35,'AVAILABLE',30,4.6),(66,6,'Raspberry Mousse','Dessert','A light and velvety dessert made with fresh raspberry puree and whipped cream',180.00,'images/mousse.jpeg',45,'AVAILABLE',20,4.8),(67,4,'Masala Dosa','Dosa','A crispy golden dosa filled with flavorful potato masala and served with coconut chutney and sambar',120.00,'images/dosa.jpeg',55,'AVAILABLE',15,4.7),(68,4,'Ghee Podi Idli','Idli','Soft steamed idlis tossed in aromatic ghee and spicy South Indian podi masala',140.00,'images/ghee.webp',50,'AVAILABLE',20,4.5),(69,9,'Vegetable Ramen','Ramen','Japanese wheat noodles served in a rich and flavorful broth with fresh vegetables',349.00,'images/ROMEN.jpg',45,'AVAILABLE',35,4.3),(70,9,'Udon Noodles','Noodles','Thick and chewy Japanese noodles cooked in a savory broth',329.00,'images/udon.jpg',36,'AVAILABLE',25,4.5),(71,9,'Teriyaki Tofu Bowl','Rice',' Tofu glazed with sweet and savory teriyaki sauce served over steamed rice , vegetables',359.00,'images/BOWL.webp',24,'AVAILABLE',30,4.6),(72,9,'Veg Gyoza','Snacks','Pan-fried Japanese dumplings stuffed with seasoned vegetables',299.00,'images/DUM.webp',55,'AVAILABLE',15,4.4),(73,9,'Miso Soup','soup','Traditional Japanese soup made with miso paste, tofu, and seaweed',149.00,'images/soup.png',48,'AVAILABLE',15,4.7),(74,9,'Salmon Sushi','Sushi','Fresh salmon served over seasoned sushi rice for a rich and authentic Japanese delicacy',499.00,'images/sushi.jpg',65,'AVAILABLE',30,4.8),(75,9,'Tempura Prawns','Sides','Crispy golden prawns coated in a light Japanese tempura batter and fried ',449.00,'images/temp.jpg',45,'AVAILABLE',35,4.8),(76,9,'Chicken Katsu Curry','Main Course','Crispy breaded chicken served with rich Japanese curry sauce and steamed rice',499.00,'images/katsu.jpg',49,'AVAILABLE',25,4.5),(77,10,'Ferrero Rocher Cake','Cakes','Rich chocolate cake layered with hazelnut cream and Ferrero Rocher chocolates',699.00,'images/ferro.jpg',25,'AVAILABLE',35,4.5),(78,10,'Red Velvet Cream Cheese Cake','Cakes','Moist red velvet layers paired with rich cream cheese frosting',599.00,'images/red.webp',30,'AVAILABLE',30,4.3),(79,10,'Nutella Hazelnut Cake','Cakes','Chocolate sponge filled with Nutella cream and roasted hazelnuts',699.00,'images/nut.jpeg',29,'AVAILABLE',25,4.4),(80,10,'Mango Delight Cake','Cakes','Light sponge layered with fresh mango cream and juicy mango pieces',499.00,'images/mango.webp',25,'AVAILABLE',30,4.6),(81,10,'White Forest Cake','Cakes','Light vanilla sponge layered with fresh cream and white chocolate shavings',549.00,'images/whi.webp',20,'AVAILABLE',23,4.7),(82,10,'Strawberry Delight Cake','Cakes','Fluffy sponge filled with fresh strawberry cream and juicy strawberry pieces',579.00,'images/sta.webp',25,'AVAILABLE',20,4.3),(83,10,'Coffee Mocha Cake','Cakes','Coffee-flavored sponge layered with mocha cream for a rich and aromatic treat',599.00,'images/cof.jpg',15,'AVAILABLE',25,4.8),(84,11,'Belgian Chocolate Shake','Shakes','Rich Belgian chocolate blended with creamy milk and ice cream ',189.00,'images/beg.jpeg',30,'AVAILABLE',15,4.7),(85,11,'Oreo Crunch Shake','Shakes','Smooth milkshake loaded with crushed Oreo cookies for a creamy and crunchy delight',179.00,'images/oero.jpg',25,'AVAILABLE',20,4.5),(86,11,'Nutella Hazelnut Shake','Shakes','A rich and creamy shake made with Nutella and roasted hazelnuts for a premium flavor ',229.00,'images/nutella.jpg',26,'AVAILABLE',20,4.4),(87,11,'Strawberry Milkshake','Shakes','Fresh strawberry flavors blended with chilled milk for a sweet and refreshing drink',169.00,'images/sta.jpg',28,'AVAILABLE',15,4.7),(88,11,'Mango Shake','Shakes','Thick and creamy mango shake prepared with juicy mangoes for a tropical treat',159.00,'images/mango.jpeg',38,'AVAILABLE',20,4.6),(89,11,'Butterscotch Shake','Shakes','Smooth milkshake infused with rich butterscotch flavor and caramel notes',179.00,'images/but.webp',27,'AVAILABLE',15,4.3),(90,11,'Blueberry Shake','Shakes','Creamy milkshake blended with blueberry flavor for a fruity and refreshing experience',189.00,'images/blue.png',32,'AVAILABLE',15,4.5),(91,11,'Brownie Blast Shake','Shakes','Rich chocolate milkshake blended with chunks of fudgy brownie',229.00,'images/sha.webp',25,'AVAILABLE',20,4.6),(92,12,'Paneer Tikka Roll','Rolls','Soft paratha wrapped around smoky paneer tikka, fresh vegetables',179.00,'images/tika.jpg',55,'AVAILABLE',20,4.3),(93,12,'Veg Kathi Roll','Rolls','A classic roll filled with spiced vegetables, onions, and tangy sauces wrapped in a flaky paratha',159.00,'images/kathi.webp',49,'AVAILABLE',25,4.5),(94,12,'Mushroom Masala Roll','Rolls','Juicy mushrooms cooked in aromatic spices and wrapped in a soft paratha',189.00,'images/mush.jpeg',35,'AVAILABLE',15,4.6),(95,12,'Double Cheese Paneer Roll','Rolls','Loaded with paneer, melted cheese, and creamy sauces for an extra cheesy experience',219.00,'images/double.jpeg',25,'AVAILABLE',20,4.2),(96,12,'Corn & Cheese Roll','Rolls','Sweet corn and melted cheese wrapped together for a creamy and satisfying snack',179.00,'images/chee.webp',20,'AVAILABLE',15,4.3),(97,12,'Mexican Bean Roll','Rolls','A flavorful mix of beans, vegetables, cheese, and Mexican spices rolled',189.00,'images/mexi.webp',30,'AVAILABLE',25,4.5),(98,12,'Thai Chilli Tofu Roll','Rolls','Crispy tofu tossed in sweet and spicy Thai chilli sauce with fresh vegetables',239.00,'images/tan.jpeg',28,'AVAILABLE',20,4.2),(99,12,'Mediterranean Falafel Roll','Rolls','Crispy falafel, fresh lettuce, and creamy garlic sauce wrapped',229.00,'images/medi.jpg',35,'AVAILABLE',25,4.6),(100,1,'Fish Biryani','Biryani','Tender fish pieces cooked with aromatic biryani spices',320.00,'images/fish.jpg',30,'AVAILABLE',30,4.1),(101,1,'Fish Biryani','Biryani','Tender fish pieces cooked with aromatic biryani spices',320.00,'images/fish.jpg',30,'AVAILABLE',30,4.1),(102,1,'Chicken Tikka Biryani','Biryani','Smoky chicken tikka pieces mixed with flavorful biryani rice',280.00,'images/1782969893812_tikkaa.jpg',25,'AVAILABLE',35,4.6);
/*!40000 ALTER TABLE `food_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ngos`
--

DROP TABLE IF EXISTS `ngos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ngos` (
  `ngo_id` int NOT NULL AUTO_INCREMENT,
  `ngo_name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `address` text,
  `verification_status` varchar(20) DEFAULT 'PENDING',
  PRIMARY KEY (`ngo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ngos`
--

LOCK TABLES `ngos` WRITE;
/*!40000 ALTER TABLE `ngos` DISABLE KEYS */;
/*!40000 ALTER TABLE `ngos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `order_item_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `food_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `item_price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `order_id` (`order_id`),
  KEY `food_id` (`food_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`food_id`) REFERENCES `food_items` (`food_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `payment_status` varchar(20) DEFAULT NULL,
  `order_status` varchar(30) DEFAULT NULL,
  `delivery_address` text,
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `tracking_status` varchar(30) DEFAULT 'PLACED',
  `restaurant_id` int DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,240.00,'Pending','Placed','Sri Sai ladies pg,BTM 2nd stage, Bangalore.','2026-06-14 07:22:04','DELIVERED',NULL),(2,1,240.00,'Pending','Placed','Sri Sai ladies pg,BTM 2nd stage,Banglore','2026-06-14 07:30:00','PLACED',NULL),(3,1,180.00,'Paid','Placed','32-197,Janda Street,Murukambattu,Chittoor','2026-06-14 07:39:32','PLACED',NULL),(4,3,1328.00,'Paid','Placed','Chittoor','2026-06-25 10:55:44','PLACED',NULL),(5,3,99.00,'Pending','Placed','Doddipalli,Chittoor','2026-06-25 11:04:23','PLACED',NULL),(6,3,240.45,'Paid','Placed','Doddipalli,Chittoor','2026-06-25 11:10:05','PLACED',NULL),(7,3,0.00,'Paid','Placed','Doddipalli,Chittoor','2026-06-25 11:10:42','PLACED',NULL),(8,3,0.00,'Paid','Placed','Doddipalli,Chittoor','2026-06-25 11:10:57','PLACED',NULL),(9,3,0.00,'Pending','Placed','Doddipalli,Chittoor','2026-06-25 11:11:31','PLACED',NULL),(10,3,0.00,'Paid','Placed','Doddipalli,Chittoor','2026-06-25 11:11:48','PLACED',NULL),(11,3,0.00,'Paid','Placed','Doddipalli,Chittoor','2026-06-25 11:12:03','PLACED',NULL),(12,3,0.00,'Pending','Placed','Doddipalli,Chittoor','2026-06-25 11:12:52','PLACED',NULL),(13,3,198.45,'Pending','Placed','Doddipalli,Chittoor','2026-06-25 13:00:20','PLACED',NULL),(14,3,156.45,'Paid','Placed','Doddipalli,Chittoor','2026-06-25 13:01:11','PLACED',NULL),(15,3,0.00,'Paid','Placed','Doddipalli,Chittoor','2026-06-25 13:01:32','PLACED',NULL),(16,3,186.90,'Paid','Placed','Doddipalli,Chittoor','2026-06-30 04:47:19','PLACED',NULL),(17,3,733.95,'Paid','Placed','Doddipalli,Chittoor','2026-06-30 04:50:48','PLACED',NULL),(18,3,0.00,'Paid','Placed','Doddipalli,Chittoor','2026-06-30 04:50:59','PLACED',NULL),(19,3,166.95,'Paid','Placed','Doddipalli,Chittoor','2026-06-30 04:58:33','PLACED',NULL),(20,3,0.00,'Paid','Placed','Doddipalli,Chittoor','2026-06-30 04:59:11','PLACED',NULL),(21,3,672.00,'Paid','Placed','Doddipalli,Chittoor','2026-06-30 05:18:10','PLACED',NULL),(22,3,249.90,'Pending','Placed','Doddipalli,Chittoor','2026-06-30 05:26:02','PLACED',NULL),(23,3,240.45,'Paid','Placed','Doddipalli,Chittoor','2026-06-30 05:27:49','PLACED',NULL),(24,3,256.20,'Pending','Placed','Doddipalli,Chittoor','2026-06-30 05:31:44','PLACED',NULL),(25,3,208.95,'Paid','Placed','Doddipalli,Chittoor','2026-06-30 05:37:03','PLACED',NULL),(26,3,523.95,'Paid','Placed','Doddipalli,Chittoor','2026-06-30 05:53:02','PLACED',NULL),(27,3,198.45,'Pending','Placed','Doddipalli,Chittoor','2026-06-30 05:53:36','PLACED',NULL),(28,3,156.45,'Paid','Placed','Doddipalli,Chittoor','2026-06-30 05:54:10','PLACED',NULL),(29,3,208.95,'Pending','Placed','Doddipalli,Chittoor','2026-06-30 05:55:40','PLACED',NULL),(30,3,241.50,'Paid','Placed','Doddipalli,Chittoor','2026-06-30 05:57:16','PLACED',NULL),(31,3,156.45,'Pending','Placed','Doddipalli,Chittoor','2026-06-30 06:00:07','PLACED',NULL),(32,3,240.45,'Paid','Placed','Doddipalli,Chittoor','2026-06-30 06:54:23','PLACED',NULL),(33,3,126.00,'Pending','Placed','Doddipalli,Chittoor','2026-06-30 06:58:19','PLACED',NULL),(34,3,313.95,'Pending','Placed','Doddipalli,Chittoor','2026-06-30 07:06:21','PLACED',NULL),(35,3,166.95,'Paid','Placed','Doddipalli,Chittoor','2026-06-30 07:07:15','PLACED',NULL),(36,3,231.00,'Pending','Placed','Doddipalli,Chittoor','2026-07-01 11:02:47','DELIVERED',1),(37,3,1467.90,'Pending','Placed','Doddipalli,Chittoor','2026-07-05 05:50:54','PLACED',10),(38,3,135.45,'Paid','Placed','Doddipalli,Chittoor','2026-07-05 05:51:57','PLACED',7);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `payment_status` varchar(20) DEFAULT NULL,
  `payment_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`payment_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,3,NULL,'UPI',180.00,'Paid','2026-06-14 07:39:50'),(2,4,NULL,'UPI',1328.00,'Paid','2026-06-25 10:55:53'),(3,16,NULL,'UPI',186.00,'Paid','2026-06-30 04:47:43'),(4,21,NULL,'COD',672.00,'Paid','2026-06-30 05:19:23'),(5,21,NULL,'COD',672.00,'Paid','2026-06-30 05:23:50'),(6,23,NULL,'COD',240.00,'Paid','2026-06-30 05:29:38'),(7,25,NULL,'UPI',208.00,'Paid','2026-06-30 05:38:00'),(8,28,NULL,'UPI',156.00,'Paid','2026-06-30 05:54:19'),(9,30,NULL,'UPI',241.00,'Paid','2026-06-30 05:57:24'),(10,32,NULL,'UPI',240.00,'Paid','2026-06-30 06:54:33'),(11,35,NULL,'UPI',166.00,'Paid','2026-06-30 07:07:31'),(12,38,NULL,'UPI',135.00,'Paid','2026-07-05 05:52:05');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurants`
--

DROP TABLE IF EXISTS `restaurants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurants` (
  `restaurant_id` int NOT NULL AUTO_INCREMENT,
  `restaurant_name` varchar(100) NOT NULL,
  `owner_name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `address` text,
  `description` text,
  `image_url` varchar(255) DEFAULT NULL,
  `rating` decimal(2,1) DEFAULT '0.0',
  `status` varchar(20) DEFAULT 'ACTIVE',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `cuisineType` varchar(30) DEFAULT NULL,
  `deliveryTime` int DEFAULT NULL,
  `minPrice` int DEFAULT NULL,
  `PriceRange` varchar(30) DEFAULT NULL,
  `cover_image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`restaurant_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurants`
--

LOCK TABLES `restaurants` WRITE;
/*!40000 ALTER TABLE `restaurants` DISABLE KEYS */;
INSERT INTO `restaurants` VALUES (1,'Biryani House','Rahul','paradise@gmail.com','9876543210','Hyderabad','Aromatic biryanis prepared with authentic spices and rich flavors.','images/house.jpg',4.5,'ACTIVE','2026-06-14 06:20:24','Biryani',35,120,'Premium','images/menu-hero.png'),(2,'Pizza Hut','Kiran','pizza@gmail.com','9876543211','Bangalore','Freshly baked pizzas topped with rich flavors and quality ingredients.','images/pizza.jpg',4.2,'ACTIVE','2026-06-14 06:20:24','Pizza',30,100,'Mid Range','images/pizzahero.png'),(3,'Burger King','Ramesh','burgerking@gmail.com','9876543212','Bangalore','Delicious flame-grilled burgers and crispy fries, served fresh every day.','images/bur.jpg',4.3,'ACTIVE','2026-06-14 06:20:24','Burgers',25,90,'Budget','images/burghero.png'),(4,'South Spice Kitchen','Ramesh Kumar','southspice@gmail.com','7829546770','Hyderabad','Authentic South Indian dishes prepared with traditional recipes and fresh ingredients','images/sin.webp',4.3,'ACTIVE','2026-06-17 13:09:04','South Indian',20,120,'Mid Range','images/SOUTHHERO.png'),(5,'Royal Punjab Kitchen','Manpreet Kaur','royalpunjab@gmail.com','6307445926','Chennai','Traditional Punjabi cuisine served with authentic spices and fresh ingredients','images/nin.jpg',4.0,'ACTIVE','2026-05-10 06:30:58','North Indian',35,150,'Fine Dining','images/royalhero.png'),(6,'Dessert Delight','Ananya Iyer','dessertdelight@gmail.com','8325509671','Chennai','Indulge in premium ice creams, brownies, and sweet treats.','images/des.jpg',4.5,'ACTIVE','2025-08-10 01:00:22','Desserts',20,79,'Premium','images/desserthero.png'),(7,'Cafe Breeze','Sai Prasad','cafe@gmail.com','7659844033','Tirupati','Enjoy handcrafted beverages and delicious quick bites','images/caf.jpg',4.2,'ACTIVE','2026-01-28 00:30:09','Cafe',15,119,'Premium','images/cafehero.png'),(8,'China Bowl','Praveen Shetty','chinabowl@gmail.com','8795612430','Udupi','Delicious noodles, dumplings, and authentic Chinese recipes','images/chi.jpg',4.3,'ACTIVE','2026-06-10 06:15:03','Chinese',30,139,'Fine Dinning','images/chihero.png'),(9,'Fuji Garden','Haruto Yamamoto','fuji@gmail.com','9654302176','Salem','Experience the taste of Japan with premium ingredients and authentic recipess','images/jap.jpg',4.0,'ACTIVE','2024-07-17 21:00:01','Japanese',25,279,'Premium','images/japhero.png'),(10,'Dream Cakes','Sandeep Reddy','cakes@gmail.com','7924670913','Warangal','Customized cakes and sweet delights with creative designs','images/cakes.jpg',4.4,'ACTIVE','2025-08-15 01:45:45','Cakes',20,149,'Budget','images/cakehero.jpeg'),(11,'Frozen Bliss','Rakesh Shetty','frozen@gmail.com','6524493357','Hubballi','Premium milkshakes, ice cream blends, and refreshing drinks','images/mil.avif',4.3,'ACTIVE','2025-01-25 02:39:17','Shakes',15,99,'Mid Range','images/shahero.png'),(12,'Wok & Roll','Harish Kumar','wokroll@gmail.com','9763299541','Warangal','Authentic kathi rolls filled with rich flavors and fresh ingredients','images/rol.png',4.2,'ACTIVE','2026-02-18 10:34:38','Rolls',20,109,'Budget','images/rollhero.png');
/*!40000 ALTER TABLE `restaurants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `review_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `restaurant_id` int DEFAULT NULL,
  `rating` int DEFAULT NULL,
  `review_text` text,
  `review_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`review_id`),
  KEY `user_id` (`user_id`),
  KEY `restaurant_id` (`restaurant_id`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`restaurant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('CUSTOMER','RESTAURANT','NGO','ADMIN') DEFAULT 'CUSTOMER',
  `address` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_login` timestamp NULL DEFAULT NULL,
  `restaurant_id` int DEFAULT NULL,
  `status` varchar(20) DEFAULT 'ACTIVE',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone_number` (`phone_number`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'V Ramya','ramya1082005@gmail.com','7989903359','ramya123','CUSTOMER','BTM,Banglore','2026-06-13 08:01:02','2026-07-04 05:57:03',NULL,'ACTIVE'),(2,'admin','admin@gmail.com','6309579173','admin@123','ADMIN','Murukambattu,Chittoor','2026-06-25 05:23:32','2026-07-05 05:58:41',NULL,'ACTIVE'),(3,'V Priya','priya23116@gmail.com','9182884974','priya@123','CUSTOMER','Doddipalli,Chittoor','2026-06-25 06:00:57','2026-07-05 05:50:15',NULL,'ACTIVE'),(4,'Rahul','paradise@gmail.com','9876543210','Rahul@123','RESTAURANT','Hyderabad','2026-06-14 06:20:24','2026-07-05 05:55:28',1,'ACTIVE'),(5,'Vijaykumar','vijay@gmail.com','9182884754','Vijay@123','NGO','Murukambattu','2026-07-02 10:41:31','2026-07-05 05:58:10',NULL,'ACTIVE');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-05 14:04:08
