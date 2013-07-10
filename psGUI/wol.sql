/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50532
Source Host           : localhost:3306
Source Database       : wol

Target Server Type    : MYSQL
Target Server Version : 50532
File Encoding         : 65001

Date: 2013-07-10 15:44:12
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `pcs`
-- ----------------------------
DROP TABLE IF EXISTS `pcs`;
CREATE TABLE `pcs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `mac` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of pcs
-- ----------------------------
INSERT INTO `pcs` VALUES ('5', 'PC1', '11:11:11:11:11:11');
INSERT INTO `pcs` VALUES ('6', 'POC2', '22:22:22:22:22:22');
INSERT INTO `pcs` VALUES ('7', 'mein pc', '11:11:11:11:11:11');

-- ----------------------------
-- Table structure for `projects`
-- ----------------------------
DROP TABLE IF EXISTS `projects`;
CREATE TABLE `projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of projects
-- ----------------------------
INSERT INTO `projects` VALUES ('2', 'MMBBS');
INSERT INTO `projects` VALUES ('14', 'Fisi12A');
INSERT INTO `projects` VALUES ('16', 'Fisi13');

-- ----------------------------
-- Table structure for `rs_pcs_projects`
-- ----------------------------
DROP TABLE IF EXISTS `rs_pcs_projects`;
CREATE TABLE `rs_pcs_projects` (
  `id_pcs` int(11) NOT NULL,
  `id_projects` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of rs_pcs_projects
-- ----------------------------
INSERT INTO `rs_pcs_projects` VALUES ('5', '2');
INSERT INTO `rs_pcs_projects` VALUES ('7', '14');
