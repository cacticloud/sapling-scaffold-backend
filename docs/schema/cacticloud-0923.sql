/*
 Navicat Premium Data Transfer

 Source Server         : mac
 Source Server Type    : MySQL
 Source Server Version : 50743
 Source Host           : localhost:3306
 Source Schema         : cacticloud

 Target Server Type    : MySQL
 Target Server Version : 50743
 File Encoding         : 65001

 Date: 23/09/2023 14:31:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cks_nexus
-- ----------------------------
DROP TABLE IF EXISTS `cks_nexus`;
CREATE TABLE `cks_nexus` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '对象Id',
  `create_at` bigint(20) NOT NULL COMMENT '创建时间(13位时间戳)',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `update_at` bigint(20) DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人',
  `domain` varchar(255) DEFAULT NULL COMMENT '集群所属域',
  `namespace` varchar(255) DEFAULT NULL COMMENT '集群所属空间',
  `provider` varchar(255) DEFAULT NULL COMMENT '集群提供商',
  `region` varchar(255) DEFAULT NULL COMMENT '集群所属地域',
  `name` varchar(255) DEFAULT NULL COMMENT '集群名称',
  `kube_config` longtext COMMENT '集群客户端访问凭证',
  `remark` varchar(255) DEFAULT NULL COMMENT '集群备注',
  `labels` varchar(255) DEFAULT NULL COMMENT '集群标签',
  `server` varchar(255) DEFAULT NULL COMMENT '集群地址',
  `version` varchar(255) DEFAULT NULL COMMENT '集群版本',
  `auth_user` varchar(255) DEFAULT NULL COMMENT '连接用户',
  `check_at` varchar(255) DEFAULT NULL COMMENT '检查时间',
  `is_alive` varchar(255) DEFAULT NULL COMMENT 'API Server 是否正常',
  `message` varchar(255) DEFAULT NULL COMMENT '异常消息',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`) USING BTREE COMMENT '用于主机名搜索',
  KEY `idx_remark` (`remark`) USING BTREE COMMENT '用于备注搜索'
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of cks_nexus
-- ----------------------------
BEGIN;
INSERT INTO `cks_nexus` VALUES (4, 1694619473102885, 'root', 0, '', 'default', 'default', 'esxi', 'beijing', 'esxi-kubeadm-01', '{  \"apiVersion\": \"v1\",  \"clusters\": [    {      \"cluster\": {        \"certificate-authority-data\": \"LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUMvakNDQWVhZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRJek1EZ3dOakE1TWpZMU1sb1hEVE16TURnd016QTVNalkxTWxvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBSndqCmxEdW44RFlDSFhONXV3ZTVudVhHRnh2eXZhbGtOV3lHUUEzVVA0MGZ0T0tFZmc5dks0ZVZpcXk3WXI1ZXVJTjQKbWhlTVB4SW1iRjQvT25MN05tUi9mZ0g1VHExL0tHY2pQVDM2ZHFYbDlrUnUzOXBMSnUxMVJGb2J6MkpDSjMvbQpJelFBTjMrcEVMZk5wbk1mQlhjY3hWbjNhdUpnMnV5ZGVlM0ZQdmhMKzl6ODg4eFpsaG1SWmlNTWZqTUhCYkd2CklFekVocmV0L1lTSjg3Vnc0cjRReEhuZXVWUFFyaGhpbGFTRGxCSHpZZnpJcFNOMkIxRFRqMFdhR1YwdHp4OUwKem1FSlhwbGpVVmRqb2VqeGtieWwveXJQRW5wUWMyV1lBK3dHMGlZQTdmSkpKaFpROVNkUldOanU2OFJCbDRhTwoxdmlyRytIZnM5VVZHcThkR0hVQ0F3RUFBYU5aTUZjd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0hRWURWUjBPQkJZRUZKT205L3NqVS9vOUxMYUUzaUJVODQyZmpHNkJNQlVHQTFVZEVRUU8KTUF5Q0NtdDFZbVZ5Ym1WMFpYTXdEUVlKS29aSWh2Y05BUUVMQlFBRGdnRUJBRTJ3bUdJZ3oxUXRrVWpWaDJ1eQpQT2w5dStaTUd0ZlJLbVcreitUV2VHUjMrczFhL0hVTjFaOFBSUUNEU3ZWMFBNSVNBU2ZFNWVOSXBIejJValowCkVUR1gwVUJVYURWRDRXMVRWQ25qVjF3TTR0eDZjeHRVRTN3R1RaeElxdDBMRjczc2VLL0ZiTUZUUkUybDh6a3MKTVJMbnRDZmdrL0F2Uk5jeGpHOFB5S1ZCYlBlQjJpU3BZNmV5R2hoMGw3TVBIR0VIVkRQcVZEVTlBVTVtcmhxUwpaQlZWYmhib05PaG1YS2dFck4rZFZoK21RakN6bStGb0tZMVlmWkJWbjczTk9wMnlrMEZqcUlmN0R2WkxaZTRlClRyeEdxZHgzWkd2L0dmZEs5NUFwTWlibTdsRW9vNU5QZ0ovY1JvRjNoNHpUcy84WENtTERGVGNQWEQ1TCtSL3IKRzZjPQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==\",        \"server\": \"https://192.168.10.66:6443\"      },      \"name\": \"kubernetes\"    }  ],  \"contexts\": [    {      \"context\": {        \"cluster\": \"kubernetes\",        \"user\": \"kubernetes-admin\"      },      \"name\": \"kubernetes-admin@kubernetes\"    }  ],  \"current-context\": \"kubernetes-admin@kubernetes\",  \"kind\": \"Config\",  \"preferences\": {},  \"users\": [    {      \"name\": \"kubernetes-admin\",      \"user\": {        \"client-certificate-data\": \"LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURJVENDQWdtZ0F3SUJBZ0lJWTloV2diSkZ0NU13RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TXpBNE1EWXdPVEkyTlRKYUZ3MHlOREE0TURVd09USTJOVFphTURReApGekFWQmdOVkJBb1REbk41YzNSbGJUcHRZWE4wWlhKek1Sa3dGd1lEVlFRREV4QnJkV0psY201bGRHVnpMV0ZrCmJXbHVNSUlCSWpBTkJna3Foa2lHOXcwQkFRRUZBQU9DQVE4QU1JSUJDZ0tDQVFFQW10eWNHeGh3WXhma1YzWngKRGhiaUswVnh2Zk0zNUpwbEZFR1c2VDkvbDRDc3EzWTJqK1M2amErOWpkYTF3VE5WcmtGM0NWaU9ya2VzbmxPcQovM3RwRWxCdVMzYlBPTU4xbmdsUDNJbDlYRUlzU05WUkV6dWMvRlBJY0tCdzhjNVZnMFcveml6bVFIc2NRWXlBCmVTbjBRelI5OE1WWmVLbnlXTzZsQ0J4YklQSnlTd0xUOCtJbjlnSlNNV3BKb2JVa3dEbGd0MVVXY2RXNHRPV0YKdmJ3M01aRmNCMjZGNmI1QXNEczFJT1k2K3krM2tZbDdGU1BzK1dtYUxySmFQbWdmZFh4U3lzSEp6TWYyY3dQZApHZURtSUFXTWdoWmdPZ3VZd2tSZlB2NzNabkhYcmR6SFYzZUpFQVQ3ZWU4QnJtSnJ0eUtiTmdYbVhUVUl2ZFdoCjkyalZlUUlEQVFBQm8xWXdWREFPQmdOVkhROEJBZjhFQkFNQ0JhQXdFd1lEVlIwbEJBd3dDZ1lJS3dZQkJRVUgKQXdJd0RBWURWUjBUQVFIL0JBSXdBREFmQmdOVkhTTUVHREFXZ0JTVHB2ZjdJMVA2UFN5MmhONGdWUE9ObjR4dQpnVEFOQmdrcWhraUc5dzBCQVFzRkFBT0NBUUVBRFVXT05OM2RZWkhXaUx3ZmQzMlJDQlNkS1FjK05nTnptOTMxCkJ0SzZTQnhwbzlpaFZvNDRualBNL2xlWFhhRm5sT1Brc2xoc0ZhMFQwbFV1WmFMU2p3dm1mb3JkOS91eXA2K1oKWmtkREpXYldnN3Bvc0ZLNWxDVW15eWtNWXFmKzVsc1VQWW9VWVRWbW9xcEJ1aGIyZFUvMW8velcvYUo2UEtYawpmbVFMRWRuMStGY1VqVDhlYTBuNUxGUnJRbWxITWVNelRPcXI1VnlDM20yU1RXNFh5YUd4ZW1KV05HUEsvWitWCjVLcUwwSGdaUVhnNHp2cnNYalJTQk92MUZpTUNUZmhXZWszdkU0T2xNbDVHb2I0VndhejRzWmZzUVVzdFVFQWcKN0Z4NER5VThCU05QaFBldXJSKzlkdFMwQW8vdkQweUQvTTlmQjBZc2pHVnBlUVRWakE9PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==\",        \"client-key-data\": \"LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFb3dJQkFBS0NBUUVBbXR5Y0d4aHdZeGZrVjNaeERoYmlLMFZ4dmZNMzVKcGxGRUdXNlQ5L2w0Q3NxM1kyCmorUzZqYSs5amRhMXdUTlZya0YzQ1ZpT3JrZXNubE9xLzN0cEVsQnVTM2JQT01OMW5nbFAzSWw5WEVJc1NOVlIKRXp1Yy9GUEljS0J3OGM1VmcwVy96aXptUUhzY1FZeUFlU24wUXpSOThNVlplS255V082bENCeGJJUEp5U3dMVAo4K0luOWdKU01XcEpvYlVrd0RsZ3QxVVdjZFc0dE9XRnZidzNNWkZjQjI2RjZiNUFzRHMxSU9ZNit5KzNrWWw3CkZTUHMrV21hTHJKYVBtZ2ZkWHhTeXNISnpNZjJjd1BkR2VEbUlBV01naFpnT2d1WXdrUmZQdjczWm5IWHJkekgKVjNlSkVBVDdlZThCcm1KcnR5S2JOZ1htWFRVSXZkV2g5MmpWZVFJREFRQUJBb0lCQUZjSEwzdFNxcVlsb1I4OQo0cDhHWVNmc0tOV1V2NDVxN2U4S1JTTGptbktyejEyMFcwbFdRemlvMEovTFQrMDVTaWRaaHVucnFKTnNtQ2VKCjRZa2Q4NWhsTnZhVjJES1FOYU1Rbko3VmJXdlJqRTJLQTd3SlBsblhROGQzZ3NHQk1URkttMVhraWFrbkJtUVgKNzRNbi9xdGQ3b0RHaDFkMk9rbWNJNGFCV1AwVUl5QWJBR0Fjd1pvV3pNVkxGMlFqcldwa3F4VWxZSFZqMk5RMgo4dTVDZGdncTlTdDVZNmtiSzVUVGo3UXk3Z0pyOVNNM3ZhM1VOMk5QNzFQcFpiOWI1TGpPZ2Q5akR4Y1h4UnBUCk5ocG9lVCtTamxpenBLT0NOY0N6VkRGZ3ZGNnl3Z3JST2NxVWQ3YmhyU05BTXlCVkR0MElKWmNPbnUybTgxYzQKQlBDazNRRUNnWUVBd1dxQTZRSjZmRUVQbllTYlF6NkYvYlVVMjF5TnVWQWxiSTErVi95dExnK1pTNXU3RGg2bQpZUGl6bWtaS1N4cnpYb2Y4cVJiT3Y3Vi9ZbGlPZUJXMUIwVmIzS0NLcG1aTS9kVk9QQkRzTDIyN3RSdHpERjdnCkFlaUpUcVREOEJDaXEza3gxRGlrMTZSQ05oVEhVbTFJSUFxUS9GUkp5QmtrZkNST09BM29qa2tDZ1lFQXpQaDgKci9iVktaOWx5c09pNGR2dFVTM2F5allJaWFyWFA2REh5YU8zYVVJMnpxS0MrSXdyR0YzTTFPeE5OYzVZTHAxeAp1OGdUTi9rUEZMeFk4dG1FbDdzNEFhQ3FWcVFXTmMrTGdQNkRBQU9FZXJrdnVidllCRzV1QjMzdkpCWitOOFpnCmJxcVBxNzFhck1oY3V4dllTQzhqL01lSzVISmZRUGttUFZvK3piRUNnWUFNZUJKQmMxQjBMRG1XZlJNSlhjR0QKbnFYdWttUHNtM2NlTFcwRXZSeHBDTVpvTW16M3R4QWcxa2UxM1d3eXRWVVZOZzBhMVlhVW8xM0grRStPL0U5RQpYYnRUV09JM1lnYjZva0s5NnBWZlpXS2hoVmlBWnFsb1ZoWnNCSUZCTzhGUTdxcEF0VG9qVU1xWDgvVDVvbVB3CjlOMXQ5djBlc2toQTNKSlNXTXN5U1FLQmdRQ2tielNZZGd6TU4zUVNGcUMxVVJveDVmZUFBWmtYMkZhV1ZRWHkKWGNUbVRKaHJiVFJrOFE0aG5oNlZNbjAralN0eE9oM2o1NzZEU09zd1YybUVhYnhWZlh5UTBiUFZqZzNEWFowcwovd0ZaSVhsR2V3b3VsdVBWcWtIYkFNeTR4dEs3TEFwd3ZhUkV3c1BibVdITE9hdHBQV2hCZ2xPS3NiWjVDV2dFCkVFSVNBUUtCZ0RUS2NQeTlMQ3JnZVZSV3RnL1dFREIwd2JNbXRUQ24yUjBpUkZmSndWMi9qaFFkSmZranp6SkkKVUJKRE10V0JtZnp2V05BckJXMWZDczlodk1vUEUxRExENU1FNWZtT0lGcmNWQzdGaG5JZHZtTnNTU2U4WERnbgo1YkZqZXAyanhodWx5bXY3ZVdkMFVTSDdHQ24yZFZUdDdpdWJuZjdWZlVhclNkRHhLdVN0Ci0tLS0tRU5EIFJTQSBQUklWQVRFIEtFWS0tLS0tCg==\"      }    }  ]}', '', '', '', '1', '', '0', '0', '');
COMMIT;

-- ----------------------------
-- Table structure for cmdb_business_cluster_service
-- ----------------------------
DROP TABLE IF EXISTS `cmdb_business_cluster_service`;
CREATE TABLE `cmdb_business_cluster_service` (
  `service_tpl` bigint(20) NOT NULL COMMENT '业务集群模版名称',
  `cluster_tpl` bigint(20) NOT NULL COMMENT '业务集群模版备注',
  KEY `svc_tpl` (`service_tpl`) USING BTREE COMMENT '用于服务模版查询关联',
  KEY `cluster_tpl` (`cluster_tpl`) USING BTREE COMMENT '用于集群模版查询关联'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of cmdb_business_cluster_service
-- ----------------------------
BEGIN;
INSERT INTO `cmdb_business_cluster_service` VALUES (1, 0);
INSERT INTO `cmdb_business_cluster_service` VALUES (2, 0);
COMMIT;

-- ----------------------------
-- Table structure for cmdb_business_cluster_template
-- ----------------------------
DROP TABLE IF EXISTS `cmdb_business_cluster_template`;
CREATE TABLE `cmdb_business_cluster_template` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '对象Id',
  `create_at` bigint(20) DEFAULT NULL COMMENT '创建时间(13位时间戳)',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `update_at` bigint(20) DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人',
  `name` varchar(255) NOT NULL COMMENT '业务集群模版名称',
  `remark` varchar(255) DEFAULT NULL COMMENT '业务集群模版备注',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`) USING BTREE COMMENT '用于业务集群模版名搜索',
  KEY `idx_remark` (`remark`) USING BTREE COMMENT '用于业务集群模版备注搜索'
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of cmdb_business_cluster_template
-- ----------------------------
BEGIN;
INSERT INTO `cmdb_business_cluster_template` VALUES (2, 0, '', 0, '', 'a-prod-cluster', 'a 测试集群');
COMMIT;

-- ----------------------------
-- Table structure for cmdb_business_service_classify
-- ----------------------------
DROP TABLE IF EXISTS `cmdb_business_service_classify`;
CREATE TABLE `cmdb_business_service_classify` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '对象Id',
  `create_at` bigint(20) DEFAULT NULL COMMENT '创建时间(13位时间戳)',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `update_at` bigint(20) DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人',
  `name` varchar(255) DEFAULT NULL COMMENT '服务分类名称',
  `identifies` varchar(255) DEFAULT NULL COMMENT '服务分类标识',
  `level` bigint(20) DEFAULT '0' COMMENT '服务分类级别',
  `parent` bigint(20) DEFAULT '0' COMMENT '服务分类父级',
  `remark` varchar(255) NOT NULL COMMENT '服务模版备注',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`) USING BTREE COMMENT '用于服务分类名搜索',
  KEY `idx_remark` (`remark`) USING BTREE COMMENT '用于服务分类备注搜索'
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of cmdb_business_service_classify
-- ----------------------------
BEGIN;
INSERT INTO `cmdb_business_service_classify` VALUES (1, 0, '', 0, '', '数据库', 'database', 1, 0, '关系型数据库/非关系型数据库/分布式数据库');
INSERT INTO `cmdb_business_service_classify` VALUES (2, NULL, NULL, NULL, NULL, 'Etcd', 'etcd', 2, 1, 'etcd');
INSERT INTO `cmdb_business_service_classify` VALUES (3, NULL, NULL, NULL, NULL, 'MongoDB', 'mongodb', 2, 1, 'mongodb');
INSERT INTO `cmdb_business_service_classify` VALUES (4, NULL, NULL, NULL, NULL, 'MySQL', 'mysql', 2, 1, 'mysql');
INSERT INTO `cmdb_business_service_classify` VALUES (5, NULL, NULL, NULL, NULL, 'Redis', 'redis', 2, 1, 'redis');
INSERT INTO `cmdb_business_service_classify` VALUES (6, NULL, NULL, NULL, NULL, '消息队列', 'queue', 1, 0, '消息队列');
INSERT INTO `cmdb_business_service_classify` VALUES (7, NULL, NULL, NULL, NULL, 'Kafka', 'kafka', 2, 6, 'kafka');
INSERT INTO `cmdb_business_service_classify` VALUES (8, NULL, NULL, NULL, NULL, 'RabbitMQ', 'rabbitmq', 2, 6, 'rabbitmq');
INSERT INTO `cmdb_business_service_classify` VALUES (9, NULL, NULL, NULL, NULL, '存储', 'storage', 1, 0, '存储');
INSERT INTO `cmdb_business_service_classify` VALUES (10, NULL, NULL, NULL, NULL, 'NFS', 'nfs', 2, 9, 'nfs');
COMMIT;

-- ----------------------------
-- Table structure for cmdb_business_service_template
-- ----------------------------
DROP TABLE IF EXISTS `cmdb_business_service_template`;
CREATE TABLE `cmdb_business_service_template` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '对象Id',
  `create_at` bigint(20) DEFAULT NULL COMMENT '创建时间(13位时间戳)',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `update_at` bigint(20) DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人',
  `name` varchar(255) NOT NULL COMMENT '服务模版名称',
  `svc_classify` bigint(20) DEFAULT NULL COMMENT '服务分类',
  `remark` varchar(255) NOT NULL COMMENT '服务模版备注',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`) USING BTREE COMMENT '用于服务模版名搜索',
  KEY `idx_remark` (`remark`) USING BTREE COMMENT '用于服务模版备注搜索'
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of cmdb_business_service_template
-- ----------------------------
BEGIN;
INSERT INTO `cmdb_business_service_template` VALUES (1, NULL, NULL, NULL, NULL, 'qat-mysql', 4, '测试 mysql');
INSERT INTO `cmdb_business_service_template` VALUES (2, NULL, NULL, NULL, NULL, 'qat-redis', 5, '测试 redis');
INSERT INTO `cmdb_business_service_template` VALUES (3, NULL, NULL, NULL, NULL, 'qat-mongodb', 3, '测试 mongodb');
INSERT INTO `cmdb_business_service_template` VALUES (4, NULL, NULL, NULL, NULL, 'qat-etcd', 2, '测试 etcd');
INSERT INTO `cmdb_business_service_template` VALUES (5, NULL, NULL, NULL, NULL, 'qat-kafka', 7, '测试 kafka');
INSERT INTO `cmdb_business_service_template` VALUES (6, NULL, NULL, NULL, NULL, 'qat-rabbitmq', 8, '测试 rabbitmq');
INSERT INTO `cmdb_business_service_template` VALUES (7, NULL, NULL, NULL, NULL, 'qat-nfs', 10, '测试 nfs');
INSERT INTO `cmdb_business_service_template` VALUES (8, 0, '', 0, '', '1.1.1.1', 0, 'test create');
INSERT INTO `cmdb_business_service_template` VALUES (9, 0, '', 0, '', '1.1.1.1', 0, 'test create');
INSERT INTO `cmdb_business_service_template` VALUES (10, 0, '', 0, '', '1.1.1.1', 0, 'test create');
INSERT INTO `cmdb_business_service_template` VALUES (11, 0, '', 0, '', '1.1.1.1', 0, 'test create');
INSERT INTO `cmdb_business_service_template` VALUES (12, 0, '', 0, '', '1.1.1.1', 0, 'test create');
COMMIT;

-- ----------------------------
-- Table structure for cmdb_business_service_template_process
-- ----------------------------
DROP TABLE IF EXISTS `cmdb_business_service_template_process`;
CREATE TABLE `cmdb_business_service_template_process` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '对象Id',
  `create_at` bigint(20) DEFAULT NULL COMMENT '创建时间(13位时间戳)',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `update_at` bigint(20) DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人',
  `name` varchar(255) DEFAULT NULL COMMENT '名称',
  `alias` varchar(255) DEFAULT NULL COMMENT '别名',
  `start_params` varchar(255) DEFAULT NULL COMMENT '启动参数',
  `bind_ip` varchar(255) DEFAULT NULL COMMENT '绑定IP',
  `port` varchar(255) DEFAULT NULL COMMENT '端口',
  `protocol` varchar(255) DEFAULT NULL COMMENT '协议',
  `work_path` varchar(255) DEFAULT NULL COMMENT '工作路径',
  `start_user` varchar(255) DEFAULT NULL COMMENT '启动用户',
  `start_number` bigint(20) DEFAULT NULL COMMENT '启动数量',
  `start_priority` varchar(255) DEFAULT NULL COMMENT '启动优先级',
  `start_timeout` varchar(255) DEFAULT NULL COMMENT '启动超时时长(秒)',
  `start_command` varchar(255) DEFAULT NULL COMMENT '启动命令',
  `stop_command` varchar(255) DEFAULT NULL COMMENT '停止命令',
  `restart_command` varchar(255) DEFAULT NULL COMMENT '重启命令',
  `force_stop_command` varchar(255) DEFAULT NULL COMMENT '重启命令',
  `reload_command` varchar(255) DEFAULT NULL COMMENT '重载命令',
  `pid_path` varchar(255) DEFAULT NULL COMMENT 'PID 文件',
  `restart_interval` bigint(20) DEFAULT NULL COMMENT '重启间隔时间(秒)',
  `gateway_ip` varchar(255) DEFAULT NULL COMMENT '网关 IP',
  `gateway_port` varchar(255) DEFAULT NULL COMMENT '网关端口',
  `gateway_protocol` varchar(255) DEFAULT NULL COMMENT '网关协议',
  `svc_tpl` bigint(20) DEFAULT NULL COMMENT '绑定服务模板',
  `remark` varchar(255) NOT NULL COMMENT '服务模版备注',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`) USING BTREE COMMENT '用于服务分类名搜索',
  KEY `idx_remark` (`remark`) USING BTREE COMMENT '用于服务分类备注搜索'
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of cmdb_business_service_template_process
-- ----------------------------
BEGIN;
INSERT INTO `cmdb_business_service_template_process` VALUES (1, NULL, NULL, NULL, NULL, 'etcd', 'etcd', 'etcd', '127.0.0.1', '2379', 'tcp', '/apps/etcd/', 'etcd', 1, '1', '10', '/usr/bin/etcd', '/usr/bin/etcd stop', '/usr/bin/etcd restart', 'kill -9 etcd', '/usr/bin/etcd reload', '/var/run/etcd.pid', 10, '192.168.10.1', '2379', 'tcp', 4, 'etcd');
INSERT INTO `cmdb_business_service_template_process` VALUES (2, NULL, NULL, NULL, NULL, 'etcd', 'etcd', 'etcd', '127.0.0.1', '2379', 'tcp', '/apps/etcd/', 'etcd', 1, '1', '10', '/usr/bin/etcd', '/usr/bin/etcd stop', '/usr/bin/etcd restart', 'kill -9 etcd', '/usr/bin/etcd reload', '/var/run/etcd.pid', 10, '192.168.10.1', '2379', 'tcp', 4, 'etcd');
INSERT INTO `cmdb_business_service_template_process` VALUES (3, 0, '', 0, '', 'etcd1', '', '', '', '', '', '', '', 0, '', '', '', '', '', '', '', '', 0, '', '', '', 11, '');
INSERT INTO `cmdb_business_service_template_process` VALUES (4, 0, '', 0, '', 'etcd1', '', '', '', '', '', '', '', 0, '', '', '', '', '', '', '', '', 0, '', '', '', 12, '');
INSERT INTO `cmdb_business_service_template_process` VALUES (5, 0, '', 0, '', 'etcd2', '', '', '', '', '', '', '', 0, '', '', '', '', '', '', '', '', 0, '', '', '', 12, '');
COMMIT;

-- ----------------------------
-- Table structure for cmdb_hosts
-- ----------------------------
DROP TABLE IF EXISTS `cmdb_hosts`;
CREATE TABLE `cmdb_hosts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '对象Id',
  `create_at` bigint(20) NOT NULL COMMENT '创建时间(13位时间戳)',
  `create_by` varchar(255) NOT NULL COMMENT '创建人',
  `update_at` bigint(20) NOT NULL COMMENT '更新时间',
  `update_by` varchar(255) NOT NULL COMMENT '更新人',
  `name` varchar(255) NOT NULL COMMENT '主机名',
  `remark` varchar(255) NOT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`) USING BTREE COMMENT '用于主机名搜索',
  KEY `idx_remark` (`remark`) USING BTREE COMMENT '用于备注搜索'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of cmdb_hosts
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for cmdb_model_field
-- ----------------------------
DROP TABLE IF EXISTS `cmdb_model_field`;
CREATE TABLE `cmdb_model_field` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '对象Id',
  `create_at` bigint(20) DEFAULT NULL COMMENT '创建时间(13位时间戳)',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `update_at` bigint(20) DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人',
  `name` varchar(255) DEFAULT NULL COMMENT '字段名称',
  `identifies` varchar(255) DEFAULT NULL COMMENT '字段唯一标识,英文',
  `type` varchar(255) DEFAULT NULL COMMENT '字段类型,英文,字符,数字...',
  `is_edit` tinyint(1) DEFAULT NULL COMMENT '是否可编辑',
  `is_unique` tinyint(1) DEFAULT NULL COMMENT '是否唯一',
  `required` tinyint(1) DEFAULT NULL COMMENT '是否必填',
  `is_internal` tinyint(1) DEFAULT NULL COMMENT '是否内置',
  `prompt` tinyint(1) DEFAULT NULL COMMENT '用户提示',
  `configuration` longtext COMMENT '字段配置相关的，例如数字的最大，最小，步长，单位等数据',
  `field_group_id` bigint(20) DEFAULT NULL COMMENT '字段分组ID',
  `info_id` bigint(20) DEFAULT NULL COMMENT '对应的模型ID',
  `is_list_display` tinyint(1) DEFAULT NULL COMMENT '是否列表展示',
  `list_display_sort` bigint(20) DEFAULT NULL COMMENT '列表展示顺序',
  `remark` varchar(255) DEFAULT NULL COMMENT '字段备注',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`) USING BTREE COMMENT '用于字段名搜索',
  KEY `idx_remark` (`remark`) USING BTREE COMMENT '用于字段备注搜索'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of cmdb_model_field
-- ----------------------------
BEGIN;
INSERT INTO `cmdb_model_field` VALUES (1, NULL, NULL, NULL, NULL, 'built_in_host_innerip', '内网IP', 'string', 0, 0, 1, 0, NULL, '{\"is_edit\": true, \"regular\": \"^((1?\\\\d{1,2}|2[0-4]\\\\d|25[0-5])[.]){3}(1?\\\\d{1,2}|2[0-4]\\\\d|25[0-5])(,((1?\\\\d{1,2}|2[0-4]\\\\d|25[0-5])[.]){3}(1?\\\\d{1,2}|2[0-4]\\\\d|25[0-5]))*$\", \"enum_list\": [{\"uuid\": \"\", \"value\": \"\"}], \"list_value\": [{\"value\": \"\"}]}', 1, 1, 1, 1, '内网IP');
COMMIT;

-- ----------------------------
-- Table structure for cmdb_model_field_group
-- ----------------------------
DROP TABLE IF EXISTS `cmdb_model_field_group`;
CREATE TABLE `cmdb_model_field_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '对象Id',
  `create_at` bigint(20) DEFAULT NULL COMMENT '创建时间(13位时间戳)',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `update_at` bigint(20) DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人',
  `name` varchar(255) DEFAULT NULL COMMENT '分组字段名称',
  `sequence` bigint(20) DEFAULT NULL COMMENT '分组字段展示的顺序',
  `is_fold` tinyint(1) DEFAULT NULL COMMENT '分组是否折叠',
  `info_id` bigint(20) DEFAULT NULL COMMENT '对应的模型ID',
  `remark` varchar(255) DEFAULT NULL COMMENT '分组字段备注',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`) USING BTREE COMMENT '用于字段分组名搜索',
  KEY `idx_remark` (`remark`) USING BTREE COMMENT '用于服务分类备注搜索'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of cmdb_model_field_group
-- ----------------------------
BEGIN;
INSERT INTO `cmdb_model_field_group` VALUES (1, NULL, NULL, NULL, NULL, '基础信息', 1, 0, 1, NULL);
COMMIT;

-- ----------------------------
-- Table structure for cmdb_model_group
-- ----------------------------
DROP TABLE IF EXISTS `cmdb_model_group`;
CREATE TABLE `cmdb_model_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '对象Id',
  `create_at` bigint(20) DEFAULT NULL COMMENT '创建时间(13位时间戳)',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `update_at` bigint(20) DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人',
  `name` varchar(255) DEFAULT NULL COMMENT '服务分类名称',
  `identifies` varchar(255) DEFAULT NULL COMMENT '服务分类标识',
  `remark` varchar(255) DEFAULT NULL COMMENT '服务模版备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `identifies` (`identifies`),
  KEY `idx_name` (`name`) USING BTREE COMMENT '用于服务分类名搜索',
  KEY `idx_remark` (`remark`) USING BTREE COMMENT '用于服务分类备注搜索'
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of cmdb_model_group
-- ----------------------------
BEGIN;
INSERT INTO `cmdb_model_group` VALUES (1, NULL, NULL, NULL, NULL, '主机管理', 'built_in_host_manager', NULL);
INSERT INTO `cmdb_model_group` VALUES (2, NULL, NULL, NULL, NULL, '业务拓扑', 'built_in_business_topology', NULL);
COMMIT;

-- ----------------------------
-- Table structure for cmdb_model_info
-- ----------------------------
DROP TABLE IF EXISTS `cmdb_model_info`;
CREATE TABLE `cmdb_model_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '对象Id',
  `create_at` bigint(20) DEFAULT NULL COMMENT '创建时间(13位时间戳)',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `update_at` bigint(20) DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人',
  `name` varchar(255) DEFAULT NULL COMMENT '模型名称',
  `identifies` varchar(255) DEFAULT NULL COMMENT '模型唯一标识',
  `icon` varchar(255) DEFAULT NULL COMMENT '模型图标',
  `is_usable` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  `is_internal` tinyint(1) DEFAULT NULL COMMENT '是否内置',
  `group_id` bigint(20) DEFAULT NULL COMMENT '模型分组ID',
  `remark` varchar(255) DEFAULT NULL COMMENT '模型备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `identifies` (`identifies`),
  KEY `idx_name` (`name`) USING BTREE COMMENT '用于模型名搜索',
  KEY `idx_remark` (`remark`) USING BTREE COMMENT '用于模型备注搜索'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of cmdb_model_info
-- ----------------------------
BEGIN;
INSERT INTO `cmdb_model_info` VALUES (1, NULL, NULL, NULL, NULL, '主机', 'built_in_host', 'el-icon-notebook-2', 1, 0, 1, NULL);
INSERT INTO `cmdb_model_info` VALUES (2, NULL, NULL, NULL, NULL, '模块', 'built_in_module', 'el-icon-menu', 1, 0, 2, NULL);
INSERT INTO `cmdb_model_info` VALUES (3, NULL, NULL, NULL, NULL, '集群', 'built_in_set', 'el-icon-s-fold', 1, 0, 2, NULL);
COMMIT;

-- ----------------------------
-- Table structure for cmdb_resource_cloud_account
-- ----------------------------
DROP TABLE IF EXISTS `cmdb_resource_cloud_account`;
CREATE TABLE `cmdb_resource_cloud_account` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '对象Id',
  `create_at` bigint(20) DEFAULT NULL COMMENT '创建时间(13位时间戳)',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `update_at` bigint(20) DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人',
  `name` varchar(255) DEFAULT NULL COMMENT '服务分类名称',
  `type` varchar(255) DEFAULT NULL COMMENT '账户类型',
  `status` bigint(20) DEFAULT NULL COMMENT '账户状态',
  `secret` varchar(255) DEFAULT NULL COMMENT '账户 secret',
  `key` varchar(255) DEFAULT NULL COMMENT '账户 key',
  `remark` varchar(255) DEFAULT NULL COMMENT '服务模版备注',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`) USING BTREE COMMENT '用于服务分类名搜索',
  KEY `idx_remark` (`remark`) USING BTREE COMMENT '用于服务分类备注搜索'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of cmdb_resource_cloud_account
-- ----------------------------
BEGIN;
INSERT INTO `cmdb_resource_cloud_account` VALUES (1, 0, '', 0, '', '', '', 0, '', '', '');
COMMIT;

-- ----------------------------
-- Table structure for cmdb_resource_cloud_discovery
-- ----------------------------
DROP TABLE IF EXISTS `cmdb_resource_cloud_discovery`;
CREATE TABLE `cmdb_resource_cloud_discovery` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '对象Id',
  `create_at` bigint(20) DEFAULT NULL COMMENT '创建时间(13位时间戳)',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `update_at` bigint(20) DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人',
  `name` varchar(255) DEFAULT NULL COMMENT '资源同步任务名称',
  `resource_model` bigint(20) DEFAULT NULL COMMENT '资源模型',
  `resource_type` bigint(20) DEFAULT NULL COMMENT '资源类型',
  `cloud_account` bigint(20) DEFAULT NULL COMMENT '云账户',
  `region` varchar(255) DEFAULT NULL COMMENT '区域',
  `status` bigint(20) DEFAULT NULL COMMENT '任务状态',
  `field_map` varchar(255) DEFAULT NULL COMMENT '字段映射',
  `last_sync_status` bigint(20) DEFAULT NULL COMMENT '最近同步状态',
  `last_sync_time` bigint(20) DEFAULT NULL COMMENT '最近同步时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '服务模版备注',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`) USING BTREE COMMENT '用于服务分类名搜索',
  KEY `idx_remark` (`remark`) USING BTREE COMMENT '用于服务分类备注搜索'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of cmdb_resource_cloud_discovery
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for jobhub_hosts
-- ----------------------------
DROP TABLE IF EXISTS `jobhub_hosts`;
CREATE TABLE `jobhub_hosts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '对象Id',
  `create_at` bigint(20) NOT NULL COMMENT '创建时间(13位时间戳)',
  `create_by` varchar(255) NOT NULL COMMENT '创建人',
  `update_at` bigint(20) NOT NULL COMMENT '更新时间',
  `update_by` varchar(255) NOT NULL COMMENT '更新人',
  `name` varchar(255) NOT NULL COMMENT '主机名',
  `remark` varchar(255) NOT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`) USING BTREE COMMENT '用于主机名搜索',
  KEY `idx_remark` (`remark`) USING BTREE COMMENT '用于备注搜索'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of jobhub_hosts
-- ----------------------------
BEGIN;
INSERT INTO `jobhub_hosts` VALUES (1, 1691826551, 'ginkgo', 1691826551, 'ginkgo', '39.106.184.54', '阿里云');
INSERT INTO `jobhub_hosts` VALUES (3, 0, '', 0, '', '39.106.184.1', '阿里云');
COMMIT;

-- ----------------------------
-- Table structure for jobhub_template
-- ----------------------------
DROP TABLE IF EXISTS `jobhub_template`;
CREATE TABLE `jobhub_template` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '对象Id',
  `create_at` bigint(20) DEFAULT NULL COMMENT '创建时间(13位时间戳)',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `update_at` bigint(20) DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人',
  `name` varchar(255) DEFAULT NULL COMMENT '模版名',
  `icon` varchar(255) DEFAULT NULL COMMENT '模版图标',
  `type` varchar(255) DEFAULT NULL COMMENT '模版类型',
  `body` varchar(255) DEFAULT NULL COMMENT '模版内容',
  `interpreter` varchar(255) DEFAULT NULL COMMENT '模版解释器',
  `parameters` varchar(255) DEFAULT NULL COMMENT '执行参数',
  `hosts_ids` varchar(255) DEFAULT NULL COMMENT '主机id',
  `notice` varchar(255) DEFAULT NULL COMMENT '绑定通知',
  `remark` varchar(255) NOT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`) USING BTREE COMMENT '用于模版名搜索',
  KEY `idx_body` (`body`) USING BTREE COMMENT '用于模版内容搜索',
  KEY `idx_remark` (`remark`) USING BTREE COMMENT '用于模版备注搜索'
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of jobhub_template
-- ----------------------------
BEGIN;
INSERT INTO `jobhub_template` VALUES (5, 1694250008, 'user', 0, '', 'CentOS7系统初始化脚本', '', '1', '', '', '', '1', '', 'CentOS7系统初始化 Shell 脚本');
INSERT INTO `jobhub_template` VALUES (6, 1694250008, 'root', 0, '', 'CentOS7系统初始化脚本', '', '', '', '', '', '1', '', '');
INSERT INTO `jobhub_template` VALUES (7, 1694250008, 'root', 0, '', 'CentOS7系统初始化脚本', '', '1', '', '', '', '1', '', 'CentOS7系统初始化 Shell 脚本');
INSERT INTO `jobhub_template` VALUES (8, 1694250008, 'root', 0, '', 'CentOS7系统初始化脚本', 'centos7', '1', '', '', '', '1', '', 'CentOS7系统初始化 Shell 脚本');
COMMIT;

-- ----------------------------
-- Table structure for jobhub_template_type
-- ----------------------------
DROP TABLE IF EXISTS `jobhub_template_type`;
CREATE TABLE `jobhub_template_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '对象Id',
  `create_at` bigint(20) NOT NULL COMMENT '创建时间(13位时间戳)',
  `create_by` varchar(255) NOT NULL COMMENT '创建人',
  `update_at` bigint(20) NOT NULL COMMENT '更新时间',
  `update_by` varchar(255) NOT NULL COMMENT '更新人',
  `name` varchar(255) NOT NULL COMMENT '模版类型名',
  `remark` varchar(255) NOT NULL COMMENT '模版类型备注',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`) USING BTREE COMMENT '用于模版名搜索',
  KEY `idx_remark` (`remark`) USING BTREE COMMENT '用于模版备注搜索'
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of jobhub_template_type
-- ----------------------------
BEGIN;
INSERT INTO `jobhub_template_type` VALUES (1, 1691826570, 'ginkgo', 1691826570, 'ginkgo', '部署基础设施服务', '部署中间件、数据库、语言环境、消息队列、代理等基础设施服务');
INSERT INTO `jobhub_template_type` VALUES (3, 0, 'root', 0, '', '部署基础设施服务2', '部署中间件、数据库、语言环境、消息队列、代理等基础设施服务2');
INSERT INTO `jobhub_template_type` VALUES (4, 0, 'root', 0, '', '', '');
INSERT INTO `jobhub_template_type` VALUES (5, 0, 'root', 0, '', '1234', '1234');
COMMIT;

-- ----------------------------
-- Table structure for mcenter_code
-- ----------------------------
DROP TABLE IF EXISTS `mcenter_code`;
CREATE TABLE `mcenter_code` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '对象Id',
  `issue_at` bigint(20) NOT NULL COMMENT '发生事件',
  `code` bigint(20) NOT NULL COMMENT 'code 码',
  `username` varchar(255) NOT NULL COMMENT '用户名称',
  `expired_minute` bigint(20) DEFAULT NULL COMMENT '到期分钟数',
  PRIMARY KEY (`id`),
  KEY `idx_username` (`username`) USING BTREE COMMENT '用于 用户名 搜索',
  KEY `idx_code` (`code`) USING BTREE COMMENT '用于 code 搜索'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of mcenter_code
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for mcenter_domain
-- ----------------------------
DROP TABLE IF EXISTS `mcenter_domain`;
CREATE TABLE `mcenter_domain` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '对象Id',
  `create_at` bigint(20) DEFAULT NULL COMMENT '创建时间(13位时间戳)',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `update_at` bigint(20) DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人',
  `name` varchar(255) DEFAULT NULL COMMENT '域名',
  `owner` varchar(255) DEFAULT NULL COMMENT '归属人',
  `enabled` tinyint(1) DEFAULT NULL COMMENT '域状态,冻结时,域下面所有用户禁止登录',
  `logo_path` varchar(255) DEFAULT NULL COMMENT '公司 LOGO 图片的 URL',
  `remark` varchar(255) DEFAULT NULL COMMENT '描述',
  `phone` varchar(255) DEFAULT NULL COMMENT '电话',
  `size` varchar(255) DEFAULT NULL COMMENT '规模',
  `location` varchar(255) DEFAULT NULL COMMENT '位置: 指城市',
  `address` varchar(255) DEFAULT NULL COMMENT '地址: 比如环球中心',
  `industry` varchar(255) DEFAULT NULL COMMENT '所属行业,比如互联网',
  `fax` varchar(255) DEFAULT NULL COMMENT '传真',
  `feishu_enabled` varchar(255) DEFAULT NULL COMMENT '是否开启飞书认证',
  `user_ids_json` varchar(255) DEFAULT NULL COMMENT 'user_ids_json',
  `app_id` varchar(255) DEFAULT NULL COMMENT '飞书 client_id',
  `app_secret` varchar(255) DEFAULT NULL COMMENT '飞书 client_secret',
  `redirect_uri` varchar(255) DEFAULT NULL COMMENT '应用服务地址页面',
  `ldap_enabled` varchar(255) DEFAULT NULL COMMENT '是否开启 LDAP 认证',
  `url` varchar(255) DEFAULT NULL COMMENT 'LDAP Server URL',
  `bind_dn` varchar(255) DEFAULT NULL COMMENT '管理员用户名称',
  `bind_password` varchar(255) DEFAULT NULL COMMENT '管理员用户密码',
  `skip_verify` varchar(255) DEFAULT NULL COMMENT 'TLS是是否校验证书有效性',
  `base_dn` varchar(255) DEFAULT NULL COMMENT 'LDAP 服务器的登录用户名，必须是从根结点到用户节点的全路径',
  `user_filter` varchar(255) DEFAULT NULL COMMENT '用户过滤条件',
  `group_filter` varchar(255) DEFAULT NULL COMMENT '用户组过滤条件',
  `groupname_attribute` varchar(255) DEFAULT NULL COMMENT '组属性的名称',
  `username_attribute` varchar(255) DEFAULT NULL COMMENT '用户属性的名称',
  `mail_attribute` varchar(255) DEFAULT NULL COMMENT '用户邮箱属性的名称',
  `display_name_attribute` varchar(255) DEFAULT NULL COMMENT '用户显示名称属性名称',
  `data_sync` varchar(255) DEFAULT NULL COMMENT '新增用户或者注销用户时，是否同步, 默认不做同步, 只读区用户信息',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`) USING BTREE COMMENT '用于 domain 名搜索',
  KEY `idx_remark` (`remark`) USING BTREE COMMENT '用于 domain 备注搜索'
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of mcenter_domain
-- ----------------------------
BEGIN;
INSERT INTO `mcenter_domain` VALUES (1, 0, 'ginkgo', 0, 'ginkgo', 'default', 'ginkgo', 1, 'https://zcj.cn/1.jpg', '默认域', '110', '550', 'beijing', '环球中心', '互联网', '110', '1', '[1,2,3,4]', '12345', '12345', 'https://zcj.cn/feishu/index.html', '0', '1.1.1.1:389', 'admin', 'admin', '1', 'admin', 'user_filter', 'group_filter', 'admin', 'admin', 'admin', 'admin', '0');
INSERT INTO `mcenter_domain` VALUES (2, 0, '', 0, '', '', '', 0, '', '', '', '', '', '', '', '', '0', '', '', '', '', '0', '', '', '', '0', '', '', '', '', '', '', '', '0');
INSERT INTO `mcenter_domain` VALUES (3, 0, '', 0, '', '123', '', 0, '', '', '', '', '', '', '', '', '0', '', '', '', '', '0', '', '', '', '0', '', '', '', '', '', '', '', '0');
INSERT INTO `mcenter_domain` VALUES (4, 0, '', 0, '', '123', '', 0, '', '', '', '', '', '', '', '', '0', '', '', '', '', '0', '', '', '', '0', '', '', '', '', '', '', '', '0');
INSERT INTO `mcenter_domain` VALUES (5, 0, '', 0, '', '123', '', 0, '', '', '', '', '', '', '', '', '0', '', '', '', '', '0', '', '', '', '0', '', '', '', '', '', '', '', '0');
INSERT INTO `mcenter_domain` VALUES (6, 0, '', 0, '', '123', '', 0, '', '', '', '', '', '', '', '', '0', '', '', '', '', '0', '', '', '', '0', '', '', '', '', '', '', '', '0');
INSERT INTO `mcenter_domain` VALUES (7, 0, '', 0, '', '123', '', 0, '', '', '', '', '', '', '', '', '0', '', '', '', '', '0', '', '', '', '0', '', '', '', '', '', '', '', '0');
INSERT INTO `mcenter_domain` VALUES (8, 0, '', 0, '', '123', '', 0, '', '', '', '', '', '', '', '', '0', '', '', '', '', '0', '', '', '', '0', '', '', '', '', '', '', '', '0');
INSERT INTO `mcenter_domain` VALUES (9, 0, '', 0, '', '123', '', 0, '', 'default domain', '', '', '', '', '', '', '0', '', '', '', '', '0', '', '', '', '0', '', '', '', '', '', '', '', '0');
INSERT INTO `mcenter_domain` VALUES (10, 0, '', 0, '', '123', '', 0, '', 'default domain', '', '', '', '', '', '', '0', '', '', '', '', '0', '', '', '', '0', '', '', '', '', '', '', '', '0');
COMMIT;

-- ----------------------------
-- Table structure for mcenter_endpoint
-- ----------------------------
DROP TABLE IF EXISTS `mcenter_endpoint`;
CREATE TABLE `mcenter_endpoint` (
  `id` varchar(255) NOT NULL COMMENT '主键',
  `create_at` bigint(20) NOT NULL COMMENT '创建时间(13位时间戳)',
  `create_by` varchar(255) NOT NULL COMMENT '创建人',
  `update_at` bigint(20) NOT NULL COMMENT '更新时间',
  `update_by` varchar(255) NOT NULL COMMENT '更新人',
  `service_id` varchar(255) DEFAULT NULL COMMENT '该功能属于那个服务',
  `version` varchar(255) DEFAULT NULL COMMENT '服务那个版本的功能',
  `function_name` varchar(255) DEFAULT NULL COMMENT '函数名称',
  `path` varchar(255) DEFAULT NULL COMMENT 'HTTP path 用于自动生成http api',
  `method` varchar(255) DEFAULT NULL COMMENT 'HTTP method 用于自动生成http api',
  `resource` varchar(255) DEFAULT NULL COMMENT '资源名称',
  `auth_enable` varchar(255) DEFAULT NULL COMMENT '是否校验用户身份 (access_token 校验)',
  `code_enable` varchar(255) DEFAULT NULL COMMENT ' 验证码校验(开启双因子认证需要) (code 校验)',
  `permission_enable` varchar(255) DEFAULT NULL COMMENT '是否校验用户权限',
  `perms` varchar(100) DEFAULT NULL COMMENT '权限标识',
  `audit_log` tinyint(1) DEFAULT NULL COMMENT '是否开启操作审计, 开启后这次操作将被记录',
  `labels` varchar(255) DEFAULT NULL COMMENT '是否校验用户权限',
  PRIMARY KEY (`id`),
  KEY `idx_function_name` (`function_name`) USING BTREE COMMENT '用于 function_name 搜索'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of mcenter_endpoint
-- ----------------------------
BEGIN;
INSERT INTO `mcenter_endpoint` VALUES ('107f03da', 1694619276664, '', 1694619276664, '', 'a97824c3', '1', 'GetSecret', 'GET./cactik8s/api/v1/proxy/{nexus_id}/secrets/{name}', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('13587bb8', 1694619276664, '', 1694619276664, '', 'a97824c3', '1', 'QueryPersistentVolumeClaims', 'GET./cactik8s/api/v1/proxy/{nexus_id}/pvc', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('14e5683d', 1694437143894, '', 1694437143894, '', '2923f4a7', '1', 'DescribeTemplatetype', 'GET./jobhub/api/v1/templatetype/{id}', 'GET', 'templatetype', '1', '0', '1', '', 0, '{\"action\":\"get\"}');
INSERT INTO `mcenter_endpoint` VALUES ('166a9cf8', 1694619276664, '', 1694619276664, '', 'a97824c3', '1', 'ReDeployment', 'POST./cactik8s/api/v1/proxy/{nexus_id}/deployments/{name}/redeploy', 'POST', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('171a5708', 1694496280232, '', 1694496280232, '', '11fdd50a', '1', 'QueryNamespace', 'GET./mcenter/api/v1/namespace', 'GET', 'namespace', '1', '0', '1', 'sys:namespace:list', 0, '{\"action\":\"get\"}');
INSERT INTO `mcenter_endpoint` VALUES ('18975971', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'QueryRole', 'GET./mcenter/api/v1/role', 'GET', 'role', '1', '0', '1', 'sys:role:list', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('1a4c4be8', 1694619276664, '', 1694619276664, '', 'a97824c3', '1', 'GetConfigMap', 'GET./cactik8s/api/v1/proxy/{nexus_id}/configmaps/{name}', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('1b90caa2', 1694437143894, '', 1694437143894, '', '2923f4a7', '1', 'getSwagger', 'GET./apidocs.json', 'GET', '', '0', '0', '0', '', 0, 'null');
INSERT INTO `mcenter_endpoint` VALUES ('1c89247a', 1694437143894, '', 1694437143894, '', '2923f4a7', '1', 'UpdateTemplatetype', 'PUT./jobhub/api/v1/templatetype/{id}', 'PUT', 'templatetype', '1', '0', '1', '', 0, '{\"action\":\"update\"}');
INSERT INTO `mcenter_endpoint` VALUES ('1c9ad32f', 1694619276664, '', 1694619276664, '', 'a97824c3', '1', 'CreateDeployment', 'POST./cactik8s/api/v1/proxy/{nexus_id}/deployments', 'POST', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"create\"}');
INSERT INTO `mcenter_endpoint` VALUES ('20220eb2', 1694437143894, '', 1694437143894, '', '2923f4a7', '1', 'UpdateTemplate', 'PUT./jobhub/api/v1/template/{id}', 'PUT', 'template', '1', '0', '1', 'jobhub:template:update', 0, '{\"action\":\"update\"}');
INSERT INTO `mcenter_endpoint` VALUES ('219fdd56', 1694619276664, '', 1694619276664, '', 'a97824c3', '1', 'QuerySecret', 'GET./cactik8s/api/v1/proxy/{nexus_id}/secrets', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('25eb8b8a', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'ValidateToken', 'GET./mcenter/api/v1/token', 'GET', '', '0', '0', '0', '', 0, '{}');
INSERT INTO `mcenter_endpoint` VALUES ('29a19d5d', 1694582213009, '', 1694582213009, '', 'a97824c3', '1', 'CreateNexus', 'POST./cactik8s/api/v1/nexus', 'POST', 'nexus', '1', '0', '1', 'cactik8s:nexus:create', 0, '{\"action\":\"create\"}');
INSERT INTO `mcenter_endpoint` VALUES ('29d521ce', 1694619276664, '', 1694619276664, '', 'a97824c3', '1', 'GetNode', 'GET./cactik8s/api/v1/proxy/{nexus_id}/nodes/{name}', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('29fef34c', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'CreatePermission', 'POST./mcenter/api/v1/permission', 'POST', 'permission', '1', '0', '1', 'sys:permission:create', 0, '{\"action\":\"create\"}');
INSERT INTO `mcenter_endpoint` VALUES ('2a112d08', 1694437143894, '', 1694437143894, '', '2923f4a7', '1', 'DeleteTemplatetype', 'DELETE./jobhub/api/v1/templatetype/{id}', 'DELETE', 'templatetype', '1', '0', '1', '', 0, '{\"action\":\"delete\"}');
INSERT INTO `mcenter_endpoint` VALUES ('2bb3e35c', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'QueryPersistentVolumes', 'GET./cks/api/v1/proxy/{nexus_id}/pv', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('30571855', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'GetConfigMap', 'GET./cks/api/v1/proxy/{nexus_id}/configmaps/{name}', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('306a41db', 1694437143894, '', 1694437143894, '', '2923f4a7', '1', 'DeleteHosts', 'DELETE./jobhub/api/v1/hosts/{id}', 'DELETE', 'hosts', '1', '0', '1', '', 0, '{\"action\":\"delete\"}');
INSERT INTO `mcenter_endpoint` VALUES ('30b1aca4', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'QueryStorageClass', 'GET./cks/api/v1/proxy/{nexus_id}/sc', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('31205eae', 1694619276664, '', 1694619276664, '', 'a97824c3', '1', 'WatchConainterLog', 'GET./cactik8s/api/v1/proxy/{nexus_id}/pods/{name}/log', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('31b3a2d7', 1694496280232, '', 1694496280232, '', '11fdd50a', '1', 'DeleteNamespace', 'DELETE./mcenter/api/v1/namespace/{id}', 'DELETE', 'namespace', '1', '0', '1', 'sys:namespace:delete', 0, '{\"action\":\"delete\"}');
INSERT INTO `mcenter_endpoint` VALUES ('323fb215', 1694533694113, '', 1694533694113, '', 'a97824c3', '1', 'DeleteTemplatetype', 'DELETE./cactik8s/api/v1/templatetype/{id}', 'DELETE', 'templatetype', '1', '0', '1', 'cactik8s:templatetype:delete', 0, '{\"action\":\"delete\"}');
INSERT INTO `mcenter_endpoint` VALUES ('32ef15a4', 1694437143894, '', 1694437143894, '', '2923f4a7', '1', 'CreateHosts', 'POST./jobhub/api/v1/hosts', 'POST', 'hosts', '1', '0', '1', '', 0, '{\"action\":\"create\"}');
INSERT INTO `mcenter_endpoint` VALUES ('342581ed', 1694437143894, '', 1694437143894, '', '2923f4a7', '1', 'QueryTemplate', 'GET./jobhub/api/v1/template', 'GET', 'template', '1', '0', '1', 'jobhub:template:list', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('34f20c94', 1694619276664, '', 1694619276664, '', 'a97824c3', '1', 'CreateConfigMap', 'POST./cactik8s/api/v1/proxy/{nexus_id}/configmaps', 'POST', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"create\"}');
INSERT INTO `mcenter_endpoint` VALUES ('359b90a9', 1694495383757, '', 1694495383757, '', '11fdd50a', '1', 'QueryDomain', 'GET./mcenter/api/v1/domain', 'GET', 'domain', '1', '0', '1', '', 0, '{\"action\":\"get\"}');
INSERT INTO `mcenter_endpoint` VALUES ('373bb378', 1694582213009, '', 1694582213009, '', 'a97824c3', '1', 'UpdateNexus', 'PUT./cactik8s/api/v1/nexus/{id}', 'PUT', 'nexus', '1', '0', '1', 'cactik8s:nexus:update', 0, '{\"action\":\"update\"}');
INSERT INTO `mcenter_endpoint` VALUES ('39d3855a', 1694533694113, '', 1694533694113, '', 'a97824c3', '1', 'DescribeTemplatetype', 'GET./cactik8s/api/v1/templatetype/{id}', 'GET', 'templatetype', '1', '0', '1', 'cactik8s:templatetype:get', 0, '{\"action\":\"get\"}');
INSERT INTO `mcenter_endpoint` VALUES ('3a9b2ce2', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'QueryNamespaces', 'GET./cks/api/v1/proxy/{nexus_id}/namespaces', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('3ab6ea9d', 1694437143894, '', 1694437143894, '', '2923f4a7', '1', 'UpdateHosts', 'PUT./jobhub/api/v1/hosts/{id}', 'PUT', 'hosts', '1', '0', '1', '', 0, '{\"action\":\"update\"}');
INSERT INTO `mcenter_endpoint` VALUES ('41ab853d', 1694619276664, '', 1694619276664, '', 'a97824c3', '1', 'QueryPods', 'GET./cactik8s/api/v1/proxy/{nexus_id}/pods', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('4679c6dd', 1694619276664, '', 1694619276664, '', 'a97824c3', '1', 'CreateService', 'POST./cactik8s/api/v1/proxy/{nexus_id}/services', 'POST', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('46f44c22', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'getSwagger', 'GET./apidocs.json', 'GET', '', '0', '0', '0', '', 0, '{}');
INSERT INTO `mcenter_endpoint` VALUES ('4826140a', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'QueryPermission', 'GET./mcenter/api/v1/permission', 'GET', 'permission', '1', '0', '1', 'sys:permission:list', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('4b8fe4f3', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'QueryNodes', 'GET./cks/api/v1/proxy/{nexus_id}/nodes', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('4c65b9e5', 1694437143894, '', 1694437143894, '', '2923f4a7', '1', 'QueryTemplatetype', 'GET./jobhub/api/v1/templatetype', 'GET', 'templatetype', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('4db85b5c', 1694619276664, '', 1694619276664, '', 'a97824c3', '1', 'ScaleDeployment', 'POST./cactik8s/api/v1/proxy/{nexus_id}/deployments/{name}/scale', 'POST', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('4e92000a', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'DescribeEndpoint', 'GET./mcenter/api/v1/endpoint/{id}', 'GET', 'endpoint', '0', '0', '1', '', 0, '{}');
INSERT INTO `mcenter_endpoint` VALUES ('4f58a00a', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'PutUser', 'PUT./mcenter/api/v1/user/sub/{id}', 'PUT', 'user/sub', '1', '0', '1', 'sys:user:update', 0, '{\"action\":\"update\"}');
INSERT INTO `mcenter_endpoint` VALUES ('4fc59818', 1694437143894, '', 1694437143894, '', '2923f4a7', '1', 'DescribeHosts', 'GET./jobhub/api/v1/hosts/{id}', 'GET', 'hosts', '1', '0', '1', '', 0, '{\"action\":\"get\"}');
INSERT INTO `mcenter_endpoint` VALUES ('50381467', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'DeletePermission', 'DELETE./mcenter/api/v1/permission/{id}', 'DELETE', 'permission', '1', '0', '1', 'sys:permission:delete', 0, '{\"action\":\"delete\"}');
INSERT INTO `mcenter_endpoint` VALUES ('52240862', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'UpdatePassword', 'POST./mcenter/api/v1/account/password', 'POST', '', '1', '0', '0', '', 0, '{}');
INSERT INTO `mcenter_endpoint` VALUES ('5253214f', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'QueryUserPermTree', 'GET./mcenter/api/v1/permission/user/menu/tree', 'GET', 'permission', '1', '0', '0', '', 0, '{\"action\":\"get\"}');
INSERT INTO `mcenter_endpoint` VALUES ('529c4ae6', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'CreateNexus', 'POST./cks/api/v1/nexus', 'POST', 'nexus', '1', '0', '1', '', 0, '{\"action\":\"create\"}');
INSERT INTO `mcenter_endpoint` VALUES ('53d84ee3', 1694525111878, '', 1694525111878, '', '2923f4a7', '1', 'UpdateExeclog', 'PUT./jobhub/api/v1/execlog/{id}', 'PUT', 'execlog', '1', '0', '1', 'jobhub:execlog:update', 0, '{\"action\":\"update\"}');
INSERT INTO `mcenter_endpoint` VALUES ('547db6bb', 1694437143894, '', 1694437143894, '', '2923f4a7', '1', 'CreateTemplate', 'POST./jobhub/api/v1/template', 'POST', 'template', '1', '0', '1', 'jobhub:template:create', 0, '{\"action\":\"create\"}');
INSERT INTO `mcenter_endpoint` VALUES ('5782273e', 1694525111878, '', 1694525111878, '', '2923f4a7', '1', 'DescribeExeclog', 'GET./jobhub/api/v1/execlog/{id}', 'GET', 'execlog', '1', '0', '1', 'jobhub:execlog:get', 0, '{\"action\":\"get\"}');
INSERT INTO `mcenter_endpoint` VALUES ('57e37b10', 1694619276664, '', 1694619276664, '', 'a97824c3', '1', 'GetStatefulSet', 'GET./cactik8s/api/v1/proxy/{nexus_id}/statefulsets/{name}', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('584d8a65', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'CreateUser', 'POST./mcenter/api/v1/user/sub', 'POST', 'user/sub', '1', '0', '1', 'sys:user:create', 0, '{\"action\":\"create\"}');
INSERT INTO `mcenter_endpoint` VALUES ('5b22af04', 1694533694113, '', 1694533694113, '', 'a97824c3', '1', 'QueryTemplatetype', 'GET./cactik8s/api/v1/templatetype', 'GET', 'templatetype', '1', '0', '1', 'cactik8s:templatetype:list', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('5b7837e5', 1694582213009, '', 1694582213009, '', 'a97824c3', '1', 'QueryNexus', 'GET./cactik8s/api/v1/nexus', 'GET', 'nexus', '1', '0', '1', 'cactik8s:nexus:list', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('5d3c6456', 1694360744531, '', 1694360744531, '', '11fdd50a', '1', 'UnRegistryInstance', 'DELETE./mcenter/api/v1/instances/{instance_id}', 'DELETE', 'instances', '0', '0', '0', '', 0, '{}');
INSERT INTO `mcenter_endpoint` VALUES ('5e33b8c8', 1694525111878, '', 1694525111878, '', '2923f4a7', '1', 'QueryExeclog', 'GET./jobhub/api/v1/execlog', 'GET', 'execlog', '1', '0', '1', 'jobhub:execlog:list', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('5f7977ff', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'QueryConfigMap', 'GET./cks/api/v1/proxy/{nexus_id}/configmaps', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('65080f8f', 1694495383757, '', 1694495383757, '', '11fdd50a', '1', 'CreateDomain', 'POST./mcenter/api/v1/domain', 'POST', 'domain', '1', '0', '1', '', 0, '{\"action\":\"create\"}');
INSERT INTO `mcenter_endpoint` VALUES ('651a6bc9', 1694496280232, '', 1694496280232, '', '11fdd50a', '1', 'PutNamespace', 'PUT./mcenter/api/v1/namespace/{id}', 'PUT', 'namespace', '1', '0', '1', 'sys:namespace:update', 0, '{\"action\":\"update\"}');
INSERT INTO `mcenter_endpoint` VALUES ('65651a49', 1694437143894, '', 1694437143894, '', '2923f4a7', '1', 'Check', 'GET./jobhub/api/v1/health', 'GET', '', '0', '0', '0', '', 0, 'null');
INSERT INTO `mcenter_endpoint` VALUES ('68df5098', 1694582213009, '', 1694582213009, '', 'a97824c3', '1', 'DeleteNexus', 'DELETE./cactik8s/api/v1/nexus/{id}', 'DELETE', 'nexus', '1', '0', '1', 'cactik8s:nexus:delete', 0, '{\"action\":\"delete\"}');
INSERT INTO `mcenter_endpoint` VALUES ('69b0041', 1694495383757, '', 1694495383757, '', '11fdd50a', '1', 'DescribeDomain', 'GET./mcenter/api/v1/domain/{id}', 'GET', 'domain', '1', '0', '1', '', 0, '{\"action\":\"get\"}');
INSERT INTO `mcenter_endpoint` VALUES ('6b8f7b7d', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'QueryPermissionTree', 'GET./mcenter/api/v1/permission/menu/tree', 'GET', 'permission', '1', '0', '0', '', 0, '{\"action\":\"get\"}');
INSERT INTO `mcenter_endpoint` VALUES ('6c65f887', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'WatchConainterLog', 'GET./cks/api/v1/proxy/{nexus_id}/pods/{name}/log', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('6e50ae8c', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'LoginContainer', 'GET./cks/api/v1/proxy/{nexus_id}/pods/{name}/login', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('703373fe', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'RegistryEndpoint', 'POST./mcenter/api/v1/endpoint', 'POST', 'endpoint', '0', '0', '1', '', 0, '{}');
INSERT INTO `mcenter_endpoint` VALUES ('7068b09e', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'QueryNexus', 'GET./cks/api/v1/nexus', 'GET', 'nexus', '1', '0', '0', 'cks:nexus:list', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('752100cd', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'CreateNamespaces', 'POST./cks/api/v1/proxy/{nexus_id}/namespace', 'POST', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"create\"}');
INSERT INTO `mcenter_endpoint` VALUES ('75ac8fb6', 1694495383757, '', 1694495383757, '', '11fdd50a', '1', 'DeleteDomain', 'DELETE./mcenter/api/v1/domain/{id}', 'DELETE', '', '0', '0', '0', '', 0, '{}');
INSERT INTO `mcenter_endpoint` VALUES ('76bf86ff', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'CreateRole', 'POST./mcenter/api/v1/role', 'POST', 'role', '1', '0', '1', 'sys:role:create', 0, '{\"action\":\"create\"}');
INSERT INTO `mcenter_endpoint` VALUES ('790e42b2', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'CreateDeployment', 'POST./cks/api/v1/proxy/{nexus_id}/deployments', 'POST', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"create\"}');
INSERT INTO `mcenter_endpoint` VALUES ('7a0f84d3', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'ScaleDeployment', 'POST./cks/api/v1/proxy/{nexus_id}/deployments/{name}/scale', 'POST', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('7b439e3d', 1694619276664, '', 1694619276664, '', 'a97824c3', '1', 'GetDeployment', 'GET./cactik8s/api/v1/proxy/{nexus_id}/deployments/{name}', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('7ce00e16', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'CreatePod', 'POST./cks/api/v1/proxy/{nexus_id}/pods', 'POST', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('7df6b4a9', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'ReDeployment', 'POST./cks/api/v1/proxy/{nexus_id}/deployments/{name}/redeploy', 'POST', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('7f7d5157', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'QuerySecret', 'GET./cks/api/v1/proxy/{nexus_id}/secrets', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('8211e3c0', 1694533694113, '', 1694533694113, '', 'a97824c3', '1', 'Check', 'GET./cactik8s/api/v1/health', 'GET', '', '0', '0', '0', '', 0, 'null');
INSERT INTO `mcenter_endpoint` VALUES ('8212f974', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'DeleteUser', 'DELETE./mcenter/api/v1/user/sub/{id}', 'DELETE', 'user/sub', '1', '0', '1', 'sys:user:delete', 0, '{\"action\":\"delete\"}');
INSERT INTO `mcenter_endpoint` VALUES ('8354284f', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'DescribeUser', 'GET./mcenter/api/v1/user/sub/{id}', 'GET', 'user/sub', '1', '0', '1', 'sys:user:list', 0, '{\"action\":\"get\"}');
INSERT INTO `mcenter_endpoint` VALUES ('8847bbe5', 1694619276664, '', 1694619276664, '', 'a97824c3', '1', 'QueryService', 'GET./cactik8s/api/v1/proxy/{nexus_id}/services', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('88ea5d61', 1694360744531, '', 1694360744531, '', '11fdd50a', '1', 'RegistryInstance', 'POST./mcenter/api/v1/instances', 'POST', 'instances', '0', '0', '0', '', 0, '{}');
INSERT INTO `mcenter_endpoint` VALUES ('8d301999', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'DescribeRole', 'GET./mcenter/api/v1/role/{id}', 'GET', 'role', '1', '0', '1', 'sys:role:list', 0, '{\"action\":\"get\"}');
INSERT INTO `mcenter_endpoint` VALUES ('8e28385f', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'CreateSecret', 'POST./cks/api/v1/proxy/{nexus_id}/secrets', 'POST', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('8e716f47', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'CreateStatefulSet', 'POST./cks/api/v1/proxy/{nexus_id}/statefulsets', 'POST', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"create\"}');
INSERT INTO `mcenter_endpoint` VALUES ('90fb36cb', 1694619276664, '', 1694619276664, '', 'a97824c3', '1', 'GetPod', 'GET./cactik8s/api/v1/proxy/{nexus_id}/pods/{name}', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('9190abc3', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'DeleteService', 'DELETE./mcenter/api/v1/service/{id}', 'DELETE', 'service', '1', '0', '1', 'sys:service:delete', 0, '{\"action\":\"delete\"}');
INSERT INTO `mcenter_endpoint` VALUES ('9240b165', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'UpdatePermission', 'PUT./mcenter/api/v1/permission/{id}', 'PUT', 'permission', '1', '0', '1', 'sys:permission:update', 0, '{\"action\":\"update\"}');
INSERT INTO `mcenter_endpoint` VALUES ('9724b0cb', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'ResetPassword', 'POST./mcenter/api/v1/user/sub/{id}/password', 'POST', '', '0', '0', '0', '', 0, '{}');
INSERT INTO `mcenter_endpoint` VALUES ('9964f079', 1694619276664, '', 1694619276664, '', 'a97824c3', '1', 'QueryNamespaces', 'GET./cactik8s/api/v1/proxy/{nexus_id}/namespaces', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('9acede8a', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'QueryService', 'GET./cks/api/v1/proxy/{nexus_id}/services', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('9babcd3e', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'GetDeployment', 'GET./cks/api/v1/proxy/{nexus_id}/deployments/{name}', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('9bea5514', 1694619276664, '', 1694619276664, '', 'a97824c3', '1', 'QueryStatefulSet', 'GET./cactik8s/api/v1/proxy/{nexus_id}/statefulsets', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('9e4ffcce', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'GetService', 'GET./cks/api/v1/proxy/{nexus_id}/services/{name}', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('9f492cc9', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'UpdateService', 'PUT./mcenter/api/v1/service/{id}', 'PUT', 'service', '1', '0', '1', 'sys:service:update', 0, '{\"action\":\"update\"}');
INSERT INTO `mcenter_endpoint` VALUES ('a00ddaec', 1694619276664, '', 1694619276664, '', 'a97824c3', '1', 'QueryConfigMap', 'GET./cactik8s/api/v1/proxy/{nexus_id}/configmaps', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('a14449f3', 1694619276664, '', 1694619276664, '', 'a97824c3', '1', 'GetService', 'GET./cactik8s/api/v1/proxy/{nexus_id}/services/{name}', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('a14badbc', 1694533694113, '', 1694533694113, '', 'a97824c3', '1', 'CreateTemplatetype', 'POST./cactik8s/api/v1/templatetype', 'POST', 'templatetype', '1', '0', '1', 'cactik8s:templatetype:create', 0, '{\"action\":\"create\"}');
INSERT INTO `mcenter_endpoint` VALUES ('a16949b7', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'CreateConfigMap', 'POST./cks/api/v1/proxy/{nexus_id}/configmaps', 'POST', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"create\"}');
INSERT INTO `mcenter_endpoint` VALUES ('a402e5a3', 1694437143894, '', 1694437143894, '', '2923f4a7', '1', 'CreateTemplatetype', 'POST./jobhub/api/v1/templatetype', 'POST', 'templatetype', '1', '0', '1', '', 0, '{\"action\":\"create\"}');
INSERT INTO `mcenter_endpoint` VALUES ('a413439c', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'QueryService', 'GET./mcenter/api/v1/service', 'GET', 'service', '1', '0', '1', 'sys:service:list', 0, '{\"action\":\"get\"}');
INSERT INTO `mcenter_endpoint` VALUES ('a515bf', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'QueryStatefulSet', 'GET./cks/api/v1/proxy/{nexus_id}/statefulsets', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('a57d4923', 1694533694113, '', 1694533694113, '', 'a97824c3', '1', 'getSwagger', 'GET./apidocs.json', 'GET', '', '0', '0', '0', '', 0, 'null');
INSERT INTO `mcenter_endpoint` VALUES ('a7e78f1e', 1694437143894, '', 1694437143894, '', '2923f4a7', '1', 'QueryHosts', 'GET./jobhub/api/v1/hosts', 'GET', 'hosts', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('a842f2f1', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'Check', 'GET./cks/api/v1/health', 'GET', '', '0', '0', '0', '', 0, 'null');
INSERT INTO `mcenter_endpoint` VALUES ('ae91fec3', 1694619276664, '', 1694619276664, '', 'a97824c3', '1', 'QueryStorageClass', 'GET./cactik8s/api/v1/proxy/{nexus_id}/sc', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('b2ebc2d', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'QueryPersistentVolumeClaims', 'GET./cks/api/v1/proxy/{nexus_id}/pvc', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('b38fc80b', 1694619276664, '', 1694619276664, '', 'a97824c3', '1', 'QueryPersistentVolumes', 'GET./cactik8s/api/v1/proxy/{nexus_id}/pv', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('b4ec9c98', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'DescribeNexus', 'GET./cks/api/v1/nexus/{id}', 'GET', 'nexus', '1', '0', '0', 'cks:nexus:get', 0, '{\"action\":\"get\"}');
INSERT INTO `mcenter_endpoint` VALUES ('b6365a92', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'DeleteRole', 'DELETE./mcenter/api/v1/role/{id}', 'DELETE', 'role', '1', '0', '1', 'sys:role:delete', 0, '{\"action\":\"delete\"}');
INSERT INTO `mcenter_endpoint` VALUES ('b6a70fec', 1694619276664, '', 1694619276664, '', 'a97824c3', '1', 'CreateStatefulSet', 'POST./cactik8s/api/v1/proxy/{nexus_id}/statefulsets', 'POST', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"create\"}');
INSERT INTO `mcenter_endpoint` VALUES ('b98191f7', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'DeleteNexus', 'DELETE./cks/api/v1/nexus/{id}', 'DELETE', 'nexus', '1', '0', '0', 'cks:nexus:delete', 0, '{\"action\":\"delete\"}');
INSERT INTO `mcenter_endpoint` VALUES ('b9eede95', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'GetStatefulSet', 'GET./cks/api/v1/proxy/{nexus_id}/statefulsets/{name}', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('bc95fe41', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'PatchUser', 'PATCH./mcenter/api/v1/user/sub/{id}', 'PATCH', 'user/sub', '1', '0', '1', 'sys:user:update', 0, '{\"action\":\"update\"}');
INSERT INTO `mcenter_endpoint` VALUES ('bf488cfe', 1694496280232, '', 1694496280232, '', '11fdd50a', '1', 'DescribeNamespace', 'GET./mcenter/api/v1/namespace/{id}', 'GET', 'namespace', '1', '0', '1', 'sys:namespace:get', 0, '{\"action\":\"get\"}');
INSERT INTO `mcenter_endpoint` VALUES ('bffd4a39', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'GetNode', 'GET./cks/api/v1/proxy/{nexus_id}/nodes/{name}', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('c0d20181', 1694525111878, '', 1694525111878, '', '2923f4a7', '1', 'DeleteExeclog', 'DELETE./jobhub/api/v1/execlog/{id}', 'DELETE', 'execlog', '1', '0', '1', 'jobhub:execlog:delete', 0, '{\"action\":\"delete\"}');
INSERT INTO `mcenter_endpoint` VALUES ('c0ff8cb1', 1694619276664, '', 1694619276664, '', 'a97824c3', '1', 'LoginContainer', 'GET./cactik8s/api/v1/proxy/{nexus_id}/pods/{name}/login', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('c217a253', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'QueryUser', 'GET./mcenter/api/v1/user/sub', 'GET', 'user/sub', '1', '0', '1', 'sys:user:list', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('c75cfb2d', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'GetSecret', 'GET./cks/api/v1/proxy/{nexus_id}/secrets/{name}', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('ca366be3', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'UpdateDeployment', 'PUT./cks/api/v1/proxy/{nexus_id}/deployments/{name}', 'PUT', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('cb5a1de8', 1694437143894, '', 1694437143894, '', '2923f4a7', '1', 'DeleteTemplate', 'DELETE./jobhub/api/v1/template/{id}', 'DELETE', 'template', '1', '0', '1', 'jobhub:template:delete', 0, '{\"action\":\"delete\"}');
INSERT INTO `mcenter_endpoint` VALUES ('cd8b1a54', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'QueryEndpoints', 'GET./mcenter/api/v1/endpoint', 'GET', 'endpoint', '1', '0', '1', '', 0, '{}');
INSERT INTO `mcenter_endpoint` VALUES ('d3b14428', 1694619276664, '', 1694619276664, '', 'a97824c3', '1', 'CreateNamespaces', 'POST./cactik8s/api/v1/proxy/{nexus_id}/namespace', 'POST', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"create\"}');
INSERT INTO `mcenter_endpoint` VALUES ('d7d51c34', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'DescribePermission', 'GET./mcenter/api/v1/permission/{id}', 'GET', 'permission', '1', '0', '1', 'sys:permission:list', 0, '{\"action\":\"get\"}');
INSERT INTO `mcenter_endpoint` VALUES ('d7e19d75', 1694533694113, '', 1694533694113, '', 'a97824c3', '1', 'UpdateTemplatetype', 'PUT./cactik8s/api/v1/templatetype/{id}', 'PUT', 'templatetype', '1', '0', '1', 'cactik8s:templatetype:update', 0, '{\"action\":\"update\"}');
INSERT INTO `mcenter_endpoint` VALUES ('d835d00b', 1694360744531, '', 1694360744531, '', '11fdd50a', '1', 'SearchInstance', 'GET./mcenter/api/v1/instances', 'GET', 'instances', '0', '0', '0', '', 0, '{}');
INSERT INTO `mcenter_endpoint` VALUES ('d9b3d8a', 1694619276664, '', 1694619276664, '', 'a97824c3', '1', 'QueryNodes', 'GET./cactik8s/api/v1/proxy/{nexus_id}/nodes', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('da4f0b01', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'RevolkToken', 'DELETE./mcenter/api/v1/token', 'DELETE', 'token', '1', '0', '1', '', 0, '{\"action\":\"delete\"}');
INSERT INTO `mcenter_endpoint` VALUES ('dea1b847', 1694619276664, '', 1694619276664, '', 'a97824c3', '1', 'QueryDeployments', 'GET./cactik8s/api/v1/proxy/{nexus_id}/deployments', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('e1151f82', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'DescribeService', 'GET./mcenter/api/v1/service/{id}', 'GET', 'service', '1', '0', '1', 'sys:service:get', 0, '{\"action\":\"get\"}');
INSERT INTO `mcenter_endpoint` VALUES ('e2ed623d', 1694582213009, '', 1694582213009, '', 'a97824c3', '1', 'DescribeNexus', 'GET./cactik8s/api/v1/nexus/{id}', 'GET', 'nexus', '1', '0', '1', 'cactik8s:nexus:get', 0, '{\"action\":\"get\"}');
INSERT INTO `mcenter_endpoint` VALUES ('e5500a17', 1694497280834, '', 1694497280834, '', '11fdd50a', '1', 'Check', 'GET./mcenter/api/v1/health', 'GET', '', '0', '0', '0', '', 0, '{}');
INSERT INTO `mcenter_endpoint` VALUES ('e5e1335', 1694437143894, '', 1694437143894, '', '2923f4a7', '1', 'DescribeTemplate', 'GET./jobhub/api/v1/template/{id}', 'GET', 'template', '1', '0', '1', 'jobhub:template:get', 0, '{\"action\":\"get\"}');
INSERT INTO `mcenter_endpoint` VALUES ('e6e559b2', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'CreateService', 'POST./cks/api/v1/proxy/{nexus_id}/services', 'POST', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('ead359d7', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'UpdateNexus', 'PUT./cks/api/v1/nexus/{id}', 'PUT', 'nexus', '1', '0', '0', 'cks:nexus:update', 0, '{\"action\":\"update\"}');
INSERT INTO `mcenter_endpoint` VALUES ('eb1970de', 1694619276664, '', 1694619276664, '', 'a97824c3', '1', 'UpdateDeployment', 'PUT./cactik8s/api/v1/proxy/{nexus_id}/deployments/{name}', 'PUT', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('ee1d9b4e', 1694525111878, '', 1694525111878, '', '2923f4a7', '1', 'CreateExeclog', 'POST./jobhub/api/v1/execlog', 'POST', 'execlog', '1', '0', '1', 'jobhub:execlog:create', 0, '{\"action\":\"create\"}');
INSERT INTO `mcenter_endpoint` VALUES ('ee2af50e', 1694619276664, '', 1694619276664, '', 'a97824c3', '1', 'CreateSecret', 'POST./cactik8s/api/v1/proxy/{nexus_id}/secrets', 'POST', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('efc212cd', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'DeleteEndpoint', 'DELETE./mcenter/api/v1/endpoint/{id}', 'DELETE', 'endpoint', '1', '0', '1', '', 0, '{\"action\":\"delete\"}');
INSERT INTO `mcenter_endpoint` VALUES ('f15a844', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'UpdateRole', 'PUT./mcenter/api/v1/role/{id}', 'PUT', 'role', '1', '0', '1', 'sys:role:update', 0, '{\"action\":\"update\"}');
INSERT INTO `mcenter_endpoint` VALUES ('f37deb16', 1694496280232, '', 1694496280232, '', '11fdd50a', '1', 'CreateNamespace', 'POST./mcenter/api/v1/namespace', 'POST', 'namespace', '1', '0', '1', 'sys:namespace:create', 0, '{\"action\":\"create\"}');
INSERT INTO `mcenter_endpoint` VALUES ('f631e34e', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'QueryPods', 'GET./cks/api/v1/proxy/{nexus_id}/pods', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('f6c0ec32', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'GetPod', 'GET./cks/api/v1/proxy/{nexus_id}/pods/{name}', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('f722b89a', 1695311238710, '', 1695311238710, '', 'a97824c3', '1', 'QueryDeployments', 'GET./cks/api/v1/proxy/{nexus_id}/deployments', 'GET', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('f7d7b2fe', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'CreateService', 'POST./mcenter/api/v1/service', 'POST', 'service', '1', '0', '1', 'sys:service:create', 0, '{\"action\":\"create\"}');
INSERT INTO `mcenter_endpoint` VALUES ('f92595d5', 1694619276664, '', 1694619276664, '', 'a97824c3', '1', 'CreatePod', 'POST./cactik8s/api/v1/proxy/{nexus_id}/pods', 'POST', 'proxy', '1', '0', '1', '', 0, '{\"action\":\"list\"}');
INSERT INTO `mcenter_endpoint` VALUES ('febf7678', 1694495383757, '', 1694495383757, '', '11fdd50a', '1', 'PutDomain', 'PUT./mcenter/api/v1/domain/{id}', 'PUT', 'domain', '1', '0', '1', '', 0, '{\"action\":\"update\"}');
INSERT INTO `mcenter_endpoint` VALUES ('ff4012f8', 1694332149805, '', 1694332149805, '', '11fdd50a', '1', 'IssueToken', 'POST./mcenter/api/v1/token', 'POST', 'token', '0', '0', '0', '', 0, '{}');
COMMIT;

-- ----------------------------
-- Table structure for mcenter_instance
-- ----------------------------
DROP TABLE IF EXISTS `mcenter_instance`;
CREATE TABLE `mcenter_instance` (
  `id` varchar(255) NOT NULL COMMENT '对象Id',
  `create_at` bigint(20) NOT NULL COMMENT '创建时间(13位时间戳)',
  `create_by` varchar(255) NOT NULL COMMENT '创建人',
  `update_at` bigint(20) NOT NULL COMMENT '更新时间',
  `update_by` varchar(255) NOT NULL COMMENT '更新人',
  `domain` varchar(255) DEFAULT NULL COMMENT '服务所属域',
  `namespace` varchar(255) DEFAULT NULL COMMENT '服务所属空间',
  `service_name` varchar(255) DEFAULT NULL COMMENT '实例所属应用名称',
  `region` varchar(255) DEFAULT NULL COMMENT '实例所属地域, 默认default',
  `environment` varchar(255) DEFAULT NULL COMMENT '实例所属环境, 默认default',
  `cluster` varchar(255) DEFAULT NULL COMMENT '实例所属集群, 默认default',
  `group` varchar(255) DEFAULT NULL COMMENT '实例所属分组,默认default',
  `name` varchar(255) DEFAULT NULL COMMENT '实例名称, 如果不传, 则会随机生成',
  `protocol` varchar(255) DEFAULT NULL COMMENT '注册的对外的访问的协议',
  `address` varchar(255) DEFAULT NULL COMMENT '实例地址',
  `path` varchar(255) DEFAULT NULL COMMENT '健康检查URL',
  `health_interval` bigint(20) DEFAULT NULL COMMENT '健康检查时间间隔, 单位秒',
  `health_timeout` bigint(20) DEFAULT NULL COMMENT '健康检查超时时间, 单位秒',
  `version` varchar(255) DEFAULT NULL COMMENT '实例版本',
  `git_branch` varchar(255) DEFAULT NULL COMMENT '实例代码构建对应分支',
  `git_commit` varchar(255) DEFAULT NULL COMMENT '实例代码对应commit号',
  `build_at` bigint(20) DEFAULT NULL COMMENT '实例构建时间',
  `online` bigint(20) DEFAULT NULL COMMENT '上线时间',
  `stage` varchar(255) DEFAULT NULL COMMENT '服务状态',
  `status_update_at` bigint(20) DEFAULT NULL COMMENT '状态更新时间',
  `enabled` tinyint(1) DEFAULT NULL COMMENT '是否启用该实例',
  `config_update_at` bigint(20) DEFAULT NULL COMMENT '配置更新时间',
  `config_update_by` varchar(255) DEFAULT NULL COMMENT '配置更新人',
  `weight` bigint(20) DEFAULT '0' COMMENT '配置更新人',
  `heart_interval` bigint(20) DEFAULT NULL COMMENT '心跳间隔',
  `heart_timeout` bigint(20) DEFAULT NULL COMMENT '心跳超时时间, 单位秒',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`) USING BTREE COMMENT '用于 instance 搜索'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of mcenter_instance
-- ----------------------------
BEGIN;
INSERT INTO `mcenter_instance` VALUES ('4547788e', 0, '', 0, '', 'default', '', 'cmdb', 'default', 'default', 'default', 'default', 'ins-Fas7Cbxo', '0', '127.0.0.1:19003', '', 0, 0, '1', '', '', 0, 1695313119801, '0', 0, 1, 0, '0', 0, 0, 0);
COMMIT;

-- ----------------------------
-- Table structure for mcenter_namespace
-- ----------------------------
DROP TABLE IF EXISTS `mcenter_namespace`;
CREATE TABLE `mcenter_namespace` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '对象Id',
  `create_at` bigint(20) NOT NULL COMMENT '创建时间(13位时间戳)',
  `create_by` varchar(255) NOT NULL COMMENT '创建人',
  `update_at` bigint(20) NOT NULL COMMENT '更新时间',
  `update_by` varchar(255) NOT NULL COMMENT '更新人',
  `domain` varchar(255) DEFAULT NULL COMMENT '所属域 ID',
  `parent_id` varchar(255) DEFAULT NULL COMMENT '父 Namespace ID',
  `name` varchar(255) DEFAULT NULL COMMENT '空间名称',
  `owner` varchar(255) NOT NULL COMMENT '空间负责人',
  `enabled` tinyint(1) DEFAULT NULL COMMENT '禁用项目,该项目所有人都无法访问',
  `picture` varchar(255) DEFAULT NULL COMMENT '项目描述图片',
  `remark` varchar(255) DEFAULT NULL COMMENT '描述',
  `visible` varchar(255) DEFAULT NULL COMMENT '空间可见性,默认四有空间',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`) USING BTREE COMMENT '用于空间名搜索',
  KEY `idx_remark` (`remark`) USING BTREE COMMENT '用于空间备注搜索'
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of mcenter_namespace
-- ----------------------------
BEGIN;
INSERT INTO `mcenter_namespace` VALUES (1, 0, '', 0, '', '', '', '', '', 0, '', '', '0');
INSERT INTO `mcenter_namespace` VALUES (2, 0, '', 0, '', '', '', '', '', 0, '', '', '0');
INSERT INTO `mcenter_namespace` VALUES (3, 0, 'ginkgo', 0, 'ginkgo', 'default', '0', 'default', 'mcenter', 1, 'https://zcj.com/1.jpg', '默认名称空间', '0');
INSERT INTO `mcenter_namespace` VALUES (4, 0, '', 0, '', '', '', '', '', 0, '', '', '0');
INSERT INTO `mcenter_namespace` VALUES (5, 0, '', 0, '', '', '', '123', '', 0, '', '', '0');
INSERT INTO `mcenter_namespace` VALUES (6, 0, '', 0, '', '', '', '123', '', 0, '', '', '0');
COMMIT;

-- ----------------------------
-- Table structure for mcenter_permission
-- ----------------------------
DROP TABLE IF EXISTS `mcenter_permission`;
CREATE TABLE `mcenter_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '权限id',
  `name` varchar(255) NOT NULL COMMENT '菜单名称',
  `icon` varchar(255) DEFAULT NULL COMMENT '图标',
  `sort` int(11) DEFAULT '1' COMMENT '排序',
  `visible` int(11) DEFAULT '0' COMMENT '是否展示0.显示 1.隐藏',
  `service_id` int(11) DEFAULT NULL COMMENT '服务id',
  `resource_name` varchar(255) DEFAULT NULL COMMENT '资源列表',
  `parent_id` int(11) NOT NULL COMMENT '父级id',
  `router_path` varchar(255) DEFAULT NULL COMMENT '路由路径',
  `router_name` varchar(255) DEFAULT NULL COMMENT '路由名称',
  `page_path` varchar(255) DEFAULT NULL COMMENT '页面路径',
  `perms` varchar(255) DEFAULT '' COMMENT '权限标识',
  `type` int(11) DEFAULT NULL COMMENT '权限类型0.子系统 1.目录 2.菜单 3.按钮',
  `create_at` bigint(20) DEFAULT NULL COMMENT '创建时间',
  `update_at` bigint(20) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of mcenter_permission
-- ----------------------------
BEGIN;
INSERT INTO `mcenter_permission` VALUES (1, '管理中心', NULL, 1, 0, NULL, NULL, 0, '/mcenter', '管理中心', '', '', 0, 1693820431, 1694339339);
INSERT INTO `mcenter_permission` VALUES (2, '用户管理', NULL, 1, 0, NULL, NULL, 1, '/mcenter/user', '用户管理', '', '', 1, 1693820431, NULL);
INSERT INTO `mcenter_permission` VALUES (3, '用户列表', NULL, 1, 0, NULL, NULL, 2, '/mcenter/user/list', '用户列表', '', 'sys:user:list', 2, 1693820431, NULL);
INSERT INTO `mcenter_permission` VALUES (4, '新增用户', NULL, 1, 0, NULL, NULL, 3, '/mcenter/user/create', '新增用户', '', 'sys:user:create', 3, 1693820431, NULL);
INSERT INTO `mcenter_permission` VALUES (5, '删除用户', NULL, 1, 0, NULL, NULL, 3, '/mcenter/user/delete', '删除用户', '', 'sys:user:delete', 3, 1693820431, NULL);
INSERT INTO `mcenter_permission` VALUES (6, '更新用户', NULL, 1, 0, NULL, NULL, 3, '/mcenter/user/update', '更新用户', '', 'sys:user:update', 3, 1693820431, NULL);
INSERT INTO `mcenter_permission` VALUES (7, '角色管理', NULL, 1, 0, NULL, NULL, 1, '/mcenter/role', '角色管理', '', '', 1, 1693820431, NULL);
INSERT INTO `mcenter_permission` VALUES (8, '角色列表', NULL, 1, 0, NULL, NULL, 7, '/mcenter/role/list', '角色列表', '', 'sys:role:list', 2, 1693820431, NULL);
INSERT INTO `mcenter_permission` VALUES (9, '新增角色', NULL, 1, 0, NULL, NULL, 8, '/mcenter/role/create', '新增角色', '', 'sys:role:create', 3, 1693820431, NULL);
INSERT INTO `mcenter_permission` VALUES (10, '删除角色', NULL, 1, 0, NULL, NULL, 8, '/mcenter/role/delete', '删除角色', '', 'sys:role:delete', 3, 1693820431, NULL);
INSERT INTO `mcenter_permission` VALUES (11, '更新角色', NULL, 1, 0, NULL, NULL, 8, '/mcenter/role/update', '更新角色', '', 'sys:role:update', 3, 1693820431, NULL);
INSERT INTO `mcenter_permission` VALUES (12, '权限管理', NULL, 1, 0, NULL, NULL, 1, '/mcenter/permission', '权限管理', '', '', 1, 1693820431, NULL);
INSERT INTO `mcenter_permission` VALUES (13, '权限列表', NULL, 1, 0, NULL, NULL, 12, '/mcenter/permission/list', '权限列表', '', 'sys:permission:list', 2, 1693820431, NULL);
INSERT INTO `mcenter_permission` VALUES (14, '新增权限', NULL, 1, 0, NULL, NULL, 13, '/mcenter/permission/create', '新增权限', '', 'sys:permission:create', 3, 1693820431, NULL);
INSERT INTO `mcenter_permission` VALUES (15, '删除权限', NULL, 1, 0, NULL, NULL, 13, '/mcenter/permission/delete', '删除权限', '', 'sys:permission:delete', 3, 1693820431, NULL);
INSERT INTO `mcenter_permission` VALUES (16, '更新权限', NULL, 1, 0, NULL, NULL, 13, '/mcenter/permission/update', '更新权限', '', 'sys:permission:update', 3, 1693820431, NULL);
INSERT INTO `mcenter_permission` VALUES (17, '服务管理', '', 17, 0, 0, '', 1, '/mcenter/service', '服务管理', '', '', 1, 1694338618, 0);
INSERT INTO `mcenter_permission` VALUES (18, '服务列表', '', 18, 0, 0, '', 17, '/mcenter/service/list', '服务列表', '', 'sys:service:list', 2, 1694338755, 0);
INSERT INTO `mcenter_permission` VALUES (19, '新增服务', NULL, 19, 0, NULL, NULL, 18, '/mcenter/service/create', '新增服务', NULL, 'sys:service:create', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (20, '删除服务', NULL, 20, 0, NULL, NULL, 18, '/mcenter/service/delete', '删除服务', NULL, 'sys:service:delete', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (21, '更新服务', NULL, 21, 0, NULL, NULL, 18, '/mcenter/service/update', '更新服务', NULL, 'sys:service:update', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (22, '服务详情', NULL, 22, 0, NULL, NULL, 18, '/mcenter/service/get', '服务详情', NULL, 'sys:service:get', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (30, '任务中心', NULL, 30, 0, NULL, NULL, 0, '/jobhub', '任务中心', NULL, '', 0, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (31, '模版管理', NULL, 31, 0, NULL, NULL, 30, '/jobhub/template', '模板管理', NULL, '', 1, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (32, '模版列表', NULL, 32, 0, NULL, NULL, 31, '/jobhub/template/list', '模版列表', NULL, 'jobhub:template:list', 2, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (33, '新增模版', NULL, 33, 1, NULL, NULL, 31, '/jobhub/template/create', '新增模版', NULL, 'jobhub:template:create', 2, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (34, '删除模版', '', 34, 0, 0, '', 32, '/jobhub/template/delete', '删除模版', '', 'jobhub:template:delete', 3, 1694442043, 0);
INSERT INTO `mcenter_permission` VALUES (35, 'instance', NULL, 35, 0, NULL, NULL, 1, '/mcenter/instance', 'instance', NULL, 'sys:instance', 1, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (36, 'instance list', NULL, 36, 0, NULL, NULL, 35, '/mcenter/instance/list', 'instance list', NULL, 'sys:instance:list', 2, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (37, '模版类型管理', NULL, 37, 0, NULL, NULL, 30, '/jobhub/templatetype', '模版类型管理', NULL, '', 1, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (38, '模版类型列表', NULL, 38, 0, NULL, NULL, 37, '/jobhub/templatetype/list', '模版类型列表', NULL, 'jobhub:templatetype:list', 2, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (39, '新增模版类型', NULL, 39, 0, NULL, NULL, 38, '/jobhub/templatetype/create', '新增模版类型', NULL, 'jobhub:templatetype:create', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (40, '删除模版类型', NULL, 40, 0, NULL, NULL, 38, '/jobhub/templatetype/delete', '删除模版类型', NULL, 'jobhub:templatetype:delete', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (41, 'CMDB', NULL, 41, 0, NULL, NULL, 0, '/cmdb', 'CMDB', NULL, '', 0, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (42, '业务', NULL, 42, 0, NULL, NULL, 41, '/cmdb/business', '业务', NULL, '', 1, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (43, '集群模版', NULL, 43, 0, NULL, NULL, 42, '/cmdb/business/cluster-template/list', '集群模版列表', NULL, 'cmdb:cluster-template:list', 2, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (44, '新增集群模版', NULL, 44, 0, NULL, NULL, 43, '/cmdb/business/cluster-template/create', '新增集群模版', NULL, 'cmdb:cluster-template:create', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (45, '删除集群模版', NULL, 45, 0, NULL, NULL, 43, '/cmdb/business/cluster-template/delete', '删除集群模版', NULL, 'cmdb:cluster-template:delete', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (46, '更新集群模版', NULL, 46, 0, NULL, NULL, 43, '/cmdb/business/cluster-template/update', '更新集群模版', NULL, 'cmdb:cluster-template:update', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (47, '服务分类', NULL, 47, 0, NULL, NULL, 42, '/cmdb/business/service-classify', '服务分类', NULL, '', 1, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (48, '服务分类列表', NULL, 48, 0, NULL, NULL, 47, '/cmdb/business/service-classify/list', '服务分类列表', NULL, 'cmdb:service-classify:list', 2, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (49, '新增服务分类', NULL, 49, 0, NULL, NULL, 48, '/cmdb/business/service-classify/create', '新增服务分类', NULL, 'cmdb:service-classify:create', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (50, '删除服务分类', NULL, 50, 0, NULL, NULL, 48, '/cmdb/business/service-classify/delete', '删除服务分类', NULL, 'cmdb:service-classify:delete', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (51, '修改服务分类', NULL, 51, 0, NULL, NULL, 48, '/cmdb/business/service-classify/update', '修改服务分类', NULL, 'cmdb:service-classify:update', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (52, '服务模版', NULL, 52, 0, NULL, NULL, 42, '/cmdb/business/service-template', '服务模版', NULL, 'cmdb:service-template', 1, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (53, '服务模版列表', NULL, 53, 0, NULL, NULL, 52, '/cmdb/business/service-template/list', '服务模版列表', NULL, 'cmdb:service-template', 2, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (54, '新增服务模版', NULL, 54, 0, NULL, NULL, 53, '/cmdb/business/service-template', '新增服务模版', NULL, 'cmdb:service-template:create', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (55, '删除服务模版', NULL, 55, 0, NULL, NULL, 53, '/cmdb/business/service-template/delete', '删除服务模版', NULL, 'cmdb:service-template:delete', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (56, '修改服务模版', NULL, 56, 0, NULL, NULL, 53, '/cmdb/business/service-template/update', '修改服务模版', NULL, 'cmdb:service-template:update', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (57, '服务模版进程', NULL, 57, 0, NULL, NULL, 42, '/cmdb/business/service-template-process', '服务模版进程', NULL, '', 1, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (58, '服务模版进程列表', NULL, 58, 0, NULL, NULL, 57, '/cmdb/business/service-template-process/list', '服务模版进程列表', NULL, 'cmdb:service-template-process:list', 2, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (59, '新增服务模版进程', NULL, 59, 0, NULL, NULL, 58, '/cmdb/business/service-template-process/create', '新增服务模版进程', NULL, 'cmdb:service-template-process:create', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (60, '删除服务模版进程', NULL, 60, 0, NULL, NULL, 58, '/cmdb/business/service-template-process/delete', '删除服务模版进程', NULL, 'cmdb:service-template-process:delete', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (61, '修改服务模版进程', NULL, 61, 0, NULL, NULL, 58, '/cmdb/business/service-template-process/update', '修改服务模版进程', NULL, 'cmdb:service-template-process:update', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (62, '模型', NULL, 62, 0, NULL, NULL, 41, '/cmdb/model', '模型', NULL, '', 1, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (63, '模型分组', NULL, 63, 1, NULL, NULL, 62, '/cmdb/model/group/list', '模型分组', NULL, 'cmdb:model-group:list', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (64, '新增模型分组', NULL, 64, 0, NULL, NULL, 63, '/cmdb/model/group/create', '新增模型分组', NULL, 'cmdb:model-group:create', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (65, '删除模型分组', NULL, 65, 0, NULL, NULL, 63, '/cmdb/model/group/delete', '删除模型分组', NULL, 'cmdb:model-group:delete', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (66, '修改模型分组', NULL, 66, 0, NULL, NULL, 63, '/cmdb/model/group/update', '修改模型分组', NULL, 'cmdb:model-group:update', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (67, '模型字段分组', NULL, 67, 1, NULL, NULL, 62, '/cmdb/model/field-group', '模型字段分组', NULL, '', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (68, '字段分组列表', NULL, 68, 0, NULL, NULL, 67, '/cmdb/model/field-group/list', '字段分组列表', NULL, 'cmdb:model-field-group:list', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (69, '新增字段分组', NULL, 69, 0, NULL, NULL, 68, '/cmdb/model/field-group/create', '新增字段分组', NULL, 'cmdb:model-field-group:create', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (70, '删除字段分组', NULL, 70, 0, NULL, NULL, 68, '/cmdb/model/field-group/delete', '删除字段分组', NULL, 'cmdb:model-field-group:delete', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (71, '修改字段分组', NULL, 71, 0, NULL, NULL, 68, '/cmdb/model/field-group/update', '修改字段分组', NULL, 'cmdb:model-field-group:update', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (72, '模型字段', NULL, 72, 1, NULL, NULL, 62, '/cmdb/model/field', '模型字段', NULL, '', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (73, '模型字段列表', NULL, 73, 0, NULL, NULL, 72, '/cmdb/model/field/list', '字段列表', NULL, 'cmdb:model-field:list', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (74, '新增模型字段', NULL, 74, 0, NULL, NULL, 73, '/cmdb/model/field/create', '新增字段列表', NULL, 'cmdb:model-field:create', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (75, '删除模型字段', NULL, 75, 0, NULL, NULL, 73, '/cmdb/model/field/delete', '删除模型字段', NULL, 'cmdb:model-field:delete', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (76, '修改模型字段', NULL, 76, 0, NULL, NULL, 73, '/cmdb/model/field/update', '删除模型字段', NULL, 'cmdb:model-field:delete', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (77, '模型管理', NULL, 77, 0, NULL, NULL, 62, '/cmdb/model-manager', '模型管理', NULL, '', 2, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (78, '资源', NULL, 78, 0, NULL, NULL, 41, '/cmdb/resource', '资源', NULL, '', 1, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (79, '资源目录', NULL, 79, 1, NULL, NULL, 78, '/cmdb/resource/catalog', '资源目录', NULL, 'cmdb:resource-catalog:list', 2, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (80, '资源目录列表', NULL, 80, 1, NULL, NULL, 79, '/cmdb/resource/catalog/data/list', '资源目录数据', NULL, 'cmdb:resource-catalog:list', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (81, '自动发现', NULL, 81, 0, NULL, NULL, 78, '/cmdb/resource/discovery', '自动发现', NULL, '', 2, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (82, '公有云资源', NULL, 82, 0, NULL, NULL, 81, '/cmdb/resource/discovery/cloud', '公有云资源', NULL, 'cmdb:resource-discovery:cloud', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (83, 'esxi资源', NULL, 83, 0, NULL, NULL, 81, '/cmdb/resource/discovery/esxi', 'esxi资源', NULL, 'cmdb:resource-discovery:esxi', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (84, 'CKS', NULL, 84, 0, NULL, NULL, 0, '/cks', 'CKS', NULL, '', 0, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (85, '网络', NULL, 85, 0, NULL, NULL, 84, '/cks/network', '网络', NULL, '', 1, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (86, 'Service', NULL, 86, 0, NULL, NULL, 85, '/cks/network/service', 'Service', NULL, 'cks:network:service', 2, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (87, 'Ingress', NULL, 87, 0, NULL, NULL, 85, '/cks/network/ingress', 'Ingress', NULL, 'cks:network:ingress', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (88, '存储', NULL, 88, 0, NULL, NULL, 84, '/cks/storage', '存储', NULL, '', 1, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (89, 'PV', NULL, 89, 0, NULL, NULL, 88, '/cks/storage/pv', 'PV', NULL, 'cks:storage:pv', 2, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (90, 'PVC', NULL, 90, 0, NULL, NULL, 88, '/cks/storage/pvc', 'PVC', NULL, 'cks:storage:pvc', 2, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (91, '工作负载', NULL, 91, 0, NULL, NULL, 84, '/cks/workload', '工作负载', NULL, '', 1, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (92, 'Deployment', NULL, 92, 0, NULL, NULL, 91, '/cks/workload/deployment', 'Deployment', NULL, '', 2, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (93, 'Pod', NULL, 93, 0, NULL, NULL, 91, '/cks/workload/pod', 'Pod', NULL, '', 2, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (94, 'StatefulSet', NULL, 94, 0, NULL, NULL, 91, '/cks/workload/sts', 'StatefulSet', NULL, '', 2, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (95, 'DaemonSet', NULL, 95, 0, NULL, NULL, 91, '/cks/workload/ds', 'DaemonSet', NULL, '', 2, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (96, 'Job', NULL, 96, 0, NULL, NULL, 91, '/cks/workload/job', 'Job', NULL, '', 2, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (97, 'CronJob', NULL, 97, 0, NULL, NULL, 91, '/cks/workload/cronjob', 'CronJob', NULL, '', 2, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (98, 'StorageClass', NULL, 98, 0, NULL, NULL, 88, '/cks/storage/sc', 'StorageClass', NULL, '', 2, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (99, '配置', NULL, 99, 0, NULL, NULL, 84, '/cks/config', '配置', NULL, '', 1, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (100, 'ConfigMap', NULL, 100, 0, NULL, NULL, 99, '/cks/config/configmap', 'ConfigMap', NULL, '', 2, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (101, 'Secret', NULL, 101, 0, NULL, NULL, 99, '/cks/config/secret', 'Secret', NULL, '', 2, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (102, '集群', NULL, 102, 0, NULL, NULL, 84, '/cks/cluster', '集群', NULL, '', 1, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (103, '节点', NULL, 103, 0, NULL, NULL, 102, '/cks/cluster/node', '节点管理', NULL, '', 2, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (104, '任务管理', NULL, 104, 0, NULL, NULL, 30, '/jobhub/exec-task', '任务管理', NULL, '', 1, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (105, '执行记录', NULL, 105, 0, NULL, NULL, 104, '/jobhub/exec-task/history/list', '执行记录', NULL, '', 2, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (106, '运行任务', NULL, 106, 0, NULL, NULL, 104, '/jobhub/exec-task/run', '运行任务', NULL, '', 2, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (107, '运行任务模版', NULL, 107, 0, NULL, NULL, 106, '/jobhub/exec-task/template/run', '运行任务模版', NULL, 'jobhub:task:update', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (108, '删除历史任务', NULL, 108, 0, NULL, NULL, 105, '/jobhub/exec-task/history/delete', '删除历史任务', NULL, 'jobhub:task:delete', 3, NULL, NULL);
INSERT INTO `mcenter_permission` VALUES (109, '集群信息', NULL, 109, 0, NULL, NULL, 102, '/cks/cluster/info', '集群信息', NULL, '', 2, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for mcenter_role
-- ----------------------------
DROP TABLE IF EXISTS `mcenter_role`;
CREATE TABLE `mcenter_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `domain` varchar(255) DEFAULT NULL COMMENT '公司',
  `name` varchar(255) DEFAULT NULL COMMENT '角色名称',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `enabled` int(11) DEFAULT '0' COMMENT '是否启用 0.启用 1.禁用',
  `create_at` bigint(20) DEFAULT NULL COMMENT '创建时间',
  `update_at` bigint(20) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of mcenter_role
-- ----------------------------
BEGIN;
INSERT INTO `mcenter_role` VALUES (1, 'default', 'read-role', '测试创建角色同时添加用户/权限，只读角色', 0, 1694250170, 0);
INSERT INTO `mcenter_role` VALUES (8, '', 'test02', 'test02 remark', 0, 1694266648, 0);
COMMIT;

-- ----------------------------
-- Table structure for mcenter_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `mcenter_role_permission`;
CREATE TABLE `mcenter_role_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` bigint(20) DEFAULT NULL,
  `permission_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id_index` (`role_id`) USING BTREE,
  KEY `permission_id_index` (`permission_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of mcenter_role_permission
-- ----------------------------
BEGIN;
INSERT INTO `mcenter_role_permission` VALUES (1, 1, 1);
INSERT INTO `mcenter_role_permission` VALUES (2, 1, 2);
INSERT INTO `mcenter_role_permission` VALUES (3, 1, 3);
INSERT INTO `mcenter_role_permission` VALUES (4, 1, 7);
INSERT INTO `mcenter_role_permission` VALUES (5, 1, 8);
INSERT INTO `mcenter_role_permission` VALUES (6, 1, 12);
INSERT INTO `mcenter_role_permission` VALUES (7, 1, 13);
INSERT INTO `mcenter_role_permission` VALUES (26, 8, 17);
INSERT INTO `mcenter_role_permission` VALUES (27, 8, 18);
INSERT INTO `mcenter_role_permission` VALUES (28, 8, 30);
INSERT INTO `mcenter_role_permission` VALUES (29, 8, 31);
INSERT INTO `mcenter_role_permission` VALUES (30, 8, 32);
INSERT INTO `mcenter_role_permission` VALUES (31, 8, 33);
INSERT INTO `mcenter_role_permission` VALUES (32, 8, 34);
COMMIT;

-- ----------------------------
-- Table structure for mcenter_service
-- ----------------------------
DROP TABLE IF EXISTS `mcenter_service`;
CREATE TABLE `mcenter_service` (
  `id` varchar(255) NOT NULL COMMENT '对象Id',
  `create_at` bigint(20) NOT NULL COMMENT '创建时间(13位时间戳)',
  `create_by` varchar(255) NOT NULL COMMENT '创建人',
  `update_at` bigint(20) NOT NULL COMMENT '更新时间',
  `update_by` varchar(255) NOT NULL COMMENT '更新人',
  `domain` varchar(255) DEFAULT NULL COMMENT '服务所属域',
  `namespace` varchar(255) DEFAULT NULL COMMENT '服务所属空间',
  `owner` varchar(255) DEFAULT NULL COMMENT '应用所有者',
  `enabled` tinyint(1) DEFAULT NULL COMMENT '是否启用该服务, 服务如果被停用，将不会被发现',
  `name` varchar(255) DEFAULT NULL COMMENT '服务名称',
  `logo` varchar(255) DEFAULT NULL COMMENT 'logo',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `level` bigint(20) DEFAULT NULL COMMENT '服务等级,默认0',
  `client_enabled` tinyint(1) DEFAULT NULL COMMENT '是否启用客户端',
  `secret_update_at` bigint(20) DEFAULT NULL COMMENT '凭证更新时间',
  `client_id` varchar(255) DEFAULT NULL COMMENT '客户端ID',
  `client_secret` varchar(255) DEFAULT NULL COMMENT '客户端凭证',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`) USING BTREE COMMENT '用于空间名搜索',
  KEY `idx_remark` (`remark`) USING BTREE COMMENT '用于空间备注搜索'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of mcenter_service
-- ----------------------------
BEGIN;
INSERT INTO `mcenter_service` VALUES ('11fdd50a', 0, '', 0, '', 'default', 'default', 'admin', 1, 'mcenter', 'https://zcj.cn/service2.jpg', 'test service interface', 0, 0, 1694250287, 'X4uDSo2rYUM34ZDDlFMZMli9', 'dtwlvXbTFDvINKxqghCgElV5JvPHHDGN');
INSERT INTO `mcenter_service` VALUES ('2923f4a7', 0, '', 0, 'root', 'default', '', '', 1, 'jobhub', 'https://zcj.cn/jobhub.jpg', 'test jobhub service permission', 0, 0, 1694343054, 'yVgbr2rKOaNGHrKDyQu1rJu0', 'zbV8BclOcPkUP4DTa1eFeDfzD92vacy2');
INSERT INTO `mcenter_service` VALUES ('a97824c3', 0, '', 0, 'root', 'default', '', '', 1, 'cactik8s', 'https://zcj.cn/service3.jpg', 'cactik8s', 0, 0, 1694533631, 'wSCH9ZCgFGPkQOXqTZm0RI6g', 'oSicydE7Yivwbs21iH4VNNJNP3yqLPlu');
COMMIT;

-- ----------------------------
-- Table structure for mcenter_token
-- ----------------------------
DROP TABLE IF EXISTS `mcenter_token`;
CREATE TABLE `mcenter_token` (
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
  `meta` json DEFAULT NULL COMMENT '其他信息',
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`) USING BTREE,
  KEY `username_index` (`username`) USING BTREE,
  KEY `access_token_index` (`access_token`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of mcenter_token
-- ----------------------------
BEGIN;
INSERT INTO `mcenter_token` VALUES (1, 0, 'esNGUd6C9xfCt1DJmCavXQiW', 'txyxabt5ODxKyCaKLf6GUsQKPr3ggynU', 1694251357, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (2, 0, 'yJkcotgqLsqazcThHXXRZMEm', 'QroLsaaihbrhdGodYKvCIR07NKwPvV7u', 1694251783, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (3, 0, 'lge5riaHhsuSpbcZFA5ZQyBm', 'iYXsK7OxHIIP9spLFwvx1mh0KkSQe02G', 1694251959, 36000, 144000, 0, 'default', 'user', 2, 0, 0, '', '', '', 0, 1, 1694442193, '你于 2023-09-11T22:23:13+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (4, 0, 'ZtTqUlnXx8jmBEbDHgCod1Iq', 'ed4UkJfBqMLbOln43XOt0fK7f7KDFi4z', 1694263394, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (5, 0, 'FiLymhEbspU2glpj6VVDFkNz', 'sIuQiw9Gt9HH7BWwPG8I6rwFMlZMwwNf', 1694329455, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (6, 0, '9EaB8DLPRIvcVzlbTDyFC7ld', 'ufDxrAq86U7gtIjMcwk4pRpa82AjfuPX', 1694329471, 36000, 144000, 0, 'default', 'user', 2, 0, 0, '', '', '', 0, 1, 1694442193, '你于 2023-09-11T22:23:13+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (7, 0, 'xovHgkFJynuvHKvFcMQTwzej', 'jNf0p46QlUjb8exF9G7Oyg1zfE3MEdGu', 1694332009, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (8, 0, 'CxDJ3Nsghhbt0wdxb495Z6OK', 'mEz1ErkoPWmNN5LAJlntQbTu9Vqr02ud', 1694332162, 36000, 144000, 0, 'default', 'user', 2, 0, 0, '', '', '', 0, 1, 1694442193, '你于 2023-09-11T22:23:13+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (9, 0, 'xinIZejrT8nmC5o1AnetDx6N', 'u5dYcKrBj5T0WckPZz27KMsWxTm8Dm4Z', 1694332640, 36000, 144000, 0, 'default', 'user', 2, 0, 0, '', '', '', 0, 1, 1694442193, '你于 2023-09-11T22:23:13+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (10, 0, 'ZfdCJ01RcuTF3KvRg1SMQUIR', 'pei1wF9jQpHcMY2Qpgotxk0CyTFLBeBZ', 1694333136, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (11, 0, 'yaqUgnxu41rlqIBpO8MB1OBo', 'CjjteWwiiuQMxE59AMsRuYxFIdnU7a48', 1694333276, 36000, 144000, 0, 'default', 'user', 2, 0, 0, '', '', '', 0, 1, 1694442193, '你于 2023-09-11T22:23:13+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (12, 0, 'YJZcLTipBuREkm60LXoAslaE', 'JI566KaxqxLIfuriDhWlG2BCqCG43MjY', 1694338550, 36000, 144000, 0, 'default', 'user', 2, 0, 0, '', '', '', 0, 1, 1694442193, '你于 2023-09-11T22:23:13+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (13, 0, 'DyFKI6kCBfaomauFJapLoghz', 'atvkQDU1AKKQGEF9runHcZa4s9WX4ec2', 1694338580, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (14, 0, 'rr2n2jeCrO8hcdm1xMyoeJuv', 'HDr1wvy5cVCALyPk5Qwspz0hRe9x9oia', 1694339497, 36000, 144000, 0, 'default', 'user', 2, 0, 0, '', '', '', 0, 1, 1694442193, '你于 2023-09-11T22:23:13+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (15, 0, 'x8WELChzALrs3S2QUqVoIUTm', '6FaxCBBm3Wl9fMmrOwwKaCXfkmRaedng', 1694341728, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (16, 0, 'QfquLDkRp1tzUHFBS0Y7uX3U', '7xDABLq00ALarORc8J3u9kJFh3zPVcVZ', 1694341759, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (17, 0, 'TNUbjhnAdGSWmlWVLBmSkIZX', '28CZXTWlqtuXWQJKNEyZDo6qzZPH3HLp', 1694357554, 36000, 144000, 0, 'default', 'user', 2, 0, 0, '', '', '', 0, 1, 1694442193, '你于 2023-09-11T22:23:13+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (18, 0, 'CTj3Bzxqfjc3WyVSl71iWVhS', 'JiwG5MoGowpHZa2slog23ZuA0Qpe66mT', 1694435730, 36000, 144000, 0, 'default', 'user', 2, 0, 0, '', '', '', 0, 1, 1694442193, '你于 2023-09-11T22:23:13+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (19, 0, 'APlXRjchxolc3pFjoG2P07V5', 'gORLAsAhoyfF91PWWc2rzNgtumMn70Yg', 1694436738, 36000, 144000, 0, 'default', 'user', 2, 0, 0, '', '', '', 0, 1, 1694442193, '你于 2023-09-11T22:23:13+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (20, 0, 'sCo2CD9Rt9UdixDmo6VcQGSy', 'cfKueC2Y1miJy33JKGFJERHtQP7WvQgC', 1694436743, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (21, 0, 'GTCpmMxZi5SnhiVEKe5G8Cpe', 'CjeH62Quw5nH3YxVJoAUmLLjHNPz1Jkd', 1694437171, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (22, 0, 'LVX46Hdr8JjEu6BI5VYWemdu', 'NyKjV6X1dLgabjfEvZX50yRIw15eLV0d', 1694437291, 36000, 144000, 0, 'default', 'user', 2, 0, 0, '', '', '', 0, 1, 1694442193, '你于 2023-09-11T22:23:13+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (23, 0, 'kquBzUzmvym5qX7KfA5y9KtT', '8R0tedBXfEmqwhugA4oDRYANTXRJHm3B', 1694437458, 36000, 144000, 0, 'default', 'user', 2, 0, 0, '', '', '', 0, 1, 1694442193, '你于 2023-09-11T22:23:13+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (24, 0, 'Ihev3qzHo8Nyc236964hN51a', 'spBfJUslof9KvNI0Nzlapplz2MRqE1Sc', 1694437572, 36000, 144000, 0, 'default', 'user', 2, 0, 0, '', '', '', 0, 1, 1694442193, '你于 2023-09-11T22:23:13+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (25, 0, '2gElt4oVsb0TUS8XEYAgtkEn', '4REpgqRFexWkwozWIcSq4VvYZbLqXhxV', 1694440133, 36000, 144000, 0, 'default', 'user', 2, 0, 0, '', '', '', 0, 1, 1694442193, '你于 2023-09-11T22:23:13+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (26, 0, 'KyqZwQhDUuNfvLytkbLHEqfJ', 'YJH2gkTd9eNjUT8TDvdyEs7bJtfB119c', 1694440231, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (27, 0, 'ACGvkLNY3ktYwQwTKgUKL6xx', 'MXckj5in3tmHH1gLEkwVlCz1U0Kc4zGK', 1694440308, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (28, 0, 'NqxjFBcscDnrrWapbXDP8idL', '7mo4ZosJePwE2RIazTCiXaFMqujT4hhu', 1694440313, 36000, 144000, 0, 'default', 'user', 2, 0, 0, '', '', '', 0, 1, 1694442193, '你于 2023-09-11T22:23:13+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (29, 0, 'nWCWTgpmQBUv4neRjMSw0AZI', 'aquCzfe62MKoVcL9ZU1OkESMctCBCajZ', 1694440503, 36000, 144000, 0, 'default', 'user', 2, 0, 0, '', '', '', 0, 1, 1694442193, '你于 2023-09-11T22:23:13+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (30, 0, '5aqOq7JebMuWeesAmB2LxLTc', 'G7o5daPFwueuTP3ABq1BD493MgeVGTsy', 1694441576, 36000, 144000, 0, 'default', 'user', 2, 0, 0, '', '', '', 0, 1, 1694442193, '你于 2023-09-11T22:23:13+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (31, 0, 'XFzIPDz7FaQsbiraF3JdLRSU', 'kMa60ZGwOqqI4fTcVuZA54LeF9vLR3tP', 1694442023, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (32, 0, 'fw9rSP6D65HWxqBOQFrJb434', 'tyLhuIyTEWiYDhQa8e8L8NZK9py35VJW', 1694442193, 36000, 144000, 0, 'default', 'user', 2, 0, 0, '', '', '', 0, 0, 0, '', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (33, 0, 'aB26E4d43LYWCiOw0KmCoH3j', 'loeWlbrZXRm9IOjYtZYb4PSzPzdAqgTB', 1694443036, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (34, 0, 'aDaUS92oiOj6JH0c13mgZELO', 'sGrZvbxqqsRGfAH1eYI5KCWhbCddvlrs', 1694443094, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (35, 0, '0YWddxO8E93oO4Y8ttZ0LPcV', '4FudFEUcD2xARceaWNBewYAR6QoXG5T8', 1694443299, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (36, 0, 'u8yJOsYY7QNphErtQgRXegSl', 'qCartHDAiSAh9kI4kJLVbprixFCxacsY', 1694443320, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (37, 0, '8MZbUz8rPimArI6nLhndU8Wp', '8LfD9C8TFqCpMd3C7uxjwHRA0aUt16Ms', 1694443354, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (38, 0, 'tmsa32xjvtHwfok5pHqgn8wY', 'kGVC9RRStN5tkV04Ap7TCuoGnFYMmneC', 1694443364, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (39, 0, 'kU4VLIVMTTggdGVReO2ka1gJ', 'fD6qay8EqsBzqdEKJT5rvv6veQV1Mmh7', 1694443910, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (40, 0, 'Sa11oySMrg7aLuqiD51cY9B7', 'YLuibm4laDOeM9M6Hd1eD6SOFiG10tx7', 1694443927, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (41, 0, 'IbCkjDvKHvC620v3iahkJ63I', 'XX0mCfvGQjtGkxb6ZD3C6vN3f4m70Cks', 1694444821, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (42, 0, '5LictOxUM0nX2DEBjxw7LTku', 'Sz3GGRTrXdjTGP1bbGFRCaDgC47QgLkO', 1694444926, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (43, 0, 'HXwEssSoPX0mk7niKtaKEW99', 'CKZx6TkvAZssMauor0BvfKYEDo5BVvcn', 1694444988, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (44, 0, '3TZD5P06kIKiL25mo6QSHZKE', 'LAeTHwoX1VngMYCZxeT0MvfNiZDCSzXg', 1694445065, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (45, 0, 'lCBzok28QKzhTxm1xWfWdigE', 'CE08lhZPOnTDYMiGeZx5IjKBad1EcOsA', 1694445122, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (46, 0, 'KwJ00PsYED9liFa1G0rMXnho', 'dhhmU1ZxYpeEzFgEgTeRO5H47R8Ta7TW', 1694445344, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (47, 0, 'UOJo9twnvqkS6088ihi3qImt', 'qRc9wMoRZewymxDqHChvQOF38dVfLUdx', 1694445479, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (48, 0, '3CipxsAN1thucXmNJMow5Jlt', 'u2f45re0Mcy3tQWRFZhr1AisvG4sL9Hx', 1694445873, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (49, 0, 'f7QYJVFxkvGhIDOEHiEAb2ro', 'JcV0omf8Gnmn4zdoIoWBy4Ej80exIZcQ', 1694446085, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (50, 0, 'SYHmUmPmkgY3ElLMx3Ta8aiR', 'BIoxNIebDjkS9OwdIWNpSiwalKhCn8Sa', 1694446137, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (51, 0, 'rx8hMHWs48xFQZoO3e7XUPZv', 'Xv6NJEt3JkQ1lCcMefQRN2bfDs7CpdPs', 1694446643, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (52, 0, 'eal5fj3dR6zznjWgVSzQEiuu', 'Vyb4rWVvJ1mkCqvVUCFb5ai0rjBANg0W', 1694446835, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (53, 0, '5xYvK8uTXcEy0ZcZdu8SMfMH', 'Hj7ZXvSuKlLdLdsOF4afb6M3wcBNzQEI', 1694446873, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (54, 0, 'DGbEK0huNSeBQcAFzRv6c527', 'iBPH1vsNeFQ0QkVgPSvh1EI2kjjF8lcM', 1694446912, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (55, 0, 'cE3FzIRm0YscxRPclor7qSor', 'PmrQdzzt7WS79Lry9jwWVyzDLxtlovXR', 1694447020, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (56, 0, 'l49gilcvg4tfTqSnsBIACp9C', 'ORhjm2igTHayTMPGsS51fdB3qj2TMLDt', 1694447194, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (57, 0, 'KWx1rjgegBPuMiBx1RC1RiIK', 'tbq689SoHtrb9cQXdtpDKWprJ4kfaJZz', 1694447842, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (58, 0, 'Vt3seGtz0YZYpo7HZB4WcQ6J', 'ulbw2F8mS8fUAtoAKhzUbAlkyi8HfYLH', 1694448031, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (59, 0, 'XXVpggUTLLtIF9jL57ScBnuw', 'G7yuJobOkXFvXgwc1SRzei6WUdmentqK', 1694495400, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (60, 0, 'ucw7m4ZbxR4LT4UT5AlQ1Prr', 'Xylhx3GwEnD6kAO9uA0Gqduwr7GWkgkH', 1695186284, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (61, 0, 'Q6aH96PsuHUoa0fp2WtT5L79', '95itAIFcvlvO4Ya2kpmEfnYsX6IVKkKt', 1695186377, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (62, 0, 'QlzLrBCD6ityi6sYYVOvsKJY', 'cS45YEchVEeEmFlg2qS0YjxONqeK394H', 1695186393, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (63, 0, 'MAjiYSsD2jGuKBeoNIv5edkA', 'i0TnflzvgW1nTC9ciyVwkQozZY5z6S4x', 1695187040, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (64, 0, 'yP5g0Ee02JfvgjGGcbVPMGVy', 'U3NXxBd0TalUBeI0KcZVC7utqajOitet', 1695187094, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (65, 0, 'KJVh41zVxtFZGQIuySxdaNiz', 'qOWqRQkT4p8vD9iKPUVeV12piB1wSSTZ', 1695188807, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (66, 0, '53EQdtJQKzykJOksSChNE9Q0', '3yCjyzHXRUiI34XDYqO50Ppxah4Lkklc', 1695216120, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (67, 0, 'hEjgGDC4tMAcCJqQPDJ6cjPf', '0H4TJCRaLnNkAyMtDvk5eDa16xKy60li', 1695216341, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (68, 0, 'rW1SGIJkZLFaEFoHRec5mZmA', 'TdBoGy0PyoQGHM80uf2agSKThU48Mddl', 1695216482, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (69, 0, '6TZAp4np5KvkWyMXaq2MMQdB', 'PCFdwFllboNkaMlfksc0Jujq6cZIRX8F', 1695217512, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (70, 0, 'nwE1wJso3lGyZRosKmR1LxGW', 'b0EjWWMJVcGjr43djd7e1JUzddvDTLn6', 1695219145, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (71, 0, 'bkUvzyDL961VQft8ggS7X5pt', 'dVqOSlIRWzMsGpSkF6xAZPRvwzF930BL', 1695219182, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (72, 0, 'tc3sY5Jr1NCFj1NRk2zOyQI3', 'm2vYhTJZNsqZ9Soyx4up0aCXzyEOITIX', 1695275407, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (73, 0, 'Wn9NJfvFEk2BTbbCS8O5m9T8', 'QC5fRKrApvrGBZdvk87eppXeqbNDXez2', 1695275759, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (74, 0, 'hIIlR3GWAyEkUmkj71ZamwCx', 'YlAV6ELbdv97c84b3lk1fPgeVymZxa1g', 1695275901, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (75, 0, 'zPOIybcZNOaT4RrInRb0kzQ0', 'krPhH7SgYphY74b5PUECKh37QdCxGyT0', 1695298314, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (76, 0, 'NEHj8HESENCYwS4iRhF1tLXM', 'xLnYkQCSdB6EmodpcWwD1VgyO3ad54Gc', 1695299619, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (77, 0, 'RZog5RhBbGG06XEfpZAEFUSq', 'JCrhlczT2tRHAam0R7zTLzQJmum26VXu', 1695299662, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (78, 0, '3IvjqsSTi1X69CqcJBEQjsrj', 'rIV8ntNTlJmv34wEGrXE4Vf2NUtgs1z7', 1695300367, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (79, 0, 'Ha8lQrwth35hW5bjzMDUxTDN', 'uS9L5VbIdavqaQ8FGJ6sMfoOJG0R1dJJ', 1695300440, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (80, 0, 'MsQM2R7WNkRd6v8fvqHLmZ3V', 'kdVOg6RGxUDJfOoZebAkZZtoEGTFtqeq', 1695300559, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (81, 0, 'RV9C6xv8U9Cpf339NOyfWzmu', 'OoyuqTmtchJ9hVbC09tnrEt3qWbmpJfI', 1695300591, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (82, 0, 'tW0fNQoN3FrzSjghrtUomBeM', 'umlp7utaPdvDxnFJxxJ6uqqE8dia8TBL', 1695301411, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (83, 0, 'rawKCsshMDN8biwoAiuuCDfq', '4JAhZdbieZdp0p4i3FVDZ5ASxsOXN4qn', 1695303318, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (84, 0, 'JHkSNpH00vbbjmEUQ9eCFA0x', '9yIH8Po0q1tQf1fgICM6tCQ0Jnuy60uH', 1695305432, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (85, 0, 'P0qO8rLPD0bVqWZielax8GZR', 'mJc6nXXtrk14bqTxdarNtaxZKb0OrIlL', 1695307188, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (86, 0, 'ip0AYgnSWT9hTQbYLKYbU8Qz', 'M92cCSP6A1pxIw9i0ffxnWIpzfc84htv', 1695307466, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (87, 0, 'AZ0jdGZ8Zm48TC4Hd3X3rKjh', 'cy2sZW4czsHPX6OyCkqbLIOfeSu8ukQB', 1695309220, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 1, 1695311821, '你于 2023-09-21T23:57:01+08:00 从其他地方通过 PASSWORD 登录', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
INSERT INTO `mcenter_token` VALUES (88, 0, 'EKYdYMacNM3OWscOzpujIUmD', 'Lw6ETvHmm97D9oP5k0rwJQSVoRBlPFSr', 1695311821, 36000, 144000, 15, 'default', 'root', 1, 0, 0, '', '', '', 0, 0, 0, '', '', 0, '', '', '', '', '', '', '', '', '', '', '', 'null');
COMMIT;

-- ----------------------------
-- Table structure for mcenter_user
-- ----------------------------
DROP TABLE IF EXISTS `mcenter_user`;
CREATE TABLE `mcenter_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_at` bigint(20) NOT NULL COMMENT '创建时间(13位时间戳)',
  `create_by` varchar(255) NOT NULL COMMENT '创建人',
  `update_at` bigint(20) NOT NULL COMMENT '更新时间',
  `update_by` varchar(255) NOT NULL COMMENT '更新人',
  `provider` int(11) NOT NULL DEFAULT '0' COMMENT '帐号提供方0.本地数据库 1.LDAP 2.飞书',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '帐号类型0.子帐号 10.主帐号 15.超级管理员',
  `domain` varchar(255) DEFAULT NULL COMMENT '域信息',
  `username` varchar(255) DEFAULT NULL COMMENT '登录帐号',
  `password` varchar(255) DEFAULT NULL COMMENT '登录密码',
  `nick_name` varchar(255) DEFAULT '未命名' COMMENT '用户昵称',
  `remark` varchar(255) DEFAULT NULL COMMENT '用户描述',
  `gender` tinyint(1) NOT NULL DEFAULT '0' COMMENT '性别0.保密 1.男 2.女',
  `phone` varchar(255) DEFAULT NULL COMMENT '手机号码',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `language` varchar(255) DEFAULT NULL COMMENT '用户使用的语言',
  `address` varchar(255) DEFAULT NULL COMMENT '用户住址',
  `city` varchar(255) DEFAULT NULL COMMENT '用户所在地',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态0.激活 1.锁定 2.离职',
  `open_id` int(11) DEFAULT NULL COMMENT '用户在飞书应用内的唯一标识',
  `union_id` int(11) DEFAULT NULL COMMENT '飞书用户统一ID',
  `user_id` int(11) DEFAULT NULL COMMENT '飞书用户user id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of mcenter_user
-- ----------------------------
BEGIN;
INSERT INTO `mcenter_user` VALUES (1, 1694249969, '', 0, '', 0, 15, 'default', 'root', '$2a$10$DovX/19RZG2.78q1FXtIduA39FrraRLGiTAL/DJoovbx3wKtV7BJS', '', '', 0, '', '', '', '', '', '', 0, 0, 0, 0);
INSERT INTO `mcenter_user` VALUES (2, 1694250008, '', 0, '', 0, 0, 'default', 'user', '$2a$10$Yco2nVraiJpSgMLF0iLDyuI9EOvfO0pcDFtDKUsJddvE/Jy4Ik51i', '', '', 0, '', '', '', '', '', '', 0, 0, 0, 0);
COMMIT;

-- ----------------------------
-- Table structure for mcenter_user_role
-- ----------------------------
DROP TABLE IF EXISTS `mcenter_user_role`;
CREATE TABLE `mcenter_user_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色id',
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`) USING BTREE,
  KEY `role_id_index` (`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of mcenter_user_role
-- ----------------------------
BEGIN;
INSERT INTO `mcenter_user_role` VALUES (1, 2, 1);
INSERT INTO `mcenter_user_role` VALUES (9, 2, 8);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
