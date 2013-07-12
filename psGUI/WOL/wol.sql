/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50532
Source Host           : localhost:3306
Source Database       : wol

Target Server Type    : MYSQL
Target Server Version : 50532
File Encoding         : 65001

Date: 2013-07-12 14:19:25
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of pcs
-- ----------------------------
INSERT INTO `pcs` VALUES ('14', 'Desktop2', '11:11:11:11:11:12');
INSERT INTO `pcs` VALUES ('15', 'Laptop1', '11:11:11:11:11:15');
INSERT INTO `pcs` VALUES ('17', 'Desktop4', '11:11:11:11:11:17');
INSERT INTO `pcs` VALUES ('18', 'Desktop3', '11:11:11:11:11:19');

-- ----------------------------
-- Table structure for `projects`
-- ----------------------------
DROP TABLE IF EXISTS `projects`;
CREATE TABLE `projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of projects
-- ----------------------------
INSERT INTO `projects` VALUES ('2', 'MMBBS');
INSERT INTO `projects` VALUES ('29', 'meinProjekt');
INSERT INTO `projects` VALUES ('33', 'wichtigesProjekt');

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
INSERT INTO `rs_pcs_projects` VALUES ('15', '29');
INSERT INTO `rs_pcs_projects` VALUES ('14', '29');
INSERT INTO `rs_pcs_projects` VALUES ('14', '33');
INSERT INTO `rs_pcs_projects` VALUES ('17', '33');
INSERT INTO `rs_pcs_projects` VALUES ('15', '33');
INSERT INTO `rs_pcs_projects` VALUES ('14', '2');
INSERT INTO `rs_pcs_projects` VALUES ('17', '2');
INSERT INTO `rs_pcs_projects` VALUES ('18', '2');
