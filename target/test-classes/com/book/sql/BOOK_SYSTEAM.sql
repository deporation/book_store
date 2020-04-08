SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `ISBN` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `bookname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `autor` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `transalter` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `press` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `editer` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `publisher` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Edition` int(255) NOT NULL,
  `pages` int(255) NULL DEFAULT NULL,
  `price` float(10, 2) NOT NULL,
  `bcount` int(11) NOT NULL,
  `btime` datetime(0) NULL,
  `detail` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cover` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ISBN`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for car
-- ----------------------------
DROP TABLE IF EXISTS `car`;
CREATE TABLE `car`  (
  `uid` int(11) NOT NULL,
  `ISBN` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ccount` int(11) NOT NULL,
  `stat` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`uid`, `ISBN`) USING BTREE,
  INDEX `ISBN`(`ISBN`) USING BTREE,
  CONSTRAINT `ISBN` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `uid` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `ISBN` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `uname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `account` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `passwd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `plimit` bit(1) NOT NULL,
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', 'admin', 'admin', b'1');
INSERT INTO `user` VALUES (2, 'deporation', '123', '123', b'0');

-- ----------------------------
-- View structure for carInfo
-- ----------------------------
DROP VIEW IF EXISTS `carInfo`;
CREATE ALGORITHM = UNDEFINED DEFINER = `chegnhan`@`%` SQL SECURITY DEFINER VIEW `carInfo` AS select (`book`.`price` * `car`.`ccount`) AS `pri`,`car`.`stat` AS `stat`,`user`.`uid` AS `uid`,`book`.`ISBN` AS `ISBN`,`book`.`bookname` AS `bookname`,`car`.`ccount` AS `ccount`,`book`.`cover` AS `cover` from ((`book` join `car` on((`car`.`ISBN` = `book`.`ISBN`))) join `user` on((`user`.`uid` = `car`.`uid`))) where (`car`.`stat` = 0);

-- ----------------------------
-- View structure for commentInfo
-- ----------------------------
DROP VIEW IF EXISTS `commentInfo`;
CREATE ALGORITHM = UNDEFINED DEFINER = `chegnhan`@`%` SQL SECURITY DEFINER VIEW `commentInfo` AS select `user`.`uid` AS `uid`,`book`.`ISBN` AS `ISBN`,`comment`.`content` AS `content`,`user`.`uname` AS `uname`,`book`.`bookname` AS `bookname` from ((`user` join `comment` on((`user`.`uid` = `comment`.`uid`))) join `book` on((`book`.`ISBN` = `comment`.`ISBN`)));

SET FOREIGN_KEY_CHECKS = 1;
