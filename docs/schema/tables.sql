CREATE TABLE IF NOT EXISTS `mcenter_code`
(
    `id`             INT UNSIGNED AUTO_INCREMENT             NOT NULL COMMENT '对象Id',
    `issue_at`       bigint                                  NOT NULL COMMENT '发生事件',
    `code`           bigint                                  NOT NULL COMMENT 'code 码',
    `username`       varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名称',
    `expired_minute` bigint COMMENT '到期分钟数',
    PRIMARY KEY (`id`),
    KEY `idx_username` (`username`) USING BTREE COMMENT '用于 用户名 搜索',
    KEY `idx_code` (`code`) USING BTREE COMMENT '用于 code 搜索'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci;


CREATE TABLE IF NOT EXISTS `mcenter_domain`
(
    `id`                     INT UNSIGNED AUTO_INCREMENT NOT NULL COMMENT '对象Id',
    `create_at`              bigint COMMENT '创建时间(13位时间戳)',
    `create_by`              varchar(255) COLLATE utf8mb4_general_ci COMMENT '创建人',
    `update_at`              bigint COMMENT '更新时间',
    `update_by`              varchar(255) COLLATE utf8mb4_general_ci COMMENT '更新人',

    `name`                   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '域名',
    `owner`                  varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '归属人',
    `enabled`                bool COMMENT '域状态,冻结时,域下面所有用户禁止登录',
    `logo_path`              varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '公司 LOGO 图片的 URL',
    `remark`                 varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '描述',
    `phone`                  varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '电话',
    `size`                   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '规模',
    `location`               varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '位置: 指城市',
    `address`                varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '地址: 比如环球中心',
    `industry`               varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '所属行业,比如互联网',
    `fax`                    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '传真',
    `feishu_enabled`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '是否开启飞书认证',
    `user_ids_json`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'user_ids_json',
    `app_id`                 varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '飞书 client_id',
    `app_secret`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '飞书 client_secret',
    `redirect_uri`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '应用服务地址页面',
    `ldap_enabled`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '是否开启 LDAP 认证',
    `url`                    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'LDAP Server URL',
    `bind_dn`                varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '管理员用户名称',
    `bind_password`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '管理员用户密码',
    `skip_verify`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'TLS是是否校验证书有效性',
    `base_dn`                varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'LDAP 服务器的登录用户名，必须是从根结点到用户节点的全路径',
    `user_filter`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '用户过滤条件',
    `group_filter`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '用户组过滤条件',
    `groupname_attribute`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '组属性的名称',
    `username_attribute`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '用户属性的名称',
    `mail_attribute`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '用户邮箱属性的名称',
    `display_name_attribute` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '用户显示名称属性名称',
    `data_sync`              varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '新增用户或者注销用户时，是否同步, 默认不做同步, 只读区用户信息',
    PRIMARY KEY (`id`),
    KEY `idx_name` (`name`) USING BTREE COMMENT '用于 domain 名搜索',
    KEY `idx_remark` (`remark`) USING BTREE COMMENT '用于 domain 备注搜索'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `mcenter_namespace`
(
    `id`        INT UNSIGNED AUTO_INCREMENT                                   NOT NULL COMMENT '对象Id',
    `create_at` bigint                                                        NOT NULL COMMENT '创建时间(13位时间戳)',
    `create_by` varchar(255) COLLATE utf8mb4_general_ci                       NOT NULL COMMENT '创建人',
    `update_at` bigint                                                        NOT NULL COMMENT '更新时间',
    `update_by` varchar(255) COLLATE utf8mb4_general_ci                       NOT NULL COMMENT '更新人',

    `domain`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '所属域 ID',
    `parent_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '父 Namespace ID',
    `name`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '空间名称',
    `owner`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '空间负责人',
    `enabled`   bool COMMENT '禁用项目,该项目所有人都无法访问',
    `picture`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '项目描述图片',
    `remark`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '描述',
    `visible`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '空间可见性,默认四有空间',
    PRIMARY KEY (`id`),
    KEY `idx_name` (`name`) USING BTREE COMMENT '用于空间名搜索',
    KEY `idx_remark` (`remark`) USING BTREE COMMENT '用于空间备注搜索'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `mcenter_service`
(
    `id`               varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '对象Id',
    `create_at`        bigint                                  NOT NULL COMMENT '创建时间(13位时间戳)',
    `create_by`        varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建人',
    `update_at`        bigint                                  NOT NULL COMMENT '更新时间',
    `update_by`        varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '更新人',

    `domain`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '服务所属域',
    `namespace`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '服务所属空间',
    `owner`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '应用所有者',
    `enabled`          bool COMMENT '是否启用该服务, 服务如果被停用，将不会被发现',
    `name`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '服务名称',
    `logo`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'logo',
    `remark`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '备注',
    `level`            bigint COMMENT '服务等级,默认0',
    `client_enabled`   bool COMMENT '是否启用客户端',
    `secret_update_at` bigint COMMENT '凭证更新时间',
    `client_id`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '客户端ID',
    `client_secret`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '客户端凭证',

    PRIMARY KEY (`id`),
    KEY `idx_name` (`name`) USING BTREE COMMENT '用于空间名搜索',
    KEY `idx_remark` (`remark`) USING BTREE COMMENT '用于空间备注搜索'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `mcenter_instance`
(
    `id`               varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '对象Id',
    `create_at`        bigint                                  NOT NULL COMMENT '创建时间(13位时间戳)',
    `create_by`        varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建人',
    `update_at`        bigint                                  NOT NULL COMMENT '更新时间',
    `update_by`        varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '更新人',
    `domain`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '服务所属域',
    `namespace`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '服务所属空间',
    `service_name`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '实例所属应用名称',
    `region`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '实例所属地域, 默认default',
    `environment`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '实例所属环境, 默认default',
    `cluster`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '实例所属集群, 默认default',
    `group`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '实例所属分组,默认default',
    `name`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '实例名称, 如果不传, 则会随机生成',
    `protocal`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '注册的对外的访问的协议',
    `address`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '实例地址',
    `path`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '健康检查URL',
    `health_interval`  bigint COMMENT '健康检查时间间隔, 单位秒',
    `health_timeout`   bigint COMMENT '健康检查超时时间, 单位秒',
    `version`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '实例版本',
    `git_branch`       varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '实例代码构建对应分支',
    `git_commit`       varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '实例代码对应commit号',
    `build_at`         bigint COMMENT '实例构建时间',
    `online`           bigint COMMENT '上线时间',
    `stage`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '服务状态',
    `status_update_at` bigint COMMENT '状态更新时间',
    `enabled`          bool COMMENT '是否启用该实例',
    `config_update_at` bigint COMMENT '配置更新时间',
    `config_update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '配置更新人',
    `heart_interval`   bigint COMMENT '心跳间隔',
    `heart_timeout`    bigint COMMENT '心跳超时时间, 单位秒',
    PRIMARY KEY (`id`),
    KEY `idx_name` (`name`) USING BTREE COMMENT '用于 instance 搜索'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

DROP TABLE IF EXISTS `mcenter_user`;
CREATE TABLE `mcenter_user`
(
    `id`        int(11)                                 NOT NULL AUTO_INCREMENT COMMENT '主键',
    `create_at` bigint                                  NOT NULL COMMENT '创建时间(13位时间戳)',
    `create_by` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建人',
    `update_at` bigint                                  NOT NULL COMMENT '更新时间',
    `update_by` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '更新人',
    `provider`  int(11)                                 NOT NULL DEFAULT '0' COMMENT '帐号提供方0.本地数据库 1.LDAP 2.飞书',
    `type`      int(11)                                 NOT NULL DEFAULT '0' COMMENT '帐号类型0.子帐号 10.主帐号 15.超级管理员',
    `domain`    varchar(255)                                     DEFAULT NULL COMMENT '域信息',
    `username`  varchar(255)                                     DEFAULT NULL COMMENT '登录帐号',
    `real_name`  varchar(255)                                     DEFAULT NULL COMMENT '真实姓名',
    `password`  varchar(255)                                     DEFAULT NULL COMMENT '登录密码',
    `nick_name` varchar(255)                                     DEFAULT '未命名' COMMENT '用户昵称',
    `remark`    varchar(255)                                     DEFAULT NULL COMMENT '用户描述',
    `gender`    tinyint(1)                              NOT NULL DEFAULT '0' COMMENT '性别0.保密 1.男 2.女',
    `phone`     varchar(255)                                     DEFAULT NULL COMMENT '手机号码',
    `email`     varchar(255)                                     DEFAULT NULL COMMENT '邮箱',
    `avatar`    varchar(255)                                     DEFAULT NULL COMMENT '头像',
    `language`  varchar(255)                                     DEFAULT NULL COMMENT '用户使用的语言',
    `address`   varchar(255)                                     DEFAULT NULL COMMENT '用户住址',
    `city`      varchar(255)                                     DEFAULT NULL COMMENT '用户所在地',
    `status`    tinyint(1)                              NOT NULL DEFAULT '0' COMMENT '状态0.激活 1.锁定 2.离职',
    `open_id`   int(11)                                          DEFAULT NULL COMMENT '用户在飞书应用内的唯一标识',
    `union_id`  int(11)                                          DEFAULT NULL COMMENT '飞书用户统一ID',
    `user_id`   int(11)                                          DEFAULT NULL COMMENT '飞书用户user id',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE (`username`) -- 将 UNIQUE 放在这里
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = DYNAMIC;

DROP TABLE IF EXISTS `mcenter_endpoint`;
CREATE TABLE `mcenter_endpoint`
(
    `id`                varchar(255)                            NOT NULL COMMENT '主键',
    `create_at`         bigint                                  NOT NULL COMMENT '创建时间(13位时间戳)',
    `create_by`         varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建人',
    `update_at`         bigint                                  NOT NULL COMMENT '更新时间',
    `update_by`         varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '更新人',

    `service_id`        varchar(255) COMMENT '该功能属于那个服务',
    `version`           varchar(255) DEFAULT NULL COMMENT '服务那个版本的功能',
    `function_name`     varchar(255) DEFAULT NULL COMMENT '函数名称',
    `path`              varchar(255) DEFAULT NULL COMMENT 'HTTP path 用于自动生成http api',
    `method`            varchar(255) DEFAULT NULL COMMENT 'HTTP method 用于自动生成http api',
    `resource`          varchar(255) DEFAULT NULL COMMENT '资源名称',
    `auth_enable`       varchar(255) DEFAULT NULL COMMENT '是否校验用户身份 (access_token 校验)',
    `code_enable`       varchar(255) DEFAULT NULL COMMENT ' 验证码校验(开启双因子认证需要) (code 校验)',
    `permission_enable` varchar(255) DEFAULT NULL COMMENT '是否校验用户权限',
    `perms`             varchar(100) DEFAULT NULL COMMENT '权限标识',
    `audit_log`         bool         DEFAULT NULL COMMENT '是否开启操作审计, 开启后这次操作将被记录',
    `labels`            varchar(255) DEFAULT NULL COMMENT '是否校验用户权限',
    PRIMARY KEY (`id`),
    KEY `idx_function_name` (`function_name`) USING BTREE COMMENT '用于 function_name 搜索'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci;

DROP TABLE IF EXISTS `cacticloud`.`mcenter_permission`;
CREATE TABLE `cacticloud`.`mcenter_permission` (
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
    `perms` varchar(255) DEFAULT NULL COMMENT '权限标识',
    `type` int(11) DEFAULT NULL COMMENT '权限类型0.子系统 1.目录 2.菜单 3.按钮',
    `create_at` bigint(20) DEFAULT NULL COMMENT '创建时间',
    `update_at` bigint(20) DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;
INSERT INTO cacticloud.mcenter_permission (name,icon,sort,visible,service_id,resource_name,parent_id,router_path,router_name,page_path,perms,`type`,create_at,update_at) VALUES
 ('管理中心',NULL,1,0,NULL,NULL,0,'/mcenter','管理中心','','',0,1693820431,NULL),
 ('用户管理',NULL,1,0,NULL,NULL,1,'','用户管理','','',1,1693820431,NULL),
 ('用户列表',NULL,1,0,NULL,NULL,2,'/mcenter/user','用户列表','','sys:user:list',2,1693820431,NULL),
 ('新增用户',NULL,1,0,NULL,NULL,3,'','新增用户','','sys:user:create',3,1693820431,NULL),
 ('删除用户',NULL,1,0,NULL,NULL,3,'','删除用户','','sys:user:delete',3,1693820431,NULL),
 ('更新用户',NULL,1,0,NULL,NULL,3,'','更新用户','','sys:user:update',3,1693820431,NULL),
 ('角色管理',NULL,1,0,NULL,NULL,1,'','角色管理','','',1,1693820431,NULL),
 ('角色列表',NULL,1,0,NULL,NULL,7,'/mcenter/role','角色列表','','sys:role:list',2,1693820431,NULL),
 ('新增角色',NULL,1,0,NULL,NULL,8,'','新增角色','','sys:role:create',3,1693820431,NULL),
 ('删除角色',NULL,1,0,NULL,NULL,8,'','删除角色','','sys:role:delete',3,1693820431,NULL),
 ('更新角色',NULL,1,0,NULL,NULL,8,'','更新角色','','sys:role:update',3,1693820431,NULL),
 ('权限管理',NULL,1,0,NULL,NULL,1,'','权限管理','','',1,1693820431,NULL),
 ('权限列表',NULL,1,0,NULL,NULL,12,'/mcenter/permission','权限列表','','sys:permission:list',2,1693820431,NULL),
 ('新增权限',NULL,1,0,NULL,NULL,13,'','新增权限','','sys:permission:create',3,1693820431,NULL),
 ('删除权限',NULL,1,0,NULL,NULL,13,'','删除权限','','sys:permission:delete',3,1693820431,NULL),
 ('更新权限',NULL,1,0,NULL,NULL,13,'','更新权限','','sys:permission:update',3,1693820431,NULL);



DROP TABLE IF EXISTS `mcenter_role`;
CREATE TABLE `mcenter_role`
(
    `id`        bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色id',
    `domain`    varchar(255) DEFAULT NULL COMMENT '公司',
    `name`      varchar(255) DEFAULT NULL COMMENT '角色名称',
    `remark`    varchar(255) DEFAULT NULL COMMENT '备注',
    `enabled`   int(11)      DEFAULT '0' COMMENT '是否启用 0.启用 1.禁用',
    `create_at` bigint(20)   DEFAULT NULL COMMENT '创建时间',
    `update_at` bigint(20)   DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

DROP TABLE IF EXISTS `mcenter_role_permission`;
CREATE TABLE `mcenter_role_permission`
(
    `id`            bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `role_id`       bigint(20) DEFAULT NULL,
    `permission_id` bigint(20) DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `role_id_index` (`role_id`) USING BTREE,
    KEY `permission_id_index` (`permission_id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

DROP TABLE IF EXISTS `mcenter_user_role`;
CREATE TABLE `mcenter_user_role`
(
    `id`      bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
    `role_id` bigint(20) DEFAULT NULL COMMENT '角色id',
    PRIMARY KEY (`id`),
    KEY `user_id_index` (`user_id`) USING BTREE,
    KEY `role_id_index` (`role_id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;