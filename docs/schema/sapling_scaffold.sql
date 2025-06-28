/*
 Navicat Premium Dump SQL

 Source Server         : mac
 Source Server Type    : MySQL
 Source Server Version : 110702 (11.7.2-MariaDB)
 Source Host           : localhost:3306
 Source Schema         : sapling_scaffold

 Target Server Type    : MySQL
 Target Server Version : 110702 (11.7.2-MariaDB)
 File Encoding         : 65001

 Date: 28/06/2025 12:59:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sapling_scaffold_token
-- ----------------------------
DROP TABLE IF EXISTS `sapling_scaffold_token`;
CREATE TABLE `sapling_scaffold_token` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `platform` int(11) DEFAULT NULL COMMENT '颁发平台, 根据授权方式判断',
  `access_token` varchar(255) DEFAULT NULL COMMENT '访问令牌',
  `refresh_token` varchar(255) DEFAULT NULL COMMENT '刷新令牌',
  `issue_at` int(11) DEFAULT NULL COMMENT '颁发时间',
  `access_expired_at` int(30) DEFAULT NULL COMMENT '访问令牌过期时间',
  `refresh_expired_at` int(30) DEFAULT NULL COMMENT '刷新令牌过期时间',
  `user_type` int(11) DEFAULT NULL COMMENT '用户类型',
  `domain` varchar(255) DEFAULT NULL COMMENT '用户当前所处域',
  `username` varchar(255) DEFAULT NULL COMMENT '用户名',
  `user_id` int(11) DEFAULT NULL COMMENT '用户Id',
  `grant_type` int(11) DEFAULT NULL COMMENT '授权类型',
  `token_type` int(11) DEFAULT NULL COMMENT '令牌类型',
  `namespace` varchar(255) DEFAULT NULL COMMENT '当前空间',
  `scope` varchar(255) DEFAULT NULL COMMENT '空间内的过来条件, 格式key=value',
  `description` varchar(255) DEFAULT NULL COMMENT '令牌描述信息',
  `is_block` tinyint(4) DEFAULT NULL COMMENT '是否冻结',
  `block_type` int(11) DEFAULT NULL COMMENT '冻结类型',
  `block_at` int(30) DEFAULT NULL COMMENT '冻结时间',
  `block_reason` varchar(255) DEFAULT NULL COMMENT '冻结原因',
  `remote_ip` varchar(100) DEFAULT NULL COMMENT '令牌申请者IP地址',
  `city_id` int(11) DEFAULT NULL COMMENT '城市编号',
  `country` varchar(255) DEFAULT NULL COMMENT '国家',
  `region` varchar(255) DEFAULT NULL COMMENT '地区',
  `province` varchar(100) DEFAULT NULL COMMENT '省',
  `city` varchar(100) DEFAULT NULL COMMENT '城市',
  `isp` varchar(100) DEFAULT NULL COMMENT '服务商',
  `os` varchar(255) DEFAULT NULL COMMENT '系统OS',
  `user_agent_platform` varchar(255) DEFAULT NULL COMMENT '客户端平台',
  `engine_name` varchar(255) DEFAULT NULL COMMENT '内核名称',
  `engine_version` varchar(255) DEFAULT NULL COMMENT '内核版本',
  `browser_name` varchar(255) DEFAULT NULL COMMENT '浏览器名称',
  `browser_version` varchar(100) DEFAULT NULL COMMENT '浏览器版本',
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '其他信息' CHECK (json_valid(`meta`)),
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`) USING BTREE,
  KEY `username_index` (`username`) USING BTREE,
  KEY `access_token_index` (`access_token`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- ----------------------------
-- Table structure for sapling_scaffold_user
-- ----------------------------
DROP TABLE IF EXISTS `sapling_scaffold_user`;
CREATE TABLE `sapling_scaffold_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_at` bigint(20) NOT NULL COMMENT '创建时间(13位时间戳)',
  `create_by` varchar(255) NOT NULL COMMENT '创建人',
  `update_at` bigint(20) NOT NULL COMMENT '更新时间',
  `update_by` varchar(255) NOT NULL COMMENT '更新人',
  `provider` int(11) NOT NULL DEFAULT 0 COMMENT '帐号提供方0.本地数据库 1.LDAP 2.飞书',
  `type` int(11) NOT NULL DEFAULT 0 COMMENT '帐号类型0.子帐号 10.主帐号 15.超级管理员',
  `domain` varchar(255) DEFAULT NULL COMMENT '域信息',
  `username` varchar(255) DEFAULT NULL COMMENT '登录帐号',
  `password` varchar(255) DEFAULT NULL COMMENT '登录密码',
  `nick_name` varchar(255) DEFAULT '未命名' COMMENT '用户昵称',
  `remark` varchar(255) DEFAULT NULL COMMENT '用户描述',
  `gender` tinyint(1) NOT NULL DEFAULT 0 COMMENT '性别0.保密 1.男 2.女',
  `phone` varchar(255) DEFAULT NULL COMMENT '手机号码',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `language` varchar(255) DEFAULT NULL COMMENT '用户使用的语言',
  `address` varchar(255) DEFAULT NULL COMMENT '用户住址',
  `city` varchar(255) DEFAULT NULL COMMENT '用户所在地',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '状态0.激活 1.锁定 2.离职',
  `open_id` int(11) DEFAULT NULL COMMENT '用户在飞书应用内的唯一标识',
  `union_id` int(11) DEFAULT NULL COMMENT '飞书用户统一ID',
  `user_id` int(11) DEFAULT NULL COMMENT '飞书用户user id',
  `real_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci ROW_FORMAT=DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;
