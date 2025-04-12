/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : localhost:3306
 Source Schema         : nest_admin

 Target Server Type    : MySQL
 Target Server Version : 80027
 File Encoding         : 65001

 Date: 13/04/2025 01:08:16
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_captcha_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_captcha_log`;
CREATE TABLE `sys_captcha_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '账号',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '验证码',
  `provider` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '验证码提供商',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_captcha_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '部门名称',
  `order` int DEFAULT '0' COMMENT '排序',
  `default` tinyint NOT NULL DEFAULT '0' COMMENT '是否系统默认部门',
  `mpath` varchar(255) DEFAULT '',
  `parentId` int DEFAULT NULL,
  `created_by` int DEFAULT NULL COMMENT '创建人',
  `updated_by` int DEFAULT NULL COMMENT '修改者',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_c75280b01c49779f2323536db67` (`parentId`),
  KEY `FK_266e01a1297fa9b18f5e73bbc05` (`created_by`),
  KEY `FK_3b74168ec9f77c2c1f95db199b3` (`updated_by`),
  CONSTRAINT `FK_266e01a1297fa9b18f5e73bbc05` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_3b74168ec9f77c2c1f95db199b3` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_c75280b01c49779f2323536db67` FOREIGN KEY (`parentId`) REFERENCES `sys_dept` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_dept` (`id`, `created_at`, `updated_at`, `name`, `order`, `default`, `mpath`, `parentId`, `created_by`, `updated_by`) VALUES (1, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', '华北', 1, 0, '1.', NULL, 1, 1);
INSERT INTO `sys_dept` (`id`, `created_at`, `updated_at`, `name`, `order`, `default`, `mpath`, `parentId`, `created_by`, `updated_by`) VALUES (2, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', '运维', 1, 0, '4.2.', 4, NULL, NULL);
INSERT INTO `sys_dept` (`id`, `created_at`, `updated_at`, `name`, `order`, `default`, `mpath`, `parentId`, `created_by`, `updated_by`) VALUES (3, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', '研发部', 1, 1, '1.3.', 1, NULL, 1);
INSERT INTO `sys_dept` (`id`, `created_at`, `updated_at`, `name`, `order`, `default`, `mpath`, `parentId`, `created_by`, `updated_by`) VALUES (4, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', '华南', 2, 0, '4.', NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_item
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_item`;
CREATE TABLE `sys_dict_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `label` varchar(50) NOT NULL,
  `value` varchar(50) NOT NULL,
  `order` int DEFAULT NULL COMMENT '字典项排序',
  `status` tinyint NOT NULL DEFAULT '1',
  `remark` varchar(255) DEFAULT NULL,
  `type_id` int DEFAULT NULL,
  `created_by` int DEFAULT NULL COMMENT '创建人',
  `updated_by` int DEFAULT NULL COMMENT '修改者',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_bd4de422c26e5fbf9b4d8337644` (`created_by`),
  KEY `FK_440396a38d6daf3a7ec798c4361` (`updated_by`),
  CONSTRAINT `FK_440396a38d6daf3a7ec798c4361` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_bd4de422c26e5fbf9b4d8337644` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_dict_item
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict_item` (`id`, `created_at`, `updated_at`, `label`, `value`, `order`, `status`, `remark`, `type_id`, `created_by`, `updated_by`) VALUES (1, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', '启用', '1', 1, 1, '', 1, NULL, NULL);
INSERT INTO `sys_dict_item` (`id`, `created_at`, `updated_at`, `label`, `value`, `order`, `status`, `remark`, `type_id`, `created_by`, `updated_by`) VALUES (5, '2025-04-12 12:07:59.379001', '2025-04-12 12:07:59.379001', '禁用', '0', 2, 1, '', 1, NULL, NULL);
INSERT INTO `sys_dict_item` (`id`, `created_at`, `updated_at`, `label`, `value`, `order`, `status`, `remark`, `type_id`, `created_by`, `updated_by`) VALUES (6, '2025-04-12 12:09:35.907445', '2025-04-12 12:09:35.907445', '男', '1', 1, 1, '', 2, NULL, NULL);
INSERT INTO `sys_dict_item` (`id`, `created_at`, `updated_at`, `label`, `value`, `order`, `status`, `remark`, `type_id`, `created_by`, `updated_by`) VALUES (7, '2025-04-12 12:09:55.402096', '2025-04-12 12:09:55.402096', '女', '0', 2, 1, '', 2, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `name` varchar(50) NOT NULL,
  `code` varchar(50) NOT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `remark` varchar(255) DEFAULT NULL,
  `created_by` int DEFAULT NULL COMMENT '创建人',
  `updated_by` int DEFAULT NULL COMMENT '修改者',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `IDX_74d0045ff7fab9f67adc0b1bda` (`code`),
  KEY `FK_9d5f4a5f064c1f7b878033fb353` (`created_by`),
  KEY `FK_ea053e889ab5ffd44ada6b497ff` (`updated_by`),
  CONSTRAINT `FK_9d5f4a5f064c1f7b878033fb353` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_ea053e889ab5ffd44ada6b497ff` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict_type` (`id`, `created_at`, `updated_at`, `name`, `code`, `status`, `remark`, `created_by`, `updated_by`) VALUES (1, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', '用户状态', 'user_status', 1, '', NULL, 1);
INSERT INTO `sys_dict_type` (`id`, `created_at`, `updated_at`, `name`, `code`, `status`, `remark`, `created_by`, `updated_by`) VALUES (2, '2025-04-12 12:08:15.499276', '2025-04-12 12:08:15.499276', '用户性别', 'user_gender', 1, '', NULL, 1);
COMMIT;

-- ----------------------------
-- Table structure for sys_login_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_login_log`;
CREATE TABLE `sys_login_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `ip` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_3029712e0df6a28edaee46fd470` (`user_id`),
  CONSTRAINT `FK_3029712e0df6a28edaee46fd470` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_login_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `parent_id` int DEFAULT NULL COMMENT '菜单父级ID',
  `name` varchar(255) DEFAULT NULL COMMENT '路由名称',
  `path` varchar(255) DEFAULT NULL COMMENT '菜单路径',
  `component` varchar(255) DEFAULT NULL COMMENT '菜单组件',
  `permission` varchar(255) DEFAULT NULL COMMENT '菜单权限',
  `icon` varchar(255) DEFAULT NULL COMMENT '菜单图标',
  `order` int DEFAULT '0' COMMENT '菜单排序',
  `is_ext` tinyint DEFAULT '0' COMMENT '是否外链',
  `ext_open_mode` tinyint DEFAULT '1' COMMENT '外链打开模式 1 项目内打开 2 项目外打开',
  `keep_alive` tinyint DEFAULT '0' COMMENT '是否缓存',
  `active_menu` varchar(255) DEFAULT NULL COMMENT '设置当前路由高亮的菜单项，一般用于详情页',
  `status` int DEFAULT '1' COMMENT '菜单状态 1 启用 0 禁用',
  `title` varchar(255) DEFAULT NULL COMMENT '菜单/权限名称',
  `i18n_key` varchar(255) DEFAULT NULL COMMENT '国际化 key',
  `route_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '路由名称',
  `icon_type` int DEFAULT NULL COMMENT '图标类型',
  `hide_in_menu` tinyint DEFAULT '0' COMMENT '是否隐藏',
  `multi_tab` tinyint DEFAULT '0' COMMENT '是否显示多标签页',
  `href` varchar(255) DEFAULT NULL COMMENT '外链地址',
  `fixed_index_in_tab` int DEFAULT NULL COMMENT '是否显示多标签页',
  `type` int DEFAULT NULL COMMENT '菜单类型',
  `created_by` int DEFAULT NULL COMMENT '创建人',
  `updated_by` int DEFAULT NULL COMMENT '修改者',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_05ff5072bc89581912fe1d01143` (`created_by`),
  KEY `FK_1d243809e8c33546faf26af894c` (`updated_by`),
  CONSTRAINT `FK_05ff5072bc89581912fe1d01143` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_1d243809e8c33546faf26af894c` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (1, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 53, '', '', '', 'system:role:create', '', 3, 0, 0, 0, NULL, 0, '创建', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, 1);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (2, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 18, '', NULL, NULL, 'system:dict-type:delete', '', 5, 0, 0, 0, NULL, 1, '字典类型删除', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (3, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 74, '', '', '', 'system:task:delete', '', 5, 0, 0, 0, NULL, 1, '删除', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (4, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 59, '', '', '', 'upload:upload', '', 2, 0, 0, 0, NULL, 1, '上传', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (5, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 47, 'tools_storage_local', '/tools/storage/local', 'view.tools_storage_local', '', 'mdi:record-circle-outline', 1, 0, 0, 0, NULL, 1, '本地存储', 'route.tools_storage_local', NULL, 0, 0, 0, NULL, NULL, 1, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (6, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 27, '', '', '', 'system:parameter:delete', '', 5, 0, 0, 0, NULL, 1, '删除', NULL, NULL, 0, 0, 0, NULL, NULL, 1, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (7, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 46, 'system_monitor_captcha-log', '/system/monitor/captcha-log', 'view.system_monitor_captcha-log', '', 'mdi:email-fast-outline', 3, 0, 0, 0, NULL, 1, '验证码日志', 'route.system_monitor_captcha-log', NULL, 0, 0, 0, NULL, NULL, 1, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (8, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 21, '', '', '', 'system:dept:read', '', 2, 0, 0, 0, NULL, 1, '详情', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (9, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 21, '', '', '', 'system:dept:create', '', 3, 0, 0, 0, NULL, 1, '创建', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (10, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 0, 'user-center', '/user-center', 'layout.base$view.user-center', '', 'mdi:account-heart-outline', 12, 0, 0, 0, NULL, 1, '个人中心', 'route.user-center', NULL, 0, 0, 0, NULL, NULL, 1, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (11, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 21, '', '', '', 'system:dept:update', '', 4, 0, 0, 0, NULL, 1, '修改', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (12, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 72, '', '', '', 'system:log:task:list', '', 1, 0, 0, 0, NULL, 1, '列表', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (13, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 0, 'tools', '/tools', 'layout.base', '', 'mdi:toolbox-outline', 3, 0, 0, 0, NULL, 1, '系统工具', 'route.tools', NULL, 0, 0, 0, NULL, NULL, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (14, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 61, '', '', '', 'system:menu:create', '', 3, 0, 0, 0, NULL, 1, '创建', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (15, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 5, '', '', '', 'tool:storage:delete', '', 3, 0, 0, 0, NULL, 1, '删除', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (16, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 36, 'system_schedule', 'system_schedule', '', NULL, 'mdi:calendar-clock-outline', 6, 0, 0, 0, NULL, 1, '任务调度', 'route.system_schedule', NULL, 0, 0, 0, NULL, NULL, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (17, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 32, '', '', '', 'system:online:list', '', 1, 0, 0, 0, NULL, 1, '列表', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (18, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 36, 'system_dict', '/system/dict', 'view.system_dict', NULL, 'mdi:format-list-numbered', 8, 0, 0, 0, NULL, 1, '字典管理', 'route.system_dict', NULL, 0, 0, 0, NULL, NULL, 1, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (19, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 18, '', NULL, NULL, 'system:dict-type:create', '', 3, 0, 0, 0, NULL, 1, '字典类型创建', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (20, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 21, '', '', '', 'system:dept:list', '', 1, 0, 0, 0, NULL, 1, '列表', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (21, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 36, 'system_dept', '/system/dept', 'view.system_dept', '', 'ic:outline-reduce-capacity', 1, 0, 0, 0, NULL, 1, '部门管理', 'route.system_dept', NULL, 0, 0, 0, NULL, NULL, 1, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (22, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 74, '', '', '', 'system:task:start', '', 7, 0, 0, 0, NULL, 1, '启动', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (23, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 18, '', NULL, NULL, 'system:dict-item:delete', '', 10, 0, 0, 0, NULL, 1, '字典项删除', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (24, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 74, '', '', '', 'system:task:stop', '', 8, 0, 0, 0, NULL, 1, '停止任务', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (25, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 61, '', '', '', 'system:menu:update', '', 4, 0, 0, 0, NULL, 1, '修改', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (26, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 0, 'about', '/about', 'layout.base$view.about', '', 'fluent:book-information-24-regular', 13, 0, 0, 0, NULL, 1, '关于', 'route.about', NULL, 0, 0, 0, NULL, NULL, 1, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (27, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 36, 'system_parameter', '/system/parameter', 'view.system_parameter', '', 'mdi:database-cog-outline', 7, 0, 0, 0, NULL, 1, '参数管理', 'route.system_parameter', NULL, 0, 0, 0, NULL, NULL, 1, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (28, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 18, '', NULL, NULL, 'system:dict-type:update', '', 4, 0, 0, 0, NULL, 1, '字典类型修改', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (29, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 18, '', NULL, NULL, 'system:dict-type:read', '', 2, 0, 0, 0, NULL, 1, '字典类型详情', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (30, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 53, '', '', '', 'system:role:read', '', 2, 0, 0, 0, NULL, 1, '详情', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (31, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 18, '', NULL, NULL, 'system:dict-item:read', '', 7, 0, 0, 0, NULL, 1, '字典项详情', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (32, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 46, 'system_monitor_online', '/system/monitor/online', 'view.system_monitor_online', '', 'mdi:account-multiple-check-outline', 1, 0, 0, 0, NULL, 1, '在线用户', 'route.system_monitor_online', NULL, 0, 0, 0, NULL, NULL, 1, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (33, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 27, '', '', '', 'system:parameter:create', '', 3, 0, 0, 0, NULL, 1, '创建', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (34, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 74, '', '', '', 'system:task:update', '', 4, 0, 0, 0, NULL, 1, '修改', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (35, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 74, '', '', '', 'system:task:read', '', 2, 0, 0, 0, NULL, 1, '详情', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (36, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 0, 'system', '/system', 'layout.base', '', 'ic:outline-settings', 2, 0, 0, 0, NULL, 1, '系统管理', 'route.system', NULL, 0, 0, 0, NULL, NULL, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (37, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 13, 'tools_mail', '/tools/mail', 'view.tools_mail', '', 'mdi:email-arrow-right-outline', 3, 0, 0, 0, NULL, 1, '发送邮件', 'route.tools_mail', NULL, 0, 0, 0, NULL, NULL, 1, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (39, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 59, '', '', '', 'tool:oss:list', '', 1, 0, 0, 0, NULL, 1, '列表', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (40, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 74, '', '', '', 'system:task:list', '', 1, 0, 0, 0, NULL, 1, '列表', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (41, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 51, '', '', '', 'system:log:login:delete', '', 2, 0, 0, 0, NULL, 1, '删除', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (42, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 36, 'system_user', '/system/user', 'view.system_user', '', 'mdi:account-cog-outline', 4, 0, 0, 0, NULL, 1, '用户管理', 'route.system_user', NULL, 0, 0, 0, NULL, NULL, 1, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (43, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 27, '', '', '', 'system:parameter:update', '', 4, 0, 0, 0, NULL, 1, '修改', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (44, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 27, '', '', '', 'system:parameter:list', '', 1, 0, 0, 0, NULL, 1, '列表', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (45, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 42, '', '', '', 'system:user:read', '', 2, 0, 0, 0, NULL, 1, '详情', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (46, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 36, 'system_monitor', '/system/monitor', '', '', 'mdi:monitor-eye', 5, 0, 0, 0, NULL, 1, '系统监控', 'route.system_monitor', NULL, 0, 0, 0, NULL, NULL, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (47, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 13, 'tools_storage', '/tools/storage', '', '', 'mdi:folder-cog-outline', 2, 0, 0, 0, NULL, 1, '存储管理', 'route.tools_storage', NULL, 0, 0, 0, NULL, NULL, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (48, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 53, '', '', '', 'system:role:delete', '', 5, 0, 0, 0, NULL, 1, '删除', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (49, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 83, 'blog_zym-href', '/blog/zym-href', 'layout.base$iframe-page', NULL, 'mdi:book-open-page-variant-outline', 2, 1, 1, 0, NULL, 1, '小张的博客(外链)', 'route.blog_zym', NULL, 0, 0, 0, 'http://mrzym.top', NULL, 1, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (50, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 21, '', '', '', 'system:dept:delete', '', 5, 0, 0, 0, NULL, 1, '删除', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (51, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 46, 'system_monitor_login-log', '/system/monitor/login-log', 'view.system_monitor_login-log', '', 'mdi:account-file-text-outline', 2, 0, 0, 0, NULL, 1, '登录日志', 'route.system_monitor_login-log', NULL, 0, 0, 0, NULL, NULL, 1, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (52, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 42, '', '', '', 'system:user:list', '', 1, 0, 0, 0, NULL, 1, '列表', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (53, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 36, 'system_role', '/system/role', 'view.system_role', '', 'mdi:account-group-outline', 2, 0, 0, 0, NULL, 1, '角色管理', 'route.system_role', NULL, 0, 0, 0, NULL, NULL, 1, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (54, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 46, 'system_monitor_serve', '/system/monitor/serve', 'view.system_monitor_serve', '', 'mdi:server-outline', 4, 0, 0, 0, NULL, 1, '服务监控', 'route.system_monitor_serve', NULL, 0, 0, 0, NULL, NULL, 1, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (55, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 61, '', '', '', 'system:menu:read', '', 2, 0, 0, 0, NULL, 1, '详情', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (56, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 18, '', NULL, NULL, 'system:dict-item:create', '', 8, 0, 0, 0, NULL, 1, '字典项创建', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (57, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 5, '', '', '', 'upload:upload', '', 2, 0, 0, 0, NULL, 1, '上传', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (58, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 61, '', '', '', 'system:menu:list', '', 1, 0, 0, 0, NULL, 1, '列表', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (59, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 47, 'tools_storage_oss', '/tools/storage/oss', 'view.tools_storage_oss', '', 'mdi:cloud-check-variant-outline', 2, 0, 0, 0, NULL, 1, 'Oss存储', 'route.tools_storage_oss', NULL, 0, 0, 0, NULL, NULL, 1, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (60, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 18, '', NULL, NULL, 'system:dict-item:update', '', 9, 0, 0, 0, NULL, 1, '字典项修改', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (61, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 36, 'system_menu', '/system/menu', 'view.system_menu', '', 'mdi:list-box-outline', 3, 0, 0, 0, NULL, 1, '菜单管理', 'route.system_menu', NULL, 0, 0, 0, NULL, NULL, 1, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (62, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 42, '', '', '', 'system:user:create', '', 3, 0, 0, 0, NULL, 1, '创建', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (63, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 5, '', '', '', 'tool:storage:list', '', 1, 0, 0, 0, NULL, 1, '列表', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (64, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 74, '', '', '', 'system:task:once', '', 6, 0, 0, 0, NULL, 1, '启动一次', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (65, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 0, 'home', '/home', 'layout.base$view.home', '', 'ic:outline-other-houses', 1, 0, 0, 0, NULL, 1, '首页', 'route.home', NULL, 0, 0, 0, NULL, NULL, 1, NULL, 1);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (66, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 74, '', '', '', 'system:task:create', '', 3, 0, 0, 0, NULL, 1, '创建', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (67, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 27, '', '', '', 'system:parameter:read', '', 2, 0, 0, 0, NULL, 1, '详情', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (68, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 42, '', '', '', 'system:user:update', '', 4, 0, 0, 0, NULL, 1, '修改', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (69, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 61, '', '', '', 'system:menu:delete', '', 5, 0, 0, 0, NULL, 1, '删除', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (70, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 42, '', '', '', 'system:user:pass:reset', '', 6, 0, 0, 0, NULL, 1, '重置密码', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (71, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 53, '', '', '', 'system:role:list', '', 1, 0, 0, 0, NULL, 1, '列表', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (72, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 16, 'system_schedule_task-log', '/system/schedule/task-log', 'view.system_schedule_task-log', '', 'mdi:invoice-text-clock-outline', 2, 0, 0, 0, NULL, 1, '任务日志', 'route.system_schedule_task-log', NULL, 0, 0, 0, NULL, NULL, 1, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (73, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 51, '', '', '', 'system:log:login:list', '', 1, 0, 0, 0, NULL, 1, '列表', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (74, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 16, 'system_schedule_task', '/system/schedule/task', 'view.system_schedule_task', '', 'mdi:timer-cog-outline', 1, 0, 0, 0, NULL, 1, '定时任务', 'route.system_schedule_task', NULL, 0, 0, 0, NULL, NULL, 1, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (75, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 53, '', '', '', 'system:role:update', '', 4, 0, 0, 0, NULL, 1, '修改', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (76, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 7, '', '', '', 'system:log:captcha:delete', '', 2, 0, 0, 0, NULL, 1, '删除', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (77, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 7, '', '', '', 'system:log:captcha:list', '', 1, 0, 0, 0, NULL, 1, '列表', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (78, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 18, '', NULL, NULL, 'system:dict-type:list', '', 1, 0, 0, 0, NULL, 1, '字典类型列表', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (79, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 18, '', NULL, NULL, 'system:dict-item:list', '', 6, 0, 0, 0, NULL, 1, '字典项列表', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (80, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 37, '', '', '', 'tool:mail:send', '', 1, 0, 0, 0, NULL, 1, '发送', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (81, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 72, '', '', '', 'system:log:task:delete', '', 2, 0, 0, 0, NULL, 1, '删除', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (82, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 32, '', '', '', 'system:online:kick', '', 2, 0, 0, 0, NULL, 1, '下线', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (83, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 0, 'Blog', '/blog', 'layout.base', NULL, 'mdi:book-heart-outline', 4, 0, 0, 0, NULL, 1, '博客', 'route.blog', NULL, 0, 0, 0, NULL, NULL, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (84, '2025-04-11 22:43:19.312329', '2025-04-11 22:43:19.312329', 13, 'tools_sql', '/tools/sql', 'view.tools_sql', NULL, 'mdi:database-cog-outline', 1, 0, 0, 0, NULL, 1, '数据库管理', 'route.tools_sql', NULL, 0, 0, 0, NULL, NULL, 1, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (85, '2025-04-11 22:43:46.293927', '2025-04-11 22:43:46.293927', 84, '', NULL, NULL, 'tool:sql:export', '', 1, 0, 0, 0, NULL, 1, '导出', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (86, '2025-04-11 22:44:00.474854', '2025-04-11 22:44:00.474854', 84, '', NULL, NULL, 'tool:sql:import', '', 2, 0, 0, 0, NULL, 1, '导入', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (87, '2025-04-11 22:44:47.125958', '2025-04-11 22:44:47.125958', 46, 'system_monitor_cache', '/system/monitor/cache', 'view.system_monitor_cache', NULL, 'ic:outline-cached', 9, 0, 0, 0, NULL, 1, '缓存监控', 'route.system_monitor_cache', NULL, 0, 0, 0, NULL, NULL, 1, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (88, '2025-04-11 22:45:29.369814', '2025-04-11 22:45:29.369814', 87, '', NULL, NULL, 'system:cache:LIST', '', 1, 0, 0, 0, NULL, 1, '列表', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (89, '2025-04-11 22:45:42.673700', '2025-04-11 22:45:42.673700', 87, '', NULL, NULL, 'system:cache:READ', '', 2, 0, 0, 0, NULL, 1, '详情', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (90, '2025-04-11 22:45:52.554843', '2025-04-11 22:45:52.554843', 87, '', NULL, NULL, 'system:cache:DELETE', '', 3, 0, 0, 0, NULL, 1, '删除', NULL, NULL, 0, 0, 0, NULL, NULL, 2, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_parameter
-- ----------------------------
DROP TABLE IF EXISTS `sys_parameter`;
CREATE TABLE `sys_parameter` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '参数名称',
  `key` varchar(255) NOT NULL COMMENT '参数键',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '参数值',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `created_by` int DEFAULT NULL COMMENT '创建人',
  `updated_by` int DEFAULT NULL COMMENT '修改者',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_c0dab843235a20efbdc3b93cc1b` (`created_by`),
  KEY `FK_a4b90c149a3965768a93bd792a6` (`updated_by`),
  CONSTRAINT `FK_a4b90c149a3965768a93bd792a6` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_c0dab843235a20efbdc3b93cc1b` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_parameter
-- ----------------------------
BEGIN;
INSERT INTO `sys_parameter` (`id`, `created_at`, `updated_at`, `name`, `key`, `value`, `remark`, `created_by`, `updated_by`) VALUES (2, '2025-04-11 23:10:23.941686', '2025-04-11 23:10:23.941686', '是否校验验证码', 'login.captcha.enable', 'false', '配置 为 true 才会校验验证码、登录页面才显示验证码', NULL, NULL);
INSERT INTO `sys_parameter` (`id`, `created_at`, `updated_at`, `name`, `key`, `value`, `remark`, `created_by`, `updated_by`) VALUES (3, '2025-04-11 23:10:46.253499', '2025-04-11 23:10:46.253499', '是否允许修改数据', 'auth.modify.enable', 'true', '配置为 true 时，用户有权限则可修改数据，否则除了超级管理员之外都不能修改数据，用于演示系统时使用', NULL, NULL);
INSERT INTO `sys_parameter` (`id`, `created_at`, `updated_at`, `name`, `key`, `value`, `remark`, `created_by`, `updated_by`) VALUES (4, '2025-04-11 23:11:11.891747', '2025-04-11 23:11:11.891747', '待办', 'todo', '1、增加公告管理\n2、底层改用 fastify // 考虑中', '', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `value` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色标识',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '角色描述',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '角色状态 1 启用 0 禁用',
  `default` tinyint DEFAULT NULL COMMENT '是否系统默认角色',
  `created_by` int DEFAULT NULL COMMENT '创建人',
  `updated_by` int DEFAULT NULL COMMENT '修改者',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `IDX_223de54d6badbe43a5490450c3` (`name`),
  UNIQUE KEY `IDX_05edc0a51f41bb16b7d8137da9` (`value`),
  KEY `FK_31b96c30566508b3ca5ae4fd452` (`created_by`),
  KEY `FK_a34a85b537508b4db74b22b10a2` (`updated_by`),
  CONSTRAINT `FK_31b96c30566508b3ca5ae4fd452` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_a34a85b537508b4db74b22b10a2` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` (`id`, `created_at`, `updated_at`, `name`, `value`, `description`, `status`, `default`, `created_by`, `updated_by`) VALUES (1, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', '管理员', 'admin', '管理员', 1, 0, NULL, 1);
INSERT INTO `sys_role` (`id`, `created_at`, `updated_at`, `name`, `value`, `description`, `status`, `default`, `created_by`, `updated_by`) VALUES (2, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', '测试', 'test', '测试角色', 1, 0, NULL, 1);
INSERT INTO `sys_role` (`id`, `created_at`, `updated_at`, `name`, `value`, `description`, `status`, `default`, `created_by`, `updated_by`) VALUES (3, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', '游客', 'guest', '游客', 1, 1, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_role_menus
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menus`;
CREATE TABLE `sys_role_menus` (
  `role_id` int NOT NULL,
  `menu_id` int NOT NULL,
  PRIMARY KEY (`role_id`,`menu_id`) USING BTREE,
  KEY `IDX_35ce749b04d57e226d059e0f63` (`role_id`),
  KEY `IDX_2b95fdc95b329d66c18f5baed6` (`menu_id`),
  CONSTRAINT `FK_2b95fdc95b329d66c18f5baed6d` FOREIGN KEY (`menu_id`) REFERENCES `sys_menu` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_35ce749b04d57e226d059e0f633` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_role_menus
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 1);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 2);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 3);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 4);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 5);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 6);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 7);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 8);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 9);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 10);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 11);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 12);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 13);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 14);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 15);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 16);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 17);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 18);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 19);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 20);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 21);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 22);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 23);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 24);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 25);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 26);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 27);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 28);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 29);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 30);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 31);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 32);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 33);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 34);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 35);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 36);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 37);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 39);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 40);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 41);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 42);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 43);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 44);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 45);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 46);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 47);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 48);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 49);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 50);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 51);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 52);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 53);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 54);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 55);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 56);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 57);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 58);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 59);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 60);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 61);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 62);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 63);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 64);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 65);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 66);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 67);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 68);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 69);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 70);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 71);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 72);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 73);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 74);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 75);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 76);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 77);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 78);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 79);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 80);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 81);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 82);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 83);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 87);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 88);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 89);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (1, 90);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 5);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 7);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 8);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 10);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 12);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 13);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 16);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 17);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 18);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 20);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 21);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 26);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 27);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 29);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 30);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 31);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 32);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 35);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 36);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 37);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 39);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 40);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 42);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 44);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 45);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 46);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 47);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 49);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 51);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 52);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 53);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 54);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 55);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 58);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 59);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 61);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 63);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 65);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 67);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 71);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 72);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 73);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 74);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 77);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 78);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 79);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 83);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 87);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 88);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 89);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 10);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 26);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 49);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 65);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 83);
COMMIT;

-- ----------------------------
-- Table structure for sys_task
-- ----------------------------
DROP TABLE IF EXISTS `sys_task`;
CREATE TABLE `sys_task` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `service` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务服务',
  `type` tinyint NOT NULL DEFAULT '1' COMMENT '任务类型 1:cron 2:interval',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '任务状态 1 启用 0 禁用',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `limit` int DEFAULT '0' COMMENT '限制执行次数，负数则无限制',
  `every` int DEFAULT NULL COMMENT '执行间隔，毫秒单位',
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '执行数据',
  `jobOpts` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '执行选项配置',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `cron` varchar(255) DEFAULT NULL COMMENT 'Cron表达式',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_task
-- ----------------------------
BEGIN;
INSERT INTO `sys_task` (`id`, `created_at`, `updated_at`, `name`, `service`, `type`, `status`, `start_time`, `end_time`, `limit`, `every`, `data`, `jobOpts`, `remark`, `cron`) VALUES (5, '2025-04-11 23:18:04.075099', '2025-04-11 23:18:04.075099', '清除登录日志', 'LogClearJob.clearLoginLog', 0, 1, NULL, NULL, -1, 60000, '', '{\"count\":1,\"key\":\"__default__:5:::0 0 3 * * 1\",\"cron\":\"0 0 3 * * 1\",\"jobId\":5}', '0 秒：表示第0秒。\n0 分钟：表示在小时的第0分钟。\n3 小时：表示在凌晨3点。\n* 日期：表示每天。\n* 月份：表示每个月。\n1 星期中星期几：1 表示星期一', '0 0 3 * * 1');
INSERT INTO `sys_task` (`id`, `created_at`, `updated_at`, `name`, `service`, `type`, `status`, `start_time`, `end_time`, `limit`, `every`, `data`, `jobOpts`, `remark`, `cron`) VALUES (6, '2025-04-11 23:18:36.212907', '2025-04-11 23:18:36.212907', '清除验证码日志', 'LogClearJob.clearCaptchaLog', 0, 1, NULL, NULL, -1, 60000, '', '{\"count\":1,\"key\":\"__default__:6:::0 0 3 * * 1\",\"cron\":\"0 0 3 * * 1\",\"jobId\":6}', '', '0 0 3 * * 1');
INSERT INTO `sys_task` (`id`, `created_at`, `updated_at`, `name`, `service`, `type`, `status`, `start_time`, `end_time`, `limit`, `every`, `data`, `jobOpts`, `remark`, `cron`) VALUES (7, '2025-04-11 23:18:56.168804', '2025-04-11 23:18:56.168804', '清除任务日志', 'LogClearJob.clearTaskLog', 0, 1, NULL, NULL, -1, 60000, '', '{\"count\":1,\"key\":\"__default__:7:::0 0 3 * * 1\",\"cron\":\"0 0 3 * * 1\",\"jobId\":7}', '', '0 0 3 * * 1');
INSERT INTO `sys_task` (`id`, `created_at`, `updated_at`, `name`, `service`, `type`, `status`, `start_time`, `end_time`, `limit`, `every`, `data`, `jobOpts`, `remark`, `cron`) VALUES (8, '2025-04-11 23:19:19.592586', '2025-04-11 23:19:19.592586', '发送邮件', 'EmailJob.send', 0, 0, NULL, NULL, -1, 60000, '{\n    \"to\": \"2715158815@qq.com\",\n    \"subject\": \"晚安提醒!\",\n    \"content\": \"不早啦，小张你该洗洗睡啦!晚安！\"\n}', '{\"count\":1,\"key\":\"__default__:8:::59 59 23 * * *\",\"cron\":\"59 59 23 * * *\",\"jobId\":8}', '', '59 59 23 * * *');
COMMIT;

-- ----------------------------
-- Table structure for sys_task_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_task_log`;
CREATE TABLE `sys_task_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '任务状态 1 成功 0 失败',
  `detail` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '任务日志信息',
  `consume_time` int DEFAULT '0' COMMENT '任务耗时',
  `task_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_f4d9c36052fdb188ff5c089454b` (`task_id`),
  CONSTRAINT `FK_f4d9c36052fdb188ff5c089454b` FOREIGN KEY (`task_id`) REFERENCES `sys_task` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_task_log
-- ----------------------------
BEGIN;
INSERT INTO `sys_task_log` (`id`, `created_at`, `updated_at`, `status`, `detail`, `consume_time`, `task_id`) VALUES (1, '2025-04-13 01:06:07.337251', '2025-04-13 01:06:07.337251', 1, NULL, 22, 7);
COMMIT;

-- ----------------------------
-- Table structure for sys_user_roles
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_roles`;
CREATE TABLE `sys_user_roles` (
  `user_id` int NOT NULL,
  `role_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`) USING BTREE,
  KEY `IDX_96311d970191a044ec048011f4` (`user_id`),
  KEY `IDX_6d61c5b3f76a3419d93a421669` (`role_id`),
  CONSTRAINT `FK_6d61c5b3f76a3419d93a4216695` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`),
  CONSTRAINT `FK_96311d970191a044ec048011f44` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_user_roles
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_roles` (`user_id`, `role_id`) VALUES (1, 1);
INSERT INTO `sys_user_roles` (`user_id`, `role_id`) VALUES (2, 2);
INSERT INTO `sys_user_roles` (`user_id`, `role_id`) VALUES (3, 3);
INSERT INTO `sys_user_roles` (`user_id`, `role_id`) VALUES (5, 3);
COMMIT;

-- ----------------------------
-- Table structure for tool_storage
-- ----------------------------
DROP TABLE IF EXISTS `tool_storage`;
CREATE TABLE `tool_storage` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文件名',
  `fileName` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '真实文件名',
  `ext_name` varchar(255) DEFAULT NULL,
  `path` varchar(255) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `size` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tool_storage
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `status` tinyint DEFAULT '1' COMMENT '状态 1 启用 0 禁用',
  `profile_id` int DEFAULT NULL,
  `dept_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `IDX_78a916df40e02a9deb1c4b75ed` (`username`),
  UNIQUE KEY `REL_f44d0cd18cfd80b0fed7806c3b` (`profile_id`),
  KEY `FK_c330c4acd2740fac489be6d2889` (`dept_id`),
  CONSTRAINT `FK_c330c4acd2740fac489be6d2889` FOREIGN KEY (`dept_id`) REFERENCES `sys_dept` (`id`),
  CONSTRAINT `FK_f44d0cd18cfd80b0fed7806c3b7` FOREIGN KEY (`profile_id`) REFERENCES `user_profile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` (`id`, `created_at`, `updated_at`, `username`, `password`, `status`, `profile_id`, `dept_id`) VALUES (1, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 'admin', '$argon2id$v=19$m=65536,t=3,p=4$OuefvcN4RNSOCSmXzbdydA$D05DU67SEEgVNI1P6ja4KFRf3WAzCtVWts8VrjmCu2I', 1, 2, 3);
INSERT INTO `user` (`id`, `created_at`, `updated_at`, `username`, `password`, `status`, `profile_id`, `dept_id`) VALUES (2, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 'test', '$argon2id$v=19$m=65536,t=3,p=4$gQlOORO3f79TZAGmEZDkBw$UGBBjhY4Vs3sVktqA0UG8QQ5agODZ+O8xsr0x2Q04/U', 1, 3, 3);
INSERT INTO `user` (`id`, `created_at`, `updated_at`, `username`, `password`, `status`, `profile_id`, `dept_id`) VALUES (3, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 'guest', '$argon2id$v=19$m=65536,t=3,p=4$xY9C8HMfnfy0e5e92y1Ang$+dBO8pgZXnwTRglKi71FxoZniJj8p4zYzuyYqAy/MGk', 1, 1, 2);
INSERT INTO `user` (`id`, `created_at`, `updated_at`, `username`, `password`, `status`, `profile_id`, `dept_id`) VALUES (5, '2025-04-12 10:33:06.523520', '2025-04-12 10:33:06.523520', '2715158815@qq.com', '$argon2id$v=19$m=65536,t=3,p=4$bT4f1FFPt3zu9srbxVpKow$ZnD5Kh3Iljiay1AeYvoKe0VQGn9sup4Tl9QWWLI2nT8', 1, 5, 3);
COMMIT;

-- ----------------------------
-- Table structure for user_access_token
-- ----------------------------
DROP TABLE IF EXISTS `user_access_token`;
CREATE TABLE `user_access_token` (
  `value` varchar(255) NOT NULL,
  `expired_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `userId` int DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `FK_c9c6ac4970ddbe5a8c4887e1e7e` (`userId`),
  CONSTRAINT `FK_c9c6ac4970ddbe5a8c4887e1e7e` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user_access_token
-- ----------------------------
BEGIN;
INSERT INTO `user_access_token` (`value`, `expired_at`, `created_at`, `userId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEsInJvbGVzIjpbImFkbWluIl0sImlhdCI6MTc0NDM4NTg2MywiZXhwIjoxNzQ0Mzg3NjYzfQ.sOgkRQUiFV7D_X1k0kM3HEJDqxR_Ys0IfLWUpXjn_3Q', '2025-04-12 00:07:44', '2025-04-11 23:37:44', 1, 1);
INSERT INTO `user_access_token` (`value`, `expired_at`, `created_at`, `userId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEsInJvbGVzIjpbInRlc3QiXSwiaWF0IjoxNzQ0MzgyMjE3LCJleHAiOjE3NDQzODQwMTd9.BCTNsUG23FH_6BdViU-sf9FrcfoC_tI4ZTZa6Aprng4', '2025-04-11 23:06:58', '2025-04-11 22:36:58', 1, 2);
INSERT INTO `user_access_token` (`value`, `expired_at`, `created_at`, `userId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEsInJvbGVzIjpbInRlc3QiXSwiaWF0IjoxNzQ0MzgxOTE5LCJleHAiOjE3NDQzODM3MTl9.PNtjogq0-WMvEQFNK0lkexVhFLtVkKMfStj32cWRmIk', '2025-04-11 23:02:00', '2025-04-11 22:32:00', 1, 3);
INSERT INTO `user_access_token` (`value`, `expired_at`, `created_at`, `userId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEsInJvbGVzIjpbInRlc3QiXSwiaWF0IjoxNzQ0MzgxOTA2LCJleHAiOjE3NDQzODM3MDZ9.OdDqs7Um50YSlqhwJNv7nkLvNhpBlO99sT2A__ApI_o', '2025-04-11 23:01:46', '2025-04-11 22:31:46', 1, 4);
INSERT INTO `user_access_token` (`value`, `expired_at`, `created_at`, `userId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjIsInJvbGVzIjpbImd1ZXN0Il0sImlhdCI6MTc0NDM4NTg4MywiZXhwIjoxNzQ0Mzg3NjgzfQ.bTWR9iNhEvfGZowlkT4fmHXvoEMwWZ-eGlZSCYAhf1o', '2025-04-12 00:08:03', '2025-04-11 23:38:03', 2, 5);
INSERT INTO `user_access_token` (`value`, `expired_at`, `created_at`, `userId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEsInJvbGVzIjpbImd1ZXN0Il0sImlhdCI6MTc0NDMwMzUzNCwiZXhwIjoxNzQ0MzA1MzM0fQ.hb2_1McJiC11h-KB7joEBJuhNsWTf7yT8vYeGS023To', '2025-04-11 01:15:34', '2025-04-11 00:45:34', 1, 6);
INSERT INTO `user_access_token` (`value`, `expired_at`, `created_at`, `userId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEsInJvbGVzIjpbImFkbWluIl0sImlhdCI6MTc0NDM4NDE1NiwiZXhwIjoxNzQ0Mzg1OTU2fQ.JnPBOJf3UaQJHWdy6EJc14Ne-6UWXBl0LR-kQsIlf6I', '2025-04-11 23:39:16', '2025-04-11 23:09:16', 1, 7);
INSERT INTO `user_access_token` (`value`, `expired_at`, `created_at`, `userId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEsInJvbGVzIjpbImFkbWluIl0sImlhdCI6MTc0NDQyNTEzNCwiZXhwIjoxNzQ0NDI2OTM0fQ.msCnJv5Oj6xP9wt9zNn2D7PK-SxxxRnqfP9dXeRX2NU', '2025-04-12 11:02:14', '2025-04-12 10:32:14', 1, 8);
INSERT INTO `user_access_token` (`value`, `expired_at`, `created_at`, `userId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEsInJvbGVzIjpbImFkbWluIl0sImlhdCI6MTc0NDQyNTE5MCwiZXhwIjoxNzQ0NDI2OTkwfQ.G26SysZNz1KvHy3EjbySHWkB1tge3tXqwS1cCMO_cJE', '2025-04-12 11:03:10', '2025-04-12 10:33:10', 1, 9);
INSERT INTO `user_access_token` (`value`, `expired_at`, `created_at`, `userId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEsInJvbGVzIjpbImFkbWluIl0sImlhdCI6MTc0NDQyNTc4NiwiZXhwIjoxNzQ0NDI3NTg2fQ.xwkjqzhyVlTeIFhIXqqUblfDVtSUVNfwf5uzUAuqh1w', '2025-04-12 11:13:06', '2025-04-12 10:43:06', 1, 13);
INSERT INTO `user_access_token` (`value`, `expired_at`, `created_at`, `userId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEsInJvbGVzIjpbImFkbWluIl0sImlhdCI6MTc0NDQyNzgzNywiZXhwIjoxNzQ0NDI5NjM3fQ.BfX7p3pQ9BuRKfq1IH2xaH8kA327isQaSGZU1NHt1x4', '2025-04-12 11:47:17', '2025-04-12 11:17:17', 1, 25);
INSERT INTO `user_access_token` (`value`, `expired_at`, `created_at`, `userId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEsInJvbGVzIjpbImFkbWluIl0sImlhdCI6MTc0NDQyODQwMSwiZXhwIjoxNzQ0NDMwMjAxfQ.yT4X5jXfLiA13gEDWf7ylB5sbgtXzka6NBP-LV6X67k', '2025-04-12 11:56:42', '2025-04-12 11:26:42', 1, 27);
INSERT INTO `user_access_token` (`value`, `expired_at`, `created_at`, `userId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEsInJvbGVzIjpbImFkbWluIl0sImlhdCI6MTc0NDQyODk0NywiZXhwIjoxNzQ0NDMwNzQ3fQ.CtHYCi7NU6Mm_xnvHiPQv25uB72EEV7nu99iQrkFmuw', '2025-04-12 12:05:48', '2025-04-12 11:35:48', 1, 29);
INSERT INTO `user_access_token` (`value`, `expired_at`, `created_at`, `userId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEsInJvbGVzIjpbImFkbWluIl0sImlhdCI6MTc0NDQyOTAwNiwiZXhwIjoxNzQ0NDMwODA2fQ.e20YGG545iPpYqKlm-z25f38j8zVyfChzRrHX87MBKM', '2025-04-12 12:06:47', '2025-04-12 11:36:47', 1, 30);
INSERT INTO `user_access_token` (`value`, `expired_at`, `created_at`, `userId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEsInJvbGVzIjpbImFkbWluIl0sImlhdCI6MTc0NDQyOTA0NiwiZXhwIjoxNzQ0NDMwODQ2fQ.0wOOhcteRjQ77Tq8ZoVKEXvhb8kYYsk57pfO-lRgjWU', '2025-04-12 12:07:27', '2025-04-12 11:37:27', 1, 31);
INSERT INTO `user_access_token` (`value`, `expired_at`, `created_at`, `userId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEsInJvbGVzIjpbImFkbWluIl0sImlhdCI6MTc0NDQ2ODI4NywiZXhwIjoxNzQ0NDcwMDg3fQ.3UxBPBKQ1scnn0fuMvKETVyhdfwrJZGAe5lT5WZzn0I', '2025-04-12 23:01:27', '2025-04-12 22:31:27', 1, 35);
INSERT INTO `user_access_token` (`value`, `expired_at`, `created_at`, `userId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEsInJvbGVzIjpbImFkbWluIl0sImlhdCI6MTc0NDQ3NTU0NSwiZXhwIjoxNzQ0NDc3MzQ1fQ.yptkF1lEnwM77ywE1vC_jybqQC7rhAsapuxp3-ZSGH0', '2025-04-13 01:02:26', '2025-04-13 00:32:26', 1, 39);
INSERT INTO `user_access_token` (`value`, `expired_at`, `created_at`, `userId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEsInJvbGVzIjpbImFkbWluIl0sImlhdCI6MTc0NDQ3NjA5OSwiZXhwIjoxNzQ0NDc3ODk5fQ.IJKrx8DZT9WNO3xdS6_UiWvu0iLYjSZDzWGgDoEzdm4', '2025-04-13 01:11:40', '2025-04-13 00:41:40', 1, 41);
INSERT INTO `user_access_token` (`value`, `expired_at`, `created_at`, `userId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjIsInJvbGVzIjpbImd1ZXN0Il0sImlhdCI6MTc0NDQ3NjEzMiwiZXhwIjoxNzQ0NDc3OTMyfQ.xMU_sIlWS3rnU1FA5btOw0QgvOoTVcrbCHLoijX66Kg', '2025-04-13 01:12:12', '2025-04-13 00:42:12', 2, 42);
INSERT INTO `user_access_token` (`value`, `expired_at`, `created_at`, `userId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjMsInJvbGVzIjpbImd1ZXN0Il0sImlhdCI6MTc0NDQ3NjEzNywiZXhwIjoxNzQ0NDc3OTM3fQ.oCymc8FqsmVO0x2Ln51P8jCaVDkt_lzCz6o_8GNR7Wk', '2025-04-13 01:12:18', '2025-04-13 00:42:18', 3, 43);
INSERT INTO `user_access_token` (`value`, `expired_at`, `created_at`, `userId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjIsInJvbGVzIjpbImd1ZXN0Il0sImlhdCI6MTc0NDQ3NjE0MywiZXhwIjoxNzQ0NDc3OTQzfQ.6S5VOblKZHz7CELzytw3rh74Z0Ag4KVREhuC308NsqQ', '2025-04-13 01:12:23', '2025-04-13 00:42:23', 2, 44);
INSERT INTO `user_access_token` (`value`, `expired_at`, `created_at`, `userId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjIsInJvbGVzIjpbInRlc3QiXSwiaWF0IjoxNzQ0NDc2MjMyLCJleHAiOjE3NDQ0NzgwMzJ9.n3ALhGOm_FJk2vV-p4aUTvZeHg02RDQeBzhtSnyYA4M', '2025-04-13 01:13:53', '2025-04-13 00:43:53', 2, 45);
INSERT INTO `user_access_token` (`value`, `expired_at`, `created_at`, `userId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEsInJvbGVzIjpbImFkbWluIl0sImlhdCI6MTc0NDQ3NzU0NCwiZXhwIjoxNzQ0NDc5MzQ0fQ.pYTV3vSe1PQEzN3cqGX6cGu4-HH0YbK4-UXfmJOF9ek', '2025-04-13 01:35:45', '2025-04-13 01:05:45', 1, 55);
COMMIT;

-- ----------------------------
-- Table structure for user_profile
-- ----------------------------
DROP TABLE IF EXISTS `user_profile`;
CREATE TABLE `user_profile` (
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `nick_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '昵称',
  `email` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'email',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '手机号',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '头像',
  `signature` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '个人签名',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '地址',
  `birth_date` datetime DEFAULT NULL COMMENT '出生日期',
  `introduction` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '简介',
  `id` int NOT NULL AUTO_INCREMENT,
  `gender` tinyint NOT NULL DEFAULT '1' COMMENT '性别 1 男 0 女',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user_profile
-- ----------------------------
BEGIN;
INSERT INTO `user_profile` (`created_at`, `updated_at`, `nick_name`, `email`, `phone`, `avatar`, `signature`, `address`, `birth_date`, `introduction`, `id`, `gender`) VALUES ('2025-02-26 14:52:05.341684', '2025-02-26 14:52:05.341684', '游客', 'guest@qq.com', NULL, 'http://myblogimgbucket.oss-cn-beijing.aliyuncs.com/1741512170833-WechatIMG432.jpg', '\"在平凡的日子里，做自己的光。\"', NULL, NULL, NULL, 1, 1);
INSERT INTO `user_profile` (`created_at`, `updated_at`, `nick_name`, `email`, `phone`, `avatar`, `signature`, `address`, `birth_date`, `introduction`, `id`, `gender`) VALUES ('2025-02-21 17:15:27.107185', '2025-02-21 17:15:27.107185', 'admin', 'admin@qq.com', '', 'https://nest-admin-1308002460.cos.ap-chengdu.myqcloud.com/1742912393529-WechatIMG469-removebg-preview.png', '哼…这具躯壳终究无法承载吾『终焉之暗·灭世魔神』的万亿分之一力量吗…', '中国 成都', '2005-05-06 00:00:00', '(◣_◢) 您的中二能量已突破事件视界——', 2, 1);
INSERT INTO `user_profile` (`created_at`, `updated_at`, `nick_name`, `email`, `phone`, `avatar`, `signature`, `address`, `birth_date`, `introduction`, `id`, `gender`) VALUES ('2025-02-24 17:27:35.418875', '2025-02-24 17:27:35.418875', '测试', 'test@qq.com', NULL, 'http://myblogimgbucket.oss-cn-beijing.aliyuncs.com/1741512156799-WechatIMG431.jpg', '\"风停在窗边，嘱咐你要热爱这个世界。\"', NULL, NULL, NULL, 3, 1);
INSERT INTO `user_profile` (`created_at`, `updated_at`, `nick_name`, `email`, `phone`, `avatar`, `signature`, `address`, `birth_date`, `introduction`, `id`, `gender`) VALUES ('2025-03-30 20:58:26.874215', '2025-03-30 20:58:26.874215', 'Claucherty', '2715158815@qq.com', NULL, 'https://myblogimgbucket.oss-cn-beijing.aliyuncs.com/WechatIMG435.jpg', NULL, NULL, NULL, NULL, 4, 1);
INSERT INTO `user_profile` (`created_at`, `updated_at`, `nick_name`, `email`, `phone`, `avatar`, `signature`, `address`, `birth_date`, `introduction`, `id`, `gender`) VALUES ('2025-04-12 10:33:06.520563', '2025-04-12 10:33:06.520563', 'Doring', '2715158815@qq.com', NULL, 'https://myblogimgbucket.oss-cn-beijing.aliyuncs.com/WechatIMG435.jpg', NULL, NULL, NULL, NULL, 5, 1);
COMMIT;

-- ----------------------------
-- Table structure for user_refresh_token
-- ----------------------------
DROP TABLE IF EXISTS `user_refresh_token`;
CREATE TABLE `user_refresh_token` (
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `expired_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `accessTokenId` int DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `REL_0fb9e76570bb35fd7dd7f78f73` (`accessTokenId`),
  CONSTRAINT `FK_0fb9e76570bb35fd7dd7f78f73c` FOREIGN KEY (`accessTokenId`) REFERENCES `user_access_token` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=243 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user_refresh_token
-- ----------------------------
BEGIN;
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYjdhZjI4Y2QtZmYwYi00ODkwLWI4YTEtOWRhZDg2ZmYzZDI5IiwiaWF0IjoxNzQyODg5NTEyLCJleHAiOjE3NDI4OTMxMTJ9.yPxPKRFU8B0wITh1gCTn8GdLxJD-9eP9g81BVzHGa8c', '2025-04-01 15:58:32', '2025-03-25 15:58:32', NULL, 1);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMzMyNzdmOTQtOWI1Ny00NDE0LWE4YzgtOGMxZjU1ODRlNTQ1IiwiaWF0IjoxNzQzMzEwMTkxLCJleHAiOjE3NDMzMTM3OTF9.8RTZp3vQv3MckRDdTIy4uDJugdJajQxQAm1Zbq52aI0', '2025-04-02 12:49:51', '2025-03-30 12:49:51', NULL, 2);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNTJiNTk1Y2EtOTE3Mi00MGE4LWJkOTQtM2JlNTYxNTNmOGUxIiwiaWF0IjoxNzQyNTc0OTA1LCJleHAiOjE3NDI1Nzg1MDV9.XzdmgMFOmXdbgZkcpID9GzamHTIKygBdIO3qDJC_6eU', '2025-03-29 00:35:05', '2025-03-22 00:35:05', NULL, 3);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZGNlNDNlYmYtYTYxMS00MWViLTk3YzMtMmMxZWM0ZmZiYTAzIiwiaWF0IjoxNzQyODk3NTM4LCJleHAiOjE3NDI5MDExMzh9.NdF0WIbIIGSWJ1p4h325dvyq-oyjcu3mPxVQ0zW3SXI', '2025-04-01 18:12:19', '2025-03-25 18:12:19', NULL, 4);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMjMwNTBjOTQtMDM3NC00M2E4LTk5NzMtYjY5MGM2ZmFhZDgwIiwiaWF0IjoxNzQyMjY5NjgyLCJleHAiOjE3NDIzNTYwODJ9.Azkck7sShAgCL2PA2A0L1YwLNPH3r6WIzeFbcn-hKXA', '2025-03-18 11:48:03', '2025-03-18 11:48:03', NULL, 5);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiODM4YjU2MGUtNTA3MC00ZDc4LTlkZmItMGZmN2ZkYzgyNDEwIiwiaWF0IjoxNzQ0MDE5NDAxLCJleHAiOjE3NDQwMjMwMDF9.tLmsJAAJco68TvKqmNpwGbTtGOPzKzz9nmz2yB9DoeE', '2025-04-10 17:50:01', '2025-04-07 17:50:01', NULL, 6);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiOTY4ZDhmNzgtMjQwNC00NjYyLWI0MjctMDg3ODI3YzczNGU3IiwiaWF0IjoxNzQ0MjEwMTQ2LCJleHAiOjE3NDQyMTM3NDZ9.g7Q2L6kfh4oCnCBecMph6a3ZmF1ysXflhB9eDcwhrDc', '2025-04-12 22:49:07', '2025-04-09 22:49:07', NULL, 7);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNTZlMThiNTEtMTZkMy00OGU1LWEyM2QtMTAyYjhiMWViMDM5IiwiaWF0IjoxNzQzOTg4ODE5LCJleHAiOjE3NDM5OTI0MTl9.H5-Lg3Bt9NQyBPHNSb35bPFAdhSPwV15W5xeZGvXeuw', '2025-04-10 09:20:20', '2025-04-07 09:20:20', NULL, 8);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYjhlNzVjNTgtYzdkYS00NTZiLWFjMjItMThlYTFjZTc0MGY4IiwiaWF0IjoxNzQzNDUzMTgyLCJleHAiOjE3NDM0NTY3ODJ9.55Z_Ep_xxqJlCFQUlfY4VO5gfdPj-qGTe5RovDVksuw', '2025-04-04 04:33:02', '2025-04-01 04:33:02', NULL, 9);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMjFjNmU0NzItOGY5NS00YzU1LThkMDktZDMyZjUxYTk2NGU2IiwiaWF0IjoxNzQ0MDc0MTY1LCJleHAiOjE3NDQwNzc3NjV9.PgYfwbBq-QiLnrNs73g2Vry4xCNWo6nSB9oG_vHDnkg', '2025-04-11 09:02:45', '2025-04-08 09:02:45', NULL, 10);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNTI0NWNhOGQtZWVjMi00OTRlLTllZWItMDM4NzE1ODA1ZTgyIiwiaWF0IjoxNzQyOTEwODg4LCJleHAiOjE3NDI5MTQ0ODh9.pMBx_7Jmw6-S60Sbx1WDjh5vHlP4FdW14-5-bdDjWbs', '2025-04-01 21:54:49', '2025-03-25 21:54:49', NULL, 11);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMzdlMmJjOTEtZWE4Zi00N2E5LTk2ZDktYmE3N2VmMjNlNmI1IiwiaWF0IjoxNzQyMjg4MDMxLCJleHAiOjE3NDIzNzQ0MzF9.VelQe1uP_o3zvtZJpSvx0slxghpvlhLjP5qpGugbLpY', '2025-03-18 16:53:52', '2025-03-18 16:53:52', NULL, 12);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNTIzYjE3MGEtMzI5Mi00MGQ1LTk1ZmMtYzI3MDlkMmJhZjA2IiwiaWF0IjoxNzQzNTc2MTMxLCJleHAiOjE3NDM1Nzk3MzF9.Y7lKLKKzWVaMJjfSmGkT5eERWIsVFjyc00ukWMWy_0U', '2025-04-05 14:42:11', '2025-04-02 14:42:11', NULL, 13);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMzgwZTZlZWUtZjAyMi00MTkxLWJkOTMtNjk3MGYwOGY4ODhiIiwiaWF0IjoxNzQyNzI3NDAwLCJleHAiOjE3NDI3MzEwMDB9.FydZRqtol_L-AwvoWNABUqE8zUrNieE1NNuE1nfKols', '2025-03-30 18:56:41', '2025-03-23 18:56:41', NULL, 14);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiODBjNjhiMWItMWM5Mi00YThkLTlhZmYtMDhiNDg3MGUyZGI3IiwiaWF0IjoxNzQyNTUyODgwLCJleHAiOjE3NDI1NTY0ODB9.iqjSrsKlJbT32gAjcDfgnAxp0CMiNdlHBDC0b_rP83s', '2025-03-28 18:28:00', '2025-03-21 18:28:00', NULL, 15);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMTRlYWM2MGEtZjA4Mi00ZjAwLTk4NmEtNTY2YmRmYWVlZTdmIiwiaWF0IjoxNzQzNDcwMzEzLCJleHAiOjE3NDM0NzM5MTN9.ttrRffg6YsZ75nxOWouOCjHm9G3HsJ_zqQnrtDpds-U', '2025-04-04 09:18:34', '2025-04-01 09:18:34', NULL, 16);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNGE3OWQ4OWMtYjFhNC00NGIyLWI0YWItZDdjZThhMDIwOTYzIiwiaWF0IjoxNzQzMTUzMzgyLCJleHAiOjE3NDMxNTY5ODJ9.ZOzR-IJWUV11kFImcxDWUqzEI1cUbQAO41pK01TR9HI', '2025-03-31 17:16:22', '2025-03-28 17:16:22', NULL, 17);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYTIwNDk2ZDktNzE0Ni00YjY5LTg2MTUtZjRlZDY1YzQ4N2FhIiwiaWF0IjoxNzQzNDcyNzQwLCJleHAiOjE3NDM0NzYzNDB9.kFyfxuAoiT-UfBByfFHk1BbT9p6NnmgzVfVD0Vn8vE4', '2025-04-04 09:59:00', '2025-04-01 09:59:00', NULL, 18);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiOWI5ZjBlYTctNTNiNi00MWVmLWFlZTQtYjdiOTllYjkyY2Y1IiwiaWF0IjoxNzQyODY1MTU0LCJleHAiOjE3NDI4Njg3NTR9.XamfllkRJ1WvCqgrWftYnx5LnWvWcm4-DbOzQV5WObo', '2025-04-01 09:12:34', '2025-03-25 09:12:34', NULL, 19);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiOTBjMjJjYzctZWM4Yi00MzIxLTg2NTUtMDAyYjZkZjI2YWUwIiwiaWF0IjoxNzQyNzA4MDEwLCJleHAiOjE3NDI3MTE2MTB9.YxVRuU_zQYfvzhxSsrrzYFRovazD-10SsXCcay2mbsQ', '2025-03-30 13:33:31', '2025-03-23 13:33:31', NULL, 20);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYzMwODE1MTItOTYwYy00ZmQ4LWEyN2YtZDliNjg1NzViZDc1IiwiaWF0IjoxNzQyNzA3Mzc0LCJleHAiOjE3NDI3MTA5NzR9.waONtz71KKV9Sr9Ak60gMcr1CnQttcuCBk1FEdhUl1I', '2025-03-30 13:22:54', '2025-03-23 13:22:54', NULL, 21);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZDYyZTk3MGUtODkwNy00YzgwLTk2N2EtNTRkMzhhNDc1NGEzIiwiaWF0IjoxNzQyODY5ODEyLCJleHAiOjE3NDI4NzM0MTJ9.7JGHciRCgxjhiF5NNxJkZy1_IcWRZa6cFntCjSnuIUM', '2025-04-01 10:30:12', '2025-03-25 10:30:12', NULL, 22);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiY2FjNTUzNzYtYmZiMS00ZDVhLTllOWEtNzFlOTNiNTE0YzI5IiwiaWF0IjoxNzQyMjMyOTg2LCJleHAiOjE3NDIzMTkzODZ9.E_FSwh8glStNv5UGKGiO-52Vtt-XUD3sC_49V6uKsYE', '2025-03-18 01:36:26', '2025-03-18 01:36:26', NULL, 23);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZmYzODA3ZTUtYTY5NC00NDQ4LWExOTAtNzI1MTZjNjYwNzIyIiwiaWF0IjoxNzQwODQ0MDgyLCJleHAiOjE3NDA4NDU4ODJ9.k2ZsqpdigI4AuUdQR2ZrdwnD6yKf8_m6DE15GCMq9BQ', '2025-03-08 23:48:03', '2025-03-01 23:48:03', NULL, 24);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiM2ZlMDRiOTQtZDljNi00M2ZiLWI5M2QtMjA4YTcyZjg0YWYwIiwiaWF0IjoxNzQwOTI4NzE3LCJleHAiOjE3NDA5MzA1MTd9.57zm_n-upgF02_wueMn147rLGkW82HQkMNAik58a_NE', '2025-03-09 23:18:38', '2025-03-02 23:18:38', NULL, 25);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZGZhYjIxYjctNDg1YS00MWNiLWJkNTQtNmU3OWUwYWY0N2VkIiwiaWF0IjoxNzQyOTIwMTAzLCJleHAiOjE3NDI5MjM3MDN9.Gt8-wZjQUWE5nOeZDu5Qi7QfCdfYMkg1A_O2FkT1fCQ', '2025-03-29 00:28:24', '2025-03-26 00:28:24', NULL, 26);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYWMxMTQwYTYtOGZjNi00ZjJjLWIzOTktZjJkODAxNDM0ZTEwIiwiaWF0IjoxNzQzMzQyOTU2LCJleHAiOjE3NDMzNDY1NTZ9.CoFTt5ACDSgzVGcJbL-XLIhu4RYs-nHgVwTWzdjIuzA', '2025-04-02 21:55:57', '2025-03-30 21:55:57', NULL, 27);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZTNmN2QzZjAtYTM3ZS00MjhkLTgyM2MtZTc0NTg3MzFiMmYzIiwiaWF0IjoxNzQ0MDc1MjQzLCJleHAiOjE3NDQwNzg4NDN9.Zlns4pUp3bW1c_7yXKh53OuBHZO4we_Fudv0IPTxF6Y', '2025-04-11 09:20:44', '2025-04-08 09:20:44', NULL, 28);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYjUxZTg4ZjItNjMxMy00MzU1LThjYTktNDVhZjcyOTkwZjg4IiwiaWF0IjoxNzQyNzA4OTgxLCJleHAiOjE3NDI3MTI1ODF9.9V22QRbduM1ju0DrgAM-PRTWsvnUxyXJcByn4j2x1WY', '2025-03-30 13:49:42', '2025-03-23 13:49:42', NULL, 29);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYTg2MzNmMDItNzI4MC00Yzg0LTlhOTYtOWNiOWQ0MjNhZTIzIiwiaWF0IjoxNzQ0MDIyNDA1LCJleHAiOjE3NDQwMjYwMDV9.nX-9WEXGRbKOZ4O7RrU4hMYNcetTOrInFFOwPTdaWrM', '2025-04-10 18:40:05', '2025-04-07 18:40:05', NULL, 30);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiOTQ0YjQ3ZmUtNTJlOC00ZGQ5LWJjYzYtM2QxNjE0MTNjM2NkIiwiaWF0IjoxNzQxMTkwOTU3LCJleHAiOjE3NDExOTI3NTd9.9CpJ0w3lO1jwn9QAHxTby4QBILBXcNVbLmirXIk-SRs', '2025-03-13 00:09:18', '2025-03-06 00:09:18', NULL, 31);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiOTQzZTllYzgtNThjZC00MGE3LWFmNzItNzgzNzUxN2E1Y2JiIiwiaWF0IjoxNzQyNjk2NjM5LCJleHAiOjE3NDI3ODMwMzl9.fmO8LX_DIn66_jMtLO-ruZy99QT4WIJ4Fhb_45aSalk', '2025-03-30 10:24:00', '2025-03-23 10:24:00', NULL, 32);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMzkyZGJkNmQtNGVlNC00ZGIxLTlkZmYtZjkyMTg5MWZjMzcyIiwiaWF0IjoxNzQyOTEwODg0LCJleHAiOjE3NDI5MTQ0ODR9.RikdSY0DCX-IlQ0BKNH6AOgs3l0UgQiVCO6acW73IKE', '2025-04-01 21:54:45', '2025-03-25 21:54:45', NULL, 33);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNDJiODM1NTYtYzJhNS00NDg0LWEwMDctMTNmNmJiYzE1ZDdkIiwiaWF0IjoxNzQxMDk0MjEyLCJleHAiOjE3NDEwOTYwMTJ9.BuKy9zm007QhswPvg907PRY5RniHgAz_PkdVsHE-iK8', '2025-03-11 21:16:53', '2025-03-04 21:16:53', NULL, 34);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNDczNDRmZjQtMGEzYi00MDhlLWJlNDEtOGI1NDlhZjhjZTUxIiwiaWF0IjoxNzQzMzQwOTYzLCJleHAiOjE3NDMzNDQ1NjN9.2Fwo8IdGj7RAY-36rFrfNrSooMI5nl4w9fsYStDQfxw', '2025-04-02 21:22:44', '2025-03-30 21:22:44', NULL, 35);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMjBhOTJmYWUtMWEwYi00ODBhLTlkZDktYjc0MDFjNDNlYmFmIiwiaWF0IjoxNzQwOTg2MDk1LCJleHAiOjE3NDA5ODc4OTV9.-MSYLETCvJe-YlIsaFOvc9eqGSyG6En1DUA38jy6Y_k', '2025-03-10 15:14:56', '2025-03-03 15:14:56', NULL, 36);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMmM1MjQ5NTEtNWNjYS00MWUzLWIyOTMtYWE5ZDYyZjE5MmE4IiwiaWF0IjoxNzQ0Mzg1ODgzLCJleHAiOjE3NDQzODc2ODN9.9CO9tZ_aYXvCnMWcdGbVlguN7zgjFs5gTVdvXJDCesE', '2025-04-12 23:38:03', '2025-04-11 23:38:03', NULL, 37);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYzk5N2E5NjctNzg5Mi00MTY1LTgxOGQtNmIyMDVjMWE5NmE1IiwiaWF0IjoxNzQxNTEwNTg2LCJleHAiOjE3NDE1MTIzODZ9.Zq2sy2TjvxQkrxfYtJSA4xdA7tCsrM3BAZ3ewbgLnYU', '2025-03-16 16:56:26', '2025-03-09 16:56:26', NULL, 38);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiOGQ0YzA5NGMtMDM3ZC00NDNiLWJiOTAtMThlYTcwNDU0MzU0IiwiaWF0IjoxNzQzNDAyMDg5LCJleHAiOjE3NDM0MDU2ODl9.TCkTcaAxMmWTNGXZTOZzwxX5BQoKFcnV9rvH-B-w9iE', '2025-04-03 14:21:29', '2025-03-31 14:21:29', NULL, 39);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZTgzYmYyNDktZWUwZS00YmI1LTg2OTktNjYzNmNiZThjMzliIiwiaWF0IjoxNzQ0MTExOTYxLCJleHAiOjE3NDQxMTU1NjF9.dAME9GPZEuLrmQo4BEGrVoEs0pyqZ62dCuIozwoSUnQ', '2025-04-11 19:32:42', '2025-04-08 19:32:42', NULL, 40);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMDFhNzY3MzMtNmE4OC00MWQ5LTk5OGItYjcwYzIyOGU3MTY2IiwiaWF0IjoxNzQzNzczMDE4LCJleHAiOjE3NDM3NzY2MTh9.NElxXjmooAriavvNIIsdV2GQc4pIEIxDSsucKBb6-MU', '2025-04-07 21:23:39', '2025-04-04 21:23:39', NULL, 41);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMGQwZmRhN2YtZWQ3Yi00NDJjLTlmYjktYjY4YTg1YjhiMTY5IiwiaWF0IjoxNzQ0MTg3OTU4LCJleHAiOjE3NDQxOTE1NTh9.V7Z0nUhA6PKbFUVENakoQBLdxD-2vmZSDdPEoSuLlhs', '2025-04-12 16:39:18', '2025-04-09 16:39:18', NULL, 42);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNDUwMmQ4MzgtMWQ1Zi00YmJmLWJmNGUtNzE4ZGZkMGYzYTA0IiwiaWF0IjoxNzQyMjYwNTg0LCJleHAiOjE3NDIzNDY5ODR9.piJwr11kUtTolDh0gQSVDqSQQvA08t8ja3XccpQL5tI', '2025-03-18 09:16:24', '2025-03-18 09:16:24', NULL, 43);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZjAzMzcxNjktNWM5MS00MjRjLWJkZjUtNmY5NGM2MzExZTk1IiwiaWF0IjoxNzQ0MTMxODU5LCJleHAiOjE3NDQxMzU0NTl9.KYhwK_btHpKV_TKLM8j2bFbVOrSYbfQZHXEn_hdWyt0', '2025-04-12 01:04:19', '2025-04-09 01:04:19', NULL, 44);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYmFjYTc1ZmMtODNmOS00Y2QwLWJhMjgtZDQxYjZjMGY1MjdmIiwiaWF0IjoxNzQyNzc5MDU3LCJleHAiOjE3NDI3ODI2NTd9.VNnw_SRivYXd0MQJYApNUgXHc0WJWfzKhclWnyGzGKA', '2025-03-31 09:17:38', '2025-03-24 09:17:38', NULL, 45);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiODAzYjM1M2UtNGY4NC00NmY1LWI2MTYtNzljMGJjOGMwM2YxIiwiaWF0IjoxNzQ0MDc0MDU0LCJleHAiOjE3NDQwNzc2NTR9.RtTuLi0Aq6FVaePDsaGdCZJArNGTTe3fGQ1K3aQrSUQ', '2025-04-11 09:00:55', '2025-04-08 09:00:55', NULL, 46);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMTIyOTBiNWYtOTJhMi00MGU3LThkNjktZGYwYzIzZWM5ZDA4IiwiaWF0IjoxNzQ0MTY2NjM3LCJleHAiOjE3NDQxNzAyMzd9.Q8v9tJ0QgpP1UlHjUEPkPwbrV36agEwk9_Y-BY5f7x4', '2025-04-12 10:43:58', '2025-04-09 10:43:58', NULL, 47);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZWJlNmNmMzMtMDUxYy00NmEzLTg3NjktYzFjZTFjNjllMDdkIiwiaWF0IjoxNzQzMDY5NTc1LCJleHAiOjE3NDMwNzMxNzV9.kfdcwE_7nTu_iXbVvMCzy1D2v7yECX1zm4b3tKragOw', '2025-03-30 17:59:36', '2025-03-27 17:59:36', NULL, 48);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMjVlYzY2YmEtZGQ2NS00MjJkLThlNjgtOTQ3NzBhOGNmZjVjIiwiaWF0IjoxNzQzNTc4ODIxLCJleHAiOjE3NDM1ODI0MjF9.33aDCyDt_fVjW8rTuWyGQhpKWzJBZsXeCE2_BOA_r3k', '2025-04-05 15:27:01', '2025-04-02 15:27:01', NULL, 49);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiOWFlM2E0Y2YtZDVmZC00OTZmLWFjMmUtMDU2ZDdmYTgwM2QxIiwiaWF0IjoxNzQzODEyODg5LCJleHAiOjE3NDM4MTY0ODl9.rTkAEPX7vbo1DWXD65NDwikySCZCbizjwgW0YEhgrDE', '2025-04-08 08:28:09', '2025-04-05 08:28:09', NULL, 50);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZTdlZjg4NzQtM2FlOC00ZjQ0LTljMzMtZDVhMDlmYzA1OWI1IiwiaWF0IjoxNzQ0MTEzMDgzLCJleHAiOjE3NDQxMTY2ODN9.eGrygnVBRBJq5RwP-bIRrxiGhR6PjYGwtEcgBFflUp0', '2025-04-11 19:51:24', '2025-04-08 19:51:24', NULL, 51);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNmM5ODBjODktNmQ4ZC00NDZjLWIzNWItOWE4OWE0NDczNjA3IiwiaWF0IjoxNzQyNDQwNzU3LCJleHAiOjE3NDI1MjcxNTd9.QIwfz6WHimGpx6kboSmlh2crmaJ7YPJcOC6MTSQFxjA', '2025-03-27 11:19:18', '2025-03-20 11:19:18', NULL, 52);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMGZhMzc4YzYtMmUxOS00ZjFiLWEwZjYtNDZhNzA4NDBlMGYxIiwiaWF0IjoxNzQyNDUwODQ3LCJleHAiOjE3NDI1MzcyNDd9.zTWD7fF6T_gZv_wG8V6L8dZkoAd7tD0SerKxtkDrdEg', '2025-03-27 14:07:27', '2025-03-20 14:07:27', NULL, 53);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYzcyZDdlMTYtMzY4NC00NTM2LWFjZDgtZjY5YWVhMjI2MDUwIiwiaWF0IjoxNzQ0MjE0MzY5LCJleHAiOjE3NDQyMTc5Njl9.xHyradHUmgDzdzB1bfLnTfXEl85ZKfNZj6qBqnhx80g', '2025-04-12 23:59:29', '2025-04-09 23:59:29', NULL, 54);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZWI5M2Q0YjQtNjkxMy00NjRkLThmNjgtNGUxNzcwYjU0YTBmIiwiaWF0IjoxNzQyODgwOTc1LCJleHAiOjE3NDI4ODQ1NzV9.S-zYuY7b7K1UmDH5u5Eie9FJlpADzeShgfZJzlOPr1Y', '2025-04-01 13:36:15', '2025-03-25 13:36:15', NULL, 55);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNzVhM2FhZDQtZGQ4Ny00M2Y0LThkMDEtM2IwMjcxYzMxZjA4IiwiaWF0IjoxNzQyNzA3ODQ5LCJleHAiOjE3NDI3MTE0NDl9.vyvfBt53ctvd4f5dI7LTPlxfe3kKFblSxtsaTBfoeYM', '2025-03-30 13:30:50', '2025-03-23 13:30:50', NULL, 56);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZGI0ZWFjY2UtMjI2MS00N2UzLWFlMjctMTVmYzM1ODdlZjFmIiwiaWF0IjoxNzQzNjY0MzUwLCJleHAiOjE3NDM2Njc5NTB9.Rg2hiGMn9BsWriIVzerK-B2iC1jgijm5au9IDdz24bM', '2025-04-06 15:12:31', '2025-04-03 15:12:31', NULL, 57);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMGZkZDQ5ZjYtNTFlNi00NmQzLWIzMmItN2YwMTIwOWYzOGQxIiwiaWF0IjoxNzQ0MzAxNzQ0LCJleHAiOjE3NDQzMDM1NDR9.TkCv7tNuQhg2Y67-C41GCoDioXyefhZGTZfy4oC3bkg', '2025-04-12 00:15:45', '2025-04-11 00:15:45', NULL, 58);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNGFjOGEwODMtZmViNy00ZWI4LTliNTMtZjlhZmRiODM0YTBjIiwiaWF0IjoxNzQyNzA3ODM4LCJleHAiOjE3NDI3MTE0Mzh9.RtTyDvzhVwYgWbGcVNL9xuwtrqRdNbAEXwHvlvQtgbQ', '2025-03-30 13:30:39', '2025-03-23 13:30:39', NULL, 59);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYjk1OTU5NzAtNDA3Yi00MDBlLWI0ODgtY2NhMjU3OWNkOWU4IiwiaWF0IjoxNzQzNzg0Mjc4LCJleHAiOjE3NDM3ODc4Nzh9.o-rqT48I4qIcd0OyaBM8q5jAm3SjQFjOcfMhyKw5n4Y', '2025-04-08 00:31:18', '2025-04-05 00:31:18', NULL, 60);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiODBkZGMxMDktNDAwYi00ZmI4LWI5NzMtY2ZhYzg2ZmE0NmU5IiwiaWF0IjoxNzQyNDkzNjYxLCJleHAiOjE3NDI0OTcyNjF9.sP7mFAMAeYZfKAh5vrSrQOnYMRSQ0j4OtVFzFTr460Q', '2025-03-28 02:01:02', '2025-03-21 02:01:02', NULL, 61);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNDMzNjYyZDQtNmQyOC00ZGZhLWE2ZmQtODRjMzNmNTY5YTgzIiwiaWF0IjoxNzQzNzAwNTUzLCJleHAiOjE3NDM3MDQxNTN9.mNRNoywNw6BNaQ-4ERWutZZ5-ZYBYoe1sNpyDlgoWKI', '2025-04-07 01:15:54', '2025-04-04 01:15:54', NULL, 62);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZDEyMzA1NjItZmQ3YS00NGRmLWFmYTItZjBmY2ZiY2Y5OTYyIiwiaWF0IjoxNzQxMTAyODM3LCJleHAiOjE3NDExMDQ2Mzd9.U3rZ-ov_9R5yDcL41I7IIqY5Nnfm-XhBqZGzphwjCJE', '2025-03-11 23:40:38', '2025-03-04 23:40:38', NULL, 63);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNGI4YzkyNWYtZjk0Yy00YzkzLTk2MDQtOTJhMTc5ZDNhNGZhIiwiaWF0IjoxNzQzNTg2MDk0LCJleHAiOjE3NDM1ODk2OTR9.JreYGqsenz4bJ2drXsnupKBr5lwmpjtcN7BIVIjYR0Y', '2025-04-05 17:28:14', '2025-04-02 17:28:14', NULL, 64);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZTBhZTI0MTItMjgxMi00NzQ5LWE4MjQtYWFjNjUyNTU1MjA3IiwiaWF0IjoxNzQyNDU0OTEzLCJleHAiOjE3NDI1NDEzMTN9.GvH08aZ-6r47w2aFbIYzeCEp9nU26r8_Qfun_7ItOII', '2025-03-27 15:15:13', '2025-03-20 15:15:13', NULL, 65);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNDNiMjY5YTMtOWFjNi00YWIxLWIxMGYtZjMwYTIzOGRhN2I3IiwiaWF0IjoxNzQzNDkzMDgzLCJleHAiOjE3NDM0OTY2ODN9.bPHFduf3F2jsKkUk2MX31r2cWfeNaEUR-gmw9kIz3lg', '2025-04-04 15:38:04', '2025-04-01 15:38:04', NULL, 66);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiODA0NjFmOGQtNjY3OC00ZWYyLWI2OTItNGJlZTRhZGVkMmJkIiwiaWF0IjoxNzQzOTUwMDEyLCJleHAiOjE3NDM5NTM2MTJ9.9qAQml7pYS1wExiarjuhGgnmCe9N_dVqVMSlW8hWC3k', '2025-04-09 22:33:33', '2025-04-06 22:33:33', NULL, 67);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZmJiNjk1ZWUtYzNhYy00NmRlLWJlMzMtZGE3YzBkYmU5MGMxIiwiaWF0IjoxNzQ0MjE1OTQ3LCJleHAiOjE3NDQyMTk1NDd9.zWg5UuBDoeKctv82yL2yjUo9qE0UBllYOm_6_ODGlx8', '2025-04-13 00:25:48', '2025-04-10 00:25:48', NULL, 68);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMTg1ZGNkZmUtOWE5Zi00NmMyLWIwMjMtYTMyODUxNjEyZjgzIiwiaWF0IjoxNzQyMjI3NTE0LCJleHAiOjE3NDIyMjkzMTR9.IvxA1LzIOIVzVmodN8mviAPF3t-C5QT28UpAcojPN34', '2025-03-25 00:05:15', '2025-03-18 00:05:15', NULL, 69);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiOWQzZmMwODItMWUxNy00MDc1LWEzMTQtN2FmYjE5NzE3ZmE2IiwiaWF0IjoxNzQzMzM3MTU2LCJleHAiOjE3NDMzNDA3NTZ9.VumdbOPIgRqKYFPjUKk0iO6fpTd-GGcWUyOg77Vmud4', '2025-04-02 20:19:16', '2025-03-30 20:19:16', NULL, 70);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNDZlMTM3ZWYtZTZkMS00NDkxLWE3NTQtMDUwZGY5YmYwYjI1IiwiaWF0IjoxNzQyOTgwODQzLCJleHAiOjE3NDI5ODQ0NDN9.4uURYJz3dt69DYsZGTZh1NAFc_OjRhqZybSOUqoeaVw', '2025-03-29 17:20:44', '2025-03-26 17:20:44', NULL, 71);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNjA1MWM5YTYtZjcxYy00MjFjLTg2YzUtMDY4YjBjZDM4YjViIiwiaWF0IjoxNzQyNzEwMjcxLCJleHAiOjE3NDI3MTM4NzF9.f9ek2ENptjH-CoAOwDq9uzuNgk0MdPUkWbrtPEJm_Xs', '2025-03-30 14:11:11', '2025-03-23 14:11:11', NULL, 72);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYmJkYmRmZDMtZTRlYy00ODcyLTllMDMtNGZhZDIwZjQ4NzgwIiwiaWF0IjoxNzQzNjQwNzAxLCJleHAiOjE3NDM2NDQzMDF9.0n8t3L4CopVECmjrxawwFSFgSYmTuteG7rI0CxSbio0', '2025-04-06 08:38:21', '2025-04-03 08:38:21', NULL, 73);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYzY1OWVkN2EtZjU4NS00MzFiLTllZWEtYTUzNmM4YjYxMzFmIiwiaWF0IjoxNzQxODgwNjAwLCJleHAiOjE3NDE4ODI0MDB9.hh3jFem1BKOC3AYeRyDNOTJqstoylDnyfS9FNnod3wQ', '2025-03-20 23:43:21', '2025-03-13 23:43:21', NULL, 74);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYTI3ZGU2ZTEtN2EwMy00ZDRmLTljZDgtZDRhZGVkZGRiYjg3IiwiaWF0IjoxNzQ0MTg4NTgxLCJleHAiOjE3NDQxOTIxODF9.D2R0xS2MgtpJxKseJ3LMFbcLnZAKYDjL2nhD96hBlWY', '2025-04-12 16:49:41', '2025-04-09 16:49:41', NULL, 75);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNzdhYjhkZmQtMjY3My00YmUyLTgwMzYtMjI4ZTg0ODQ2YzZjIiwiaWF0IjoxNzQyODY2NjUyLCJleHAiOjE3NDI4NzAyNTJ9.EONxXxYClAYxcWp6zCCfpKV_FvY8Q56OUYMsqG5ySik', '2025-04-01 09:37:32', '2025-03-25 09:37:32', NULL, 76);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMzFmOTU1YzctOGUyMC00YmQzLWI2N2ItYTA0ODkyMTNmN2ExIiwiaWF0IjoxNzQyNzkyNjg3LCJleHAiOjE3NDI3OTYyODd9.Z7pQIN4N6Tgr7J_1wPn20jJ5PSUDNmC06c5ezmmpGqk', '2025-03-31 13:04:48', '2025-03-24 13:04:48', NULL, 77);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNTU2MTk1NDktMGE5Yi00ODQyLWI4NWYtMjYzYTZiZWM5NDEwIiwiaWF0IjoxNzQyNTQxODIxLCJleHAiOjE3NDI1NDU0MjF9.aAFM-sjjn4qvYYrvcNZ-SGzgceJAxp1aecL6WBWbOu0', '2025-03-28 15:23:42', '2025-03-21 15:23:42', NULL, 78);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYjE4NzQ0MTktYWM1Yy00ZmQxLWJlMDgtZWQ0MzA2MDJkYzI1IiwiaWF0IjoxNzQyNDU4ODg0LCJleHAiOjE3NDI1NDUyODR9.yYjzenCBr_IEibYgiroosmBqNsY8vgLTx4t-X561_HY', '2025-03-27 16:21:24', '2025-03-20 16:21:24', NULL, 79);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYTU1MzFhZmYtNTZjMC00ZGFlLWIzNzUtNTZlMzdmMDRhNGYzIiwiaWF0IjoxNzQyOTUyNTIzLCJleHAiOjE3NDI5NTYxMjN9.Mf8NMdNDeZ2CUlZRd5zn7oWfTj93UbQjIi--AH9pm8w', '2025-03-29 09:28:44', '2025-03-26 09:28:44', NULL, 80);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMzBlZmU5N2UtYzkxZS00NGVhLWE0NmEtZjMyZGY0YTNkNTg4IiwiaWF0IjoxNzQ0MTgwMzU3LCJleHAiOjE3NDQxODM5NTd9.L8KF-MW7oEm02VKLZ0hOrSuGVQhxRAwdlNlSfg4o9LM', '2025-04-12 14:32:38', '2025-04-09 14:32:38', NULL, 81);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZDQ0NDkyOTMtYjQ5ZC00M2E3LWFiMDYtZGRmOTA4NDg5OGU5IiwiaWF0IjoxNzQyMjkwOTQ0LCJleHAiOjE3NDIzNzczNDR9.tlyNYdvI3OGTyu39_6QNz3rm9aUdF9zb10yiLCf8a8A', '2025-03-18 17:42:25', '2025-03-18 17:42:25', NULL, 82);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMTMxYTFiNTEtOWMwMi00M2ExLWI4MTItYThiOTIyMTIzNTIyIiwiaWF0IjoxNzQzMTMwMjYzLCJleHAiOjE3NDMxMzM4NjN9.Zg8nyBpE-LtVTiHByXY8rRXHb63ooFTrf9u1OoGZs80', '2025-03-31 10:51:04', '2025-03-28 10:51:04', NULL, 83);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZWFlZTg1OWItNDMyMS00NGI0LWFiYTMtODJhZWVjMDdmNjI5IiwiaWF0IjoxNzQyMjMxOTYyLCJleHAiOjE3NDIzMTgzNjJ9.xQRVsFLhWZwSx1m4gBUuZHRwgarzE4BQDi__6fKWd6o', '2025-03-18 01:19:23', '2025-03-18 01:19:23', NULL, 84);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMmQzOGIzMGYtMWUyOC00MDY5LWI4ODAtYTJmMzcxZmY4MjIzIiwiaWF0IjoxNzQyNTIwMTUxLCJleHAiOjE3NDI1MjM3NTF9.P9hK_ZoSgW-HJYVaa6yH_tNx-mLojp6ort3bSKVhgQc', '2025-03-28 09:22:31', '2025-03-21 09:22:31', NULL, 85);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNDIzYWQ1YjEtMmRkMS00NTkxLTgwNTctYTk4YjQxMzNlMTk5IiwiaWF0IjoxNzQyMjc4ODk4LCJleHAiOjE3NDIzNjUyOTh9.AJhEajHcYp3sylEcstd_RNNSO6UCIFQ6drnXg20QPek', '2025-03-18 14:21:38', '2025-03-18 14:21:38', NULL, 86);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMTczZGM4NWItMzE4Mi00MTMxLThhNjgtN2RhYzdhYWMxMDYzIiwiaWF0IjoxNzQ0MTY3MDAxLCJleHAiOjE3NDQxNzA2MDF9.3Y_Pq5OkviSY5-xIMa3XOTrqe0l3txyVwmxtLv208bI', '2025-04-12 10:50:01', '2025-04-09 10:50:01', NULL, 87);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMGFlMzUxMDMtNDdhYS00MjI1LTlmMDEtZDJmNzQ5ZDM1YmRhIiwiaWF0IjoxNzQyNTM5MDIzLCJleHAiOjE3NDI1NDI2MjN9.trzQG7IzstPE-bx7u2S94RNM4SyxIxc1cBFfdVjfWrs', '2025-03-28 14:37:04', '2025-03-21 14:37:04', NULL, 88);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNDQzNzg1ZGMtZTE1MS00NDYxLWJhMTgtYzZiOGFmZGViZmI2IiwiaWF0IjoxNzQyMzA0NTU0LCJleHAiOjE3NDIzOTA5NTR9.o5DGxeWyFdt_riHTLaZYUgmhSvsTGetFG3qPSl6Y-3g', '2025-03-18 21:29:14', '2025-03-18 21:29:14', NULL, 89);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNzlkNTU2ZDctOTJmNi00MjE0LTg4MTQtZTJhNDY2MTRhOGRkIiwiaWF0IjoxNzQzMzMyMTk0LCJleHAiOjE3NDMzMzU3OTR9.Rx1ICJBlXc-V_nySn5RuA6-_m9jw7kQN3DO-5tE_XTk', '2025-04-02 18:56:34', '2025-03-30 18:56:34', NULL, 90);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNGUxMzg0NWMtMDM5NS00NTUzLWEzZWMtYTM4ZDVjNThkNzM2IiwiaWF0IjoxNzQ0Mzg0MTU2LCJleHAiOjE3NDQzODU5NTZ9.r6DBtajoFMND9xHe83om8EjeR5igJWoMAmnsbHJBlFQ', '2025-04-12 23:09:16', '2025-04-11 23:09:16', NULL, 91);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMzE3ZDkzM2EtNTM2Ny00ZDc0LWIyNmEtYjg5MzAxNmM2OTZhIiwiaWF0IjoxNzQzOTg3MDg0LCJleHAiOjE3NDM5OTA2ODR9.toCGrgDc6HvXJjVBgkzaZPuE-_rWweFxa4-xlxG5muQ', '2025-04-10 08:51:24', '2025-04-07 08:51:24', NULL, 92);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiOWIxZTc5YjYtZmU5OC00NzdlLWEwNjAtN2RjNThhYTE1MDZiIiwiaWF0IjoxNzQzMzA3OTI4LCJleHAiOjE3NDMzMTE1Mjh9.b5YWJVorxR4ANPRnYikErzvyB6CBZbHMFQ5uBoRfWe4', '2025-04-02 12:12:09', '2025-03-30 12:12:09', NULL, 93);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZTQxM2NiNDQtNzBhMC00OGM2LTk3ZWEtMzdhYjc4ODUwYTc3IiwiaWF0IjoxNzQyNDYyOTM2LCJleHAiOjE3NDI1NDkzMzZ9.ZcEx9TmIPC2qnbeExvmriSe8Ry9rnv0Bzl6nF0kK2Oo', '2025-03-27 17:28:56', '2025-03-20 17:28:56', NULL, 94);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiODU5ODdhMDQtZTlhNS00YjRjLThkMDgtYjI0NWQ0MGRiNDdkIiwiaWF0IjoxNzQ0MDE0MTkwLCJleHAiOjE3NDQwMTc3OTB9.R5qdv0zxVTkwq_Y6Xo4K9H0nJrYXmNiSvNSwuiaH2XI', '2025-04-10 16:23:11', '2025-04-07 16:23:11', NULL, 95);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYWZhZjhlZDYtMjdiYS00NGFmLThjNGQtNTdmNWZkYjM4MTUzIiwiaWF0IjoxNzQyMjY5NzUyLCJleHAiOjE3NDIzNTYxNTJ9.LdEFEnS7lNRWV5Pj7QZIo9aS9NXq2k7AVtPgiNgmdzU', '2025-03-18 11:49:12', '2025-03-18 11:49:12', NULL, 96);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNWQ5MWNiMDktODJhYi00ZjFiLTkzNzktZDFhY2MyNjMxNGMzIiwiaWF0IjoxNzQxMDA5Mjk0LCJleHAiOjE3NDEwMTEwOTR9.zfwVApmVXWzcjXlLfDHWkt1IYq8zVySUwCWPQi1Lxfs', '2025-03-10 21:41:35', '2025-03-03 21:41:35', NULL, 97);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMzE5NzA1NGMtOTY3Ny00Mjc1LTlkY2YtOTRlNTU2YjZmMjk4IiwiaWF0IjoxNzQzNDMyODc1LCJleHAiOjE3NDM0MzY0NzV9.s-7RLkiZSl4s6yrtWAUPCt5KviBfeM39AawXo6_gWrw', '2025-04-03 22:54:36', '2025-03-31 22:54:36', NULL, 98);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNWYyYjEzMzItNGZkMS00MDhiLWFjMzktOTZmYTRlNDQxMjVjIiwiaWF0IjoxNzQyOTc5NjE4LCJleHAiOjE3NDI5ODMyMTh9.EYQKoa-h_nSAWtEvXEwz31K-v1lYQDYircmIo9o5Jqg', '2025-03-29 17:00:18', '2025-03-26 17:00:18', NULL, 99);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNjc5MzMzYTctNmY5OS00YTNiLWExZTgtNzIxOWVlZjhlNjI3IiwiaWF0IjoxNzQzNjU5MDEzLCJleHAiOjE3NDM2NjI2MTN9.RwedpDYnrcOHo19DgA18pZ_3pRhHiVQVVIvv80sOeUc', '2025-04-06 13:43:33', '2025-04-03 13:43:33', NULL, 100);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZjQ2OWExNjQtMzM2MC00Mjk5LTkyMzAtZjdiYmVjOTEzMjU0IiwiaWF0IjoxNzQwODQyNjE3LCJleHAiOjE3NDA4NDQ0MTd9.CGlKasGIaoRPUdgpkeFOHPUXQZYDKxUh8TNtpkg1cpo', '2025-03-08 23:23:37', '2025-03-01 23:23:37', NULL, 101);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNWI0N2JjYWMtZDI5YS00ZWZjLTgyYTgtZDU2MTQ3ZjA0ZmUwIiwiaWF0IjoxNzQyOTcxNzI0LCJleHAiOjE3NDI5NzUzMjR9.nnWiyAoerIeODlM1a_flpToeJNZAVYhHCvm4_3awiXI', '2025-03-29 14:48:44', '2025-03-26 14:48:44', NULL, 102);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZmMzNzJlODgtZmMwYi00YzcwLThjNWUtYzdiNGNhZjMyZTVmIiwiaWF0IjoxNzQzNjQwNzAxLCJleHAiOjE3NDM2NDQzMDF9.TYVzzsliwoP_Dp9fJw2YMu9zeEy_2YRS9Irf0Gpot-g', '2025-04-06 08:38:21', '2025-04-03 08:38:21', NULL, 103);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYzAzOTg0YTUtMzJkYy00YzI5LTljMzYtNmQ0MThmNmZjMDdmIiwiaWF0IjoxNzQ0MTY4NTYxLCJleHAiOjE3NDQxNzIxNjF9.Co6x_NBl20o9aBo5yqYVexMo4fw8jnqB-bLFbUd1lio', '2025-04-12 11:16:02', '2025-04-09 11:16:02', NULL, 104);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiODE3ZTc3MTYtZWQ4YS00ZmE2LThlNzYtN2MwMGIxYjFlZjM1IiwiaWF0IjoxNzQ0MzgxOTA2LCJleHAiOjE3NDQzODM3MDZ9.aSE18TooasDHAHowzeOvZgzhGMRTcd3kPABOyqxvHX8', '2025-04-12 22:31:46', '2025-04-11 22:31:46', NULL, 105);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYmYzY2JhZDktNDliOC00ZjcwLTg1MWQtMzZjYWQ3ZGI3NWEzIiwiaWF0IjoxNzQzNjU3NjM3LCJleHAiOjE3NDM2NjEyMzd9.2ISeyHZ6NK_0OzfEAZxWZybYSrK5jWrE8dSfylkpt4A', '2025-04-06 13:20:38', '2025-04-03 13:20:38', NULL, 106);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiN2FhOWQwNmItZGFmNi00NTRjLTk3NGItZTBjNzQ2ZTFmOTY5IiwiaWF0IjoxNzQ0MTY3NTQxLCJleHAiOjE3NDQxNzExNDF9.NXjjG-GBgq1p3tyAJShTt5rQSmvPKY-cl7HDyMe3Vak', '2025-04-12 10:59:01', '2025-04-09 10:59:01', NULL, 107);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYWUzNTUwNzEtNGRkMS00YTJiLTgzYzctMzY2NmQ0Y2Q1ZDczIiwiaWF0IjoxNzQyMjc1MzE0LCJleHAiOjE3NDIzNjE3MTR9.0RbT1CJWi1BnlwmVNzQf7LKzhmVsneC-_Yi_BNHEVsA', '2025-03-18 13:21:55', '2025-03-18 13:21:55', NULL, 108);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMjM0OGEyYzAtMWJkMS00ZTQzLWJiZGEtYzNiZTBiNGFhZGNkIiwiaWF0IjoxNzQyODA2Mzg5LCJleHAiOjE3NDI4MDk5ODl9.0gywJqAonn5eOtlldiF0rZlTCptsO889OYFUf9hz0vQ', '2025-03-31 16:53:09', '2025-03-24 16:53:09', NULL, 109);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMTY0YmIwZDYtMzI0OC00ZDFlLTgyNWUtMDA1NDdmMTI1OTUxIiwiaWF0IjoxNzQ0MTg0NTU2LCJleHAiOjE3NDQxODgxNTZ9.cIMkhUli94viNS6CqvT0InOo8HMF7mVleC16xHtacsA', '2025-04-12 15:42:37', '2025-04-09 15:42:37', NULL, 110);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMjJiYWY1MzgtNzlhNS00MTJiLWI2OTUtOTA0MDBjMTMwNGIwIiwiaWF0IjoxNzQzMDQyMTU5LCJleHAiOjE3NDMwNDU3NTl9.xCFg26Rd6Hm_huCAYav8m_vmF3hNit429bTb8tvKEao', '2025-03-30 10:22:40', '2025-03-27 10:22:40', NULL, 111);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiODcwMjk1ZDQtYTE0YS00ODM4LTg2MzItODJkZDk1OGM4OWU0IiwiaWF0IjoxNzQzOTUxODY2LCJleHAiOjE3NDM5NTU0NjZ9.dHWqjnE68Cjq-j9RQOau_ddS03-8YWwgaIwtwBLDgbk', '2025-04-09 23:04:27', '2025-04-06 23:04:27', NULL, 112);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNTU3YzVmNGYtNDM5NC00ZDg2LWFhZWMtYWE3MzUwYzQ4MjFhIiwiaWF0IjoxNzQzODIwOTYwLCJleHAiOjE3NDM4MjQ1NjB9.ysQDEJ1cNWtJNLIQt1pYD_ZodgPGgjw9CayQ3jmmb3g', '2025-04-08 10:42:40', '2025-04-05 10:42:40', NULL, 113);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYzJmNTg3NGUtYjUxNS00NTllLWIxMzYtNWU5ZmUyMGFlM2QxIiwiaWF0IjoxNzQyODI4MjY2LCJleHAiOjE3NDI4MzE4NjZ9.-Z3VaiunxFKUh5gNH-EU4d54WxExhBbKVyrNIuuBr3A', '2025-03-31 22:57:46', '2025-03-24 22:57:46', NULL, 114);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZmU3ZGEzNTUtOTZhMC00NGI0LTg0YzYtMjVhZTMwMDI1MDhhIiwiaWF0IjoxNzQ0MTA1NDEzLCJleHAiOjE3NDQxMDkwMTN9.IS6zlMpOKl1bMzfGd7CvdKmhczGChdqivkOx7QR-OkU', '2025-04-11 17:43:34', '2025-04-08 17:43:34', NULL, 115);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYzI4ZDBjZDQtNjYwMS00M2QxLWJlMDQtZDU5MmYyNjdmNzc2IiwiaWF0IjoxNzQyMDk0MjY0LCJleHAiOjE3NDIwOTYwNjR9.9B1eaOHbRElrzLavdNgeKgGy946t2ovzBOmXQk1p5qo', '2025-03-23 11:04:25', '2025-03-16 11:04:25', NULL, 116);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiOWQyYTk3ZGMtYTFmOS00YTM4LWFlM2MtM2JjYzY5M2ZiZjM0IiwiaWF0IjoxNzQzNjY3NDE4LCJleHAiOjE3NDM2NzEwMTh9.55FvhmwGofUHqfCFRZUNXZc4yvV-EUSlBS1etR1uwiA', '2025-04-06 16:03:38', '2025-04-03 16:03:38', NULL, 117);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZDhlZDkwOTUtNzExMC00ZjRhLWE0ODctZTdiMTE0MzkzZGQxIiwiaWF0IjoxNzQzNDAxNTE4LCJleHAiOjE3NDM0MDUxMTh9.HRIw7OAMFjE7-BqhIOnmSVZVxe7D7Ag76Jnb_lG7VR0', '2025-04-03 14:11:59', '2025-03-31 14:11:59', NULL, 118);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMDdkZGJkMzEtYjBiMy00Y2VjLWEzYzctODU0ODgxMDE0ZDMyIiwiaWF0IjoxNzQyNzA1NzAwLCJleHAiOjE3NDI3MDkzMDB9.sqMdApgDm0O8Wuqzf1EMXGLv3De71mTw2MnU4AYimlE', '2025-03-30 12:55:01', '2025-03-23 12:55:01', NULL, 119);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMWEyMTc5ZjUtZDk5MC00MzhkLWFiODAtNmU5M2JmMWU3YjU2IiwiaWF0IjoxNzQ0MTMwOTA4LCJleHAiOjE3NDQxMzI3MDh9.DCGWdbLrcYAEulE-Dv8QMry8YVfCKODE4GSfGP2JGL0', '2025-04-10 00:48:28', '2025-04-09 00:48:28', NULL, 120);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiOTcxZTkxMDMtYThlNC00YjYzLTg5MDYtZTM4NzI2ZGNlMjFiIiwiaWF0IjoxNzQ0MTMxNzczLCJleHAiOjE3NDQxMzUzNzN9.RRh2gCtHT2ubqjFqMzKjh8b1rriVrvXD8E4eD-BsYpw', '2025-04-12 01:02:53', '2025-04-09 01:02:53', NULL, 121);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiOWY0NjJhNmUtMDdkNy00NmE5LTlhNWUtMDM3NDZkNjIyMGY1IiwiaWF0IjoxNzQyNzA1NzI1LCJleHAiOjE3NDI3MDkzMjV9.flCDEzCKsuWgnnUFmhWxOvdt_0eGd7Mm66oT5TeG9Kw', '2025-03-30 12:55:25', '2025-03-23 12:55:25', NULL, 122);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiN2M3ZjFmNGMtYmYxMS00MDUyLTgxODQtMDYzMmI1OGZiMzYzIiwiaWF0IjoxNzQyOTAwNDk2LCJleHAiOjE3NDI5MDQwOTZ9.RKpspIZqAXMHaXYtOdFDboBpo5U5B2FuPnydm-Dg8XU', '2025-04-01 19:01:37', '2025-03-25 19:01:37', NULL, 123);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZGU5NWJiYmQtNThmYy00OTdkLWEzYTEtMDA3ZDdlMzg0NDdlIiwiaWF0IjoxNzQyNzA5NTM1LCJleHAiOjE3NDI3MTMxMzV9.-egDpkbz4CUhxEeB-RUimRmUOAXFVaDgukI5mhQz76E', '2025-03-30 13:58:56', '2025-03-23 13:58:56', NULL, 124);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMWQ5YzY3ZGEtYTY4ZS00MjA1LWFlYmQtMGJkNzIwMTRkNDU3IiwiaWF0IjoxNzQzNzYyMjI4LCJleHAiOjE3NDM3NjU4Mjh9.rdmDWzT9gQDdfjxqzQax8ifOlQx0Nm32lSC9Hwq6Zy0', '2025-04-07 18:23:49', '2025-04-04 18:23:49', NULL, 125);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZGNjN2M3N2UtOWRjNy00NWE1LWI1Y2EtMmViZGFhYTZiZTg1IiwiaWF0IjoxNzQyNDM5MzI4LCJleHAiOjE3NDI1MjU3Mjh9.WyTS58al3FVT5IBzGYkEGLK6T2aNMVmdhguJD3US_M4', '2025-03-27 10:55:29', '2025-03-20 10:55:29', NULL, 126);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYjVkNzI1ZDEtZDY2NS00ZmZlLWI5YTMtMThjMmJhOTkxYTE0IiwiaWF0IjoxNzQ0MTc4MDk3LCJleHAiOjE3NDQxODE2OTd9.nidS_h9zvn3dOgST6drbsU8uxkGpPgmg4cDSbAEfsX0', '2025-04-12 13:54:57', '2025-04-09 13:54:57', NULL, 127);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiY2FiNGI2ZGUtNmY1Mi00OGQxLWFhZGItZWI5ZDBkODk1YzZiIiwiaWF0IjoxNzQzNTAyNDA2LCJleHAiOjE3NDM1MDYwMDZ9.sJzWbmisX9t4Q-HOMmgLmXRRC97QXsSkE_lJd2exdhk', '2025-04-04 18:13:26', '2025-04-01 18:13:26', NULL, 128);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZDgxZDY3YTItZmE3OC00MGJhLWIzMTgtZWY5NzU5NGMwZTk2IiwiaWF0IjoxNzQzMjM5NzYzLCJleHAiOjE3NDMyNDMzNjN9.R6WcCCsjlJJPk8RDQde1v0lBoPxIZZVde5nfNtfw2VI', '2025-04-01 17:16:04', '2025-03-29 17:16:04', NULL, 129);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMzJjNWIyNDMtZGMxZC00YjJlLTg2NTMtNmZkYjJlY2UzMzg3IiwiaWF0IjoxNzQyODkwMjcwLCJleHAiOjE3NDI4OTM4NzB9.JPgsZm6V4l1hw-jS4tK_GjZrZTl1IiICysPkOVoNztw', '2025-04-01 16:11:11', '2025-03-25 16:11:11', NULL, 130);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZGVmYzZhMjUtMzNjYy00M2NlLWExOTQtZGEyMGI5YzE0OWJkIiwiaWF0IjoxNzQyOTIzMjA0LCJleHAiOjE3NDI5MjY4MDR9.a5e8336BYWITX8S1qxRQkT75Bbh0-BUTkNxVmYugObs', '2025-03-29 01:20:04', '2025-03-26 01:20:04', NULL, 131);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNmZjZjA1MzYtNDY5Zi00Y2JkLWIwN2EtZmQyZjQxODdhNDUxIiwiaWF0IjoxNzQyMTM5ODEyLCJleHAiOjE3NDIxNDE2MTJ9.0ycruqeFk9rNUyUihZC6W55oAw9fvyGRCV_dPW4_T5w', '2025-03-23 23:43:32', '2025-03-16 23:43:32', NULL, 132);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMGIyY2M0ZDctMmI2MC00YTE1LWFkMTQtY2JkOThkZDA1N2Y1IiwiaWF0IjoxNzQyMjc2MjQ4LCJleHAiOjE3NDIzNjI2NDh9.2bme81LIeS7EG-Ml6jfwsmqTxEa3jYoG8dh-kv4uQfQ', '2025-03-18 13:37:29', '2025-03-18 13:37:29', NULL, 133);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYmE2YjEzOTUtOGUyMS00ZWM5LWJjZDktNTIwNWM5MThjZjhlIiwiaWF0IjoxNzQyNzEwMTI1LCJleHAiOjE3NDI3MTM3MjV9.Zye6-vvKh8dsu39ybdKO5KIBItQBt_mXec3KebRXKGQ', '2025-03-30 14:08:46', '2025-03-23 14:08:46', NULL, 134);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiY2JmZDM1YTktY2NlMC00MWY5LWJjMGEtYzY0ZmMwNjViNDgzIiwiaWF0IjoxNzQ0MDE1MDU1LCJleHAiOjE3NDQwMTg2NTV9.IsT5cwqZpd44uedOfGFm9zrhajJRAYvuDH6oHNUI6sY', '2025-04-10 16:37:36', '2025-04-07 16:37:36', NULL, 135);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMWJkNWJjZWEtZDljYS00ODljLWJhYjgtZWEwZjhhNTQ3NmQ1IiwiaWF0IjoxNzQzMjU3Nzk1LCJleHAiOjE3NDMyNjEzOTV9.sVvS18tHok6xI2Wjau9GYBwuPxMGLSA9qEipsVZpg3Y', '2025-04-01 22:16:36', '2025-03-29 22:16:36', NULL, 136);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMzJjODRlMTEtMmRkNy00OWFlLTk1YmQtMThiMDcyMGY3MmE3IiwiaWF0IjoxNzQyNzA4MDA0LCJleHAiOjE3NDI3MTE2MDR9.476HqKtLNVF8RmydNgr7WomVqSkVLDdwdcf3g40mO-I', '2025-03-30 13:33:24', '2025-03-23 13:33:24', NULL, 137);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMGYzNTVhYzktMDk2NC00OWM2LWExM2EtMGM1MGJkOTYyNmM2IiwiaWF0IjoxNzQyODkwNzI4LCJleHAiOjE3NDI4OTQzMjh9.jCLM9TZgh4gXGbyU6eH6iXGALhlSwkCDswdF0kNMAgo', '2025-04-01 16:18:48', '2025-03-25 16:18:48', NULL, 138);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYzU3YzRjZTUtNzBiNS00YzNhLTllYmQtN2Y4N2FmOTI3ZjJmIiwiaWF0IjoxNzQ0MzgyMjE3LCJleHAiOjE3NDQzODQwMTd9.4aFMyj1CWFNMV4RrNMjCWhssNo19KcQgZ8_VKJcse3I', '2025-04-12 22:36:58', '2025-04-11 22:36:58', NULL, 139);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiOTlmNzliNWItZTEzOC00OTUwLTg2NzEtY2YwZGVjMDA5MzcxIiwiaWF0IjoxNzQzOTUxNzM5LCJleHAiOjE3NDM5NTUzMzl9.Ieb5JfYPYc-WNlkn0YPpujv7usUvpB3s5yvvomxim3E', '2025-04-09 23:02:20', '2025-04-06 23:02:20', NULL, 140);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiN2ExMzZiZDItNGIzOC00MjkyLWE2MzUtNTE4ZThlY2Y4YWVhIiwiaWF0IjoxNzQzNzYyNDI2LCJleHAiOjE3NDM3NjYwMjZ9.a8KojTEJICVtDL1x91wQgXwC4iisffrp1JnVQvmaqIE', '2025-04-07 18:27:07', '2025-04-04 18:27:07', NULL, 141);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMDhmOTUxZDgtMGMxZi00OTA1LTliZjItMTc0YTQwNTMyMjdlIiwiaWF0IjoxNzQyNDM3MDY3LCJleHAiOjE3NDI1MjM0Njd9.NqxmyweygRyF1zdyPqQZ8hcxS5q_WNkoPnqDRUREBdQ', '2025-03-27 10:17:47', '2025-03-20 10:17:47', NULL, 142);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiM2ZiMWRhNTItMzEzMS00OTUzLWFjMDEtOWQ5MTA5MmE0NTYzIiwiaWF0IjoxNzQ0MTg3ODcyLCJleHAiOjE3NDQxOTE0NzJ9.skrl2dRTkeBjgDq2OvrECPmJELtNBsQbnhm8pyDv-Tg', '2025-04-12 16:37:52', '2025-04-09 16:37:52', NULL, 143);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZTI4MDVhNGQtM2NmYS00MjdiLWFmZjAtMmVlNDVhNjUxNWJkIiwiaWF0IjoxNzQyNzk4NTU2LCJleHAiOjE3NDI4MDIxNTZ9.hn5JXecsBDqIq_zW1ggZ9I-A9tsKiV1hwqX_F0ZFQSI', '2025-03-31 14:42:37', '2025-03-24 14:42:37', NULL, 144);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMmUzZDMwMzQtMjgwZi00OTA3LThiMWQtOGFiOTAzYWNmZmUyIiwiaWF0IjoxNzQ0MDA5MTA2LCJleHAiOjE3NDQwMTI3MDZ9.RaIkrwzvY2s5ASfdtVyjPcTCwLb6cx09vDWVi0KBZLs', '2025-04-10 14:58:27', '2025-04-07 14:58:27', NULL, 145);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZjBjNzE0OGItNzJlOS00N2ZhLTk2MjktNTJlYzg2ODkyYmZiIiwiaWF0IjoxNzQ0MzAzNTM0LCJleHAiOjE3NDQzMDUzMzR9.gTNd7BDpotuWi-aYsB648SIoitoSgRGHZdDeTOgrjO8', '2025-04-12 00:45:34', '2025-04-11 00:45:34', NULL, 146);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNTdiYjZmMzEtNjNiYy00ZTJjLTk3YjUtNDJiOTRlZTFlOGFkIiwiaWF0IjoxNzQyMzE5MzA1LCJleHAiOjE3NDIzMjExMDV9.1zrUmEAbkDRz0o73boMouyyIPXQLrZVTGpMIB5rf2m0', '2025-03-26 01:35:05', '2025-03-19 01:35:05', NULL, 147);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNTVhYmJlZGMtMjMzMC00MGE0LWI4MjAtMzA0MDNhYjk5NTI5IiwiaWF0IjoxNzQyNjg5OTc3LCJleHAiOjE3NDI2OTM1Nzd9.Fve1KQccTBjMFObXpfuIzGpmlN4M5L_61Ga8Pd0WvmQ', '2025-03-30 08:32:57', '2025-03-23 08:32:57', NULL, 148);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNjNjMjZkNDMtODVlNC00MGY5LTk0YWQtZjgxMDVkMzYzOWU2IiwiaWF0IjoxNzQyNDM3NTI1LCJleHAiOjE3NDI1MjM5MjV9.LNcOpJ8SbTGEHV1tiey40tGXJjR3t3UTngN7rh9N6XA', '2025-03-27 10:25:25', '2025-03-20 10:25:25', NULL, 149);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMWM2ZGE5NmMtZjYyNy00NmVhLTg4N2EtOTM0NzZlZWVmNjRhIiwiaWF0IjoxNzQwODQyNDkyLCJleHAiOjE3NDA4NDQyOTJ9.ZX3IBW63RcJTRa4e626h4Ds9ewN6h9DuNOD5ybl39rw', '2025-03-08 23:21:32', '2025-03-01 23:21:32', NULL, 150);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZDNmOTcwYjktMTRmMS00NjZiLTgyMGItN2IxYTRkNjkzNThiIiwiaWF0IjoxNzQzNDg5MDM5LCJleHAiOjE3NDM0OTI2Mzl9.NO184ATbkw6I6c6iowhQlC1tDPAMnmVCOJMbunI-ysM', '2025-04-04 14:30:39', '2025-04-01 14:30:39', NULL, 151);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMGQ2MmFhMTEtOTU5NS00NDQ2LWIwNTctODFhYmE1ZTg2NTIzIiwiaWF0IjoxNzQyNzA2MzI0LCJleHAiOjE3NDI3MDk5MjR9.ejXMvLchbasbMDYxJu6P0Muu8PUnIgvOTf7iVny-kYs', '2025-03-30 13:05:24', '2025-03-23 13:05:24', NULL, 152);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNDNiOWU1NDgtNmViNS00ZDlhLTk1NjgtZTM4Y2JiZDI5ODhkIiwiaWF0IjoxNzQzNDcxNTUzLCJleHAiOjE3NDM0NzUxNTN9.cPlf6-sYghvHt8og7uwYXaKBzc18Eeld1q1UOO1-Le4', '2025-04-04 09:39:13', '2025-04-01 09:39:13', NULL, 153);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZTMzYjJhZmItNjY5NC00ZDhlLTgwYWQtODk3ZGQ5NDQxYWVkIiwiaWF0IjoxNzQyNzA3ODA4LCJleHAiOjE3NDI3MTE0MDh9.WfAd1LKzyhuf-rg-pnuo0WJHczQA_2h0TPVbooHasOU', '2025-03-30 13:30:08', '2025-03-23 13:30:08', NULL, 154);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMWRjZGNkMjUtMzZjMS00OTk1LWIwZmUtZTczYzlhZjRhOGMzIiwiaWF0IjoxNzQ0MjA1MTA2LCJleHAiOjE3NDQyMDg3MDZ9.fTKCQ71plNwJUQTQbKPI5rZ0UacKSccuohYD5YIPpfg', '2025-04-12 21:25:07', '2025-04-09 21:25:07', NULL, 155);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNmZhOTVlYWQtZTM4NS00ZmUzLTkzNzctNDkyZjZkNTZmODVjIiwiaWF0IjoxNzQyNzA5NDk4LCJleHAiOjE3NDI3MTMwOTh9.B-H5Y-TBBxDycmCjoCwhxJVIBiA_9bYq6Q0xpmiBHww', '2025-03-30 13:58:18', '2025-03-23 13:58:18', NULL, 156);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYTgxNGRjN2YtYWU4YS00OGUxLWI1ZWEtZTMwZTVhNDlmMTUyIiwiaWF0IjoxNzQyODY3NzU0LCJleHAiOjE3NDI4NzEzNTR9.Y-mT7GMBdv2NBnfcicJXAM0V7lJfwUkHgwbNdTqoInQ', '2025-04-01 09:55:55', '2025-03-25 09:55:55', NULL, 157);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMzRjYTlkZTQtODRlNS00OGFjLTg4ZDAtOGY0NGEzZGRjNTUyIiwiaWF0IjoxNzQzNjY3NDE4LCJleHAiOjE3NDM2NzEwMTh9.JIzFsvtu8lzXzwD1Bb1QsoxFTKnJkbgwcTyKL0LhiGs', '2025-04-06 16:03:38', '2025-04-03 16:03:38', NULL, 158);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiOWYzZTU3OTAtZjNhZi00OWQ0LTk2OTYtMjNlN2U1NmRhMTdjIiwiaWF0IjoxNzQ0MzgxOTE5LCJleHAiOjE3NDQzODM3MTl9.HiK9TwrnRpeuVEjXBvkuAcXZLhfebEVSbumEJcAu5dc', '2025-04-12 22:32:00', '2025-04-11 22:32:00', NULL, 159);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNzhjYjQzOTMtYmJjYS00NTg4LWI0YjQtYzg3MzBmOGFkNWMzIiwiaWF0IjoxNzQwOTkwMjgyLCJleHAiOjE3NDA5OTIwODJ9.LjzKWlTMvDhFAsUp0JG5Pc1PCTNLWzqq1tO9gVsr_i0', '2025-03-10 16:24:42', '2025-03-03 16:24:42', NULL, 160);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNTcxYmFkZGQtMjM1NC00ZTk2LTgxNjUtYTQ5MmNjMGM5OTQyIiwiaWF0IjoxNzQyNzEzNzE1LCJleHAiOjE3NDI3MTczMTV9.E2awOFUfTQItVnH4YUYr4DoY5X3-XDOxXfzv-HHilCI', '2025-03-30 15:08:35', '2025-03-23 15:08:35', NULL, 161);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZWY4ZTljMjUtNDkyZC00M2UyLTlmYjYtZWFmYWNiYzFkYzMyIiwiaWF0IjoxNzQzNzQzODc3LCJleHAiOjE3NDM3NDc0Nzd9.HayyB0Xf_2K4j7L3Dy6HXwkO2xuUoYv4okgr76BWAEc', '2025-04-07 13:17:57', '2025-04-04 13:17:57', NULL, 162);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYWFlYjY2NGEtNzBmMi00OTY3LWI1MzktMjc4MTYyNTEyZWU4IiwiaWF0IjoxNzQ0MDM4Nzc4LCJleHAiOjE3NDQwNDIzNzh9.fMmTXDksZl_nbJQj5msjMhrn5NYWlOEhc7ibKC5FVv8', '2025-04-10 23:12:59', '2025-04-07 23:12:59', NULL, 163);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiOTNjODBjZTItYjM5My00NTEzLTgwYmMtNTVkMzYxNzlkYWM5IiwiaWF0IjoxNzQzNTI1NjIyLCJleHAiOjE3NDM1MjkyMjJ9.yNDiB39KduuaJfeo2m9p1PDcJC3CHmcHaE1u41gmBtM', '2025-04-05 00:40:22', '2025-04-02 00:40:22', NULL, 164);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZjQwMDE3MzYtZGYxNS00MWNiLTgxYjItYjMwNTU4NTM1YzNkIiwiaWF0IjoxNzQzNTg3MTI1LCJleHAiOjE3NDM1OTA3MjV9.s9jKf08JzEUgiIPHEr4snfeGz5J-0UhwD8Xjmfef2VI', '2025-04-05 17:45:26', '2025-04-02 17:45:26', NULL, 165);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiY2ZmZmY3N2QtN2IzOS00MTY2LWFlZjUtMjNmMmQ5MzIxNTVkIiwiaWF0IjoxNzQyMjc0NjI4LCJleHAiOjE3NDIzNjEwMjh9.7Tf1GYStKltJQLQhx052rW3tg4gghktCc7xFlqDUhBc', '2025-03-18 13:10:28', '2025-03-18 13:10:28', NULL, 166);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMzViMjAxMDgtYmNiOC00ZTNlLTkzODktZjI0ZTBiNTMyNDg4IiwiaWF0IjoxNzQ0MDE3NDc4LCJleHAiOjE3NDQwMjEwNzh9.ave_y45giD_rluVMLx-3Zb8jsOcrq35honZdGkTo60s', '2025-04-10 17:17:58', '2025-04-07 17:17:58', NULL, 167);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNWYzMTY0ZDgtZDQ1Ny00M2JiLWEwNzktNzU3NzdmNTcwY2FlIiwiaWF0IjoxNzQzMTQ4Mjg2LCJleHAiOjE3NDMxNTE4ODZ9.4CBmY5hYiMLou5brEZzWrdj1rjnbqQYfZ_ktWuXiiG0', '2025-03-31 15:51:27', '2025-03-28 15:51:27', NULL, 168);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMjkwMjQyZWEtMjk4Ny00Zjk0LWE0YzEtOGFlZGZkZDM3M2Q2IiwiaWF0IjoxNzQzNjQ1ODAxLCJleHAiOjE3NDM2NDk0MDF9.P3zI0bSUOuHVfs44sLA8Q_ffUx4l8JoFY2JVrJT5DVA', '2025-04-06 10:03:22', '2025-04-03 10:03:22', NULL, 169);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMjY0YzQ2ZGYtNDYzYy00OTQ0LWExN2QtM2NmNmM1OWQwODljIiwiaWF0IjoxNzQzNzAwNTgxLCJleHAiOjE3NDM3MDQxODF9.p7vFV5Zp0bIaXY-C1XE3Q9Qq9xPqYv4zIfkpSYhUsKU', '2025-04-07 01:16:22', '2025-04-04 01:16:22', NULL, 170);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYTEzNzNiYmItYzhjMS00NDFhLWJmYzctMTI2NWIxMGIyZDEzIiwiaWF0IjoxNzQyNzEwNjAxLCJleHAiOjE3NDI3MTQyMDF9.Bjwo4JtiMvBo2ViTNd0xjq6cvECu-g0dWSPrDw64uNo', '2025-03-30 14:16:42', '2025-03-23 14:16:42', NULL, 171);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYTFiMjRlNGMtN2E4ZC00YjczLTgzOTEtOTNiOTNkMDYzZjQwIiwiaWF0IjoxNzQzMzQyOTYwLCJleHAiOjE3NDMzNDY1NjB9.XdvIptE0PoS04eSz2l_XqPQxXrB-obTaXFcmi3SQNnc', '2025-04-02 21:56:00', '2025-03-30 21:56:00', NULL, 172);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMGE4Y2M2ZjMtZjVmMy00NTdhLWEzMTMtZWI3MDdhMzdjMWJlIiwiaWF0IjoxNzQwODQyNzY3LCJleHAiOjE3NDA4NDQ1Njd9.p3ZPjzzEKBaTPmCxxhZ8g5oO43qf6sktlJr6M1UsRSs', '2025-03-08 23:26:07', '2025-03-01 23:26:07', NULL, 173);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiOWNkODRhMjQtMDQyZC00NDRhLTk3MzctMzFiOWEyNzBkNDM3IiwiaWF0IjoxNzQyNjk4NTY0LCJleHAiOjE3NDI3MDIxNjR9.k0xNHN28mG5dXJut6Anbg9SIxpl8st7TlCuV6pbkekw', '2025-03-30 10:56:05', '2025-03-23 10:56:05', NULL, 174);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYTVkMTljOGEtYTcwYi00ZDVkLTg4NmUtMjBhOGE1ODI0ZTY1IiwiaWF0IjoxNzQ0Mzg1ODYzLCJleHAiOjE3NDQzODc2NjN9.HGEVr_1Bdmzs41bhDLmWtor5tuSma3j5qPsRBxmMTa8', '2025-04-12 23:37:44', '2025-04-11 23:37:44', NULL, 175);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNWFmMTM4ZTItMWRmZS00OWNjLWIxZTQtNjRiMTI5NGRmNDk3IiwiaWF0IjoxNzQzNTk5MjQ2LCJleHAiOjE3NDM2MDI4NDZ9.VhtkSNSdxO23KsHJy0lKOyguZaNcQMVjZW74Ilj9pPc', '2025-04-05 21:07:26', '2025-04-02 21:07:26', NULL, 176);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZWExOGFhMGEtMzFlMy00NmRkLTgyZGQtNzJmMmY1ZjA5MmIxIiwiaWF0IjoxNzQyMjMwMjI5LCJleHAiOjE3NDIzMTY2Mjl9.HJ6DEC3lpCmi2yoKnkyafLwO4CTYG436yiP9a1nACeg', '2025-03-17 16:50:30', '2025-03-17 16:50:30', NULL, 177);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiOGNlZjVjNWEtMDczMC00YmQxLWIxMDQtZmE0M2ZkOTFiOTU2IiwiaWF0IjoxNzQyMjc1MDU4LCJleHAiOjE3NDIzNjE0NTh9.invQLJIDBkmGGESklDfmsa-ovCL0AR5AOG-OE1qJiuo', '2025-03-18 13:17:39', '2025-03-18 13:17:39', NULL, 178);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZGRkZDFkMWYtYWVkZC00NmMyLTg5MjYtM2VjYmM3MjMyMjZlIiwiaWF0IjoxNzQyNDkzODI1LCJleHAiOjE3NDI0OTc0MjV9.lxsoPYxfCiW7C6KzuQUxyI9AiPPSJt9cm9-oD7d3Ckk', '2025-03-28 02:03:45', '2025-03-21 02:03:45', NULL, 179);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMzZiNDE4MTAtMDdhZC00MmVkLWE1OWItY2NkMWUzNGIyZmEwIiwiaWF0IjoxNzQzNDk2NjM3LCJleHAiOjE3NDM1MDAyMzd9.9xviZZDN5piKV3M2UOwcvcBy382afQara6SFjfXDC9w', '2025-04-04 16:37:18', '2025-04-01 16:37:18', NULL, 180);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNzhkZmYxYjEtOTRlMi00OGMyLThmYjAtNDFhYzhkM2JjOTk4IiwiaWF0IjoxNzQ0MjE5OTY5LCJleHAiOjE3NDQyMjM1Njl9.NtuR4tkmBxGvLXaKLuOgbQQmRcY4StiGxVQDihPbvNs', '2025-04-17 01:32:49', '2025-04-10 01:32:49', NULL, 181);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYWMzMmM5NjYtZTJiOS00ZGQ0LWJiNmUtMmU5OGZhMjA4Y2VlIiwiaWF0IjoxNzQ0MDI0NDQ4LCJleHAiOjE3NDQwMjgwNDh9.uZgsXKbsSUXDaug0Xu_2NyLVq1Nd2A9n2wv9CgKSSmk', '2025-04-10 19:14:08', '2025-04-07 19:14:08', NULL, 182);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiOTE5MWNjOTktOGM1MS00ZWJiLWI5YzYtMWVlNDMxNmIzNmEyIiwiaWF0IjoxNzQzMjE1Mzg1LCJleHAiOjE3NDMyMTg5ODV9.U5rmHfL_gZCJ_Dk6PgLbALBt8cR-89gtH1TWATMWAFs', '2025-04-01 10:29:45', '2025-03-29 10:29:45', NULL, 183);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYjY1YzNlNWItZTQ4ZS00ODljLWIyZDAtZTgzMmZmZjE0MDcxIiwiaWF0IjoxNzQzNjU3NjM2LCJleHAiOjE3NDM2NjEyMzZ9.48Ub5wKF0kqRaATFZW622BvXO2tYQGvrohTv_Jb_V8A', '2025-04-06 13:20:37', '2025-04-03 13:20:37', NULL, 184);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZTI2YTEwZWYtMWYwZi00MmQwLTlkZDUtZGZkMDhjODc4MzdlIiwiaWF0IjoxNzQyNzA3NTgzLCJleHAiOjE3NDI3MTExODN9.p0bbstp5ky-qrFCMzZzGM3v0qS8HDSZFMHlAZ5KU2Is', '2025-03-30 13:26:24', '2025-03-23 13:26:24', NULL, 185);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZGVkZGE0MzgtZjM5My00YzgwLWFiYzctYWEyZWM3MTJmNDYyIiwiaWF0IjoxNzQzNTg2MTIyLCJleHAiOjE3NDM1ODk3MjJ9.TLuXhreoa6rvVohjmIPAbmkD46MeEkNaOsaQWzSuuG8', '2025-04-05 17:28:43', '2025-04-02 17:28:43', NULL, 186);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYTNhMzZjODMtYWU1MS00ZWVhLWFjZmYtYzhkNDk4ODgzNzNkIiwiaWF0IjoxNzQ0MTY3NDk2LCJleHAiOjE3NDQxNzEwOTZ9.F9HWn6aTpBDD7KkzRtY27_aJKrleZ4UPKSDvMuT8yRE', '2025-04-12 10:58:17', '2025-04-09 10:58:17', NULL, 187);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZDg1YjI4NWEtMWQ3NC00MmQ1LTgzOTEtMThhYWQwNDc4OWQ1IiwiaWF0IjoxNzQ0MTg3MTUyLCJleHAiOjE3NDQxOTA3NTJ9.QrUiRZtaXdKEjBo5fO0dQUeSNYjSIAeUv0_1CZsU-SU', '2025-04-12 16:25:53', '2025-04-09 16:25:53', NULL, 188);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMTI3OTg5N2MtZThlYS00MWYzLWJkZWItZjE2MGQ1MTg4ZmVmIiwiaWF0IjoxNzQ0MDE1NTQ0LCJleHAiOjE3NDQwMTkxNDR9.iXWYc7uze9YkyYJVTjCOUUkiNDXYPyN0ht4e-JFHgyA', '2025-04-10 16:45:44', '2025-04-07 16:45:44', NULL, 189);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiOTA5NmVhNzQtYTRlOS00Y2NhLThhMDgtZjQwYmQwOWZhYzU3IiwiaWF0IjoxNzQ0MDIzNDA2LCJleHAiOjE3NDQwMjcwMDZ9.6KM30HfixEJ0t6zfDfT2dq4wSNm7a6w0Lxz089hPDZM', '2025-04-10 18:56:47', '2025-04-07 18:56:47', NULL, 190);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZmNlMmU0MjMtODcwMC00Y2NmLTljOTctYTc3ZWJhYzRiYTE3IiwiaWF0IjoxNzQyOTA1NTgyLCJleHAiOjE3NDI5MDkxODJ9.5_WrNvgh8SjAo5hExmn8y4QsK572gu3Y8QOKxiOlwMs', '2025-04-01 20:26:22', '2025-03-25 20:26:22', NULL, 191);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiN2RiODViYjctN2UwNy00OWNjLThhMGMtMDAwOGYwMDc5Y2ViIiwiaWF0IjoxNzQyNjk0NzA4LCJleHAiOjE3NDI2OTgzMDh9.Sc4c8cqPEVDe5-P9gbd5cTIA-n1XZHI2mxM4an_RqXY', '2025-03-30 09:51:49', '2025-03-23 09:51:49', NULL, 192);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYjVjNjhmMDItZTczYS00NzAzLTgwODktZmQ2NjAxYzUxNTNhIiwiaWF0IjoxNzQ0MjEzMjg0LCJleHAiOjE3NDQyMTY4ODR9.ZAcSBaAatqu8jE75MTn7sWWydYn8Pfon_BVrGAg09Cg', '2025-04-12 23:41:25', '2025-04-09 23:41:25', NULL, 193);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNjgzODMxZTMtN2NhYi00MjViLThjZWYtOWU3Y2JlZDFiNjZjIiwiaWF0IjoxNzQzNTgwNjIxLCJleHAiOjE3NDM1ODQyMjF9.F3QX6JjUzH8_X4c_40wem2qm8b609YVQ3z-Vvg-qVsE', '2025-04-05 15:57:02', '2025-04-02 15:57:02', NULL, 194);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNTY1ZTFiMDItYjJlYi00NzllLTg1OGQtN2NmMzQ1YzAyYzliIiwiaWF0IjoxNzQ0NDI1MTM0LCJleHAiOjE3NDQ0MjY5MzR9.izQyTrDT2sRkZTp-H2CDvNt3MXjPzu0jiorHqRDLiL4', '2025-04-13 10:32:14', '2025-04-12 10:32:14', 8, 195);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYjBmNGVjOGEtOWJjNi00NDJlLWE0NWUtMjI0NWM3MGUwMmM0IiwiaWF0IjoxNzQ0NDI1MTkwLCJleHAiOjE3NDQ0MjY5OTB9.qydV1dkY6hv7p_AwydhDlwdWKWQvND6I2PtCp5NZbpY', '2025-04-13 10:33:10', '2025-04-12 10:33:10', 9, 196);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMzNlMWQ2Y2QtNTVmMy00Yjc5LWI1NjQtYzE5YTExYzQ3YTBlIiwiaWF0IjoxNzQ0NDI1Nzg2LCJleHAiOjE3NDQ0Mjc1ODZ9.aCCa4Vqlsn0OVcDQMpkgw6cEbcS92XIhwAqVDAY63hM', '2025-04-13 10:43:06', '2025-04-12 10:43:06', 13, 200);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYWJlYWRjYTAtMTVmMS00ODNhLTljMjItMjZlNjg0NDI0MDk4IiwiaWF0IjoxNzQ0NDI3ODM3LCJleHAiOjE3NDQ0Mjk2Mzd9.7sSzj-MRcxjDWlKcHGazgKSEiMe2r8rONhHRehBVVZY', '2025-04-13 11:17:17', '2025-04-12 11:17:17', 25, 212);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNGI5ODI3NzctODFmNC00YjlmLWIxZmEtNDIzNmUwMmFjODliIiwiaWF0IjoxNzQ0NDI4NDAxLCJleHAiOjE3NDQ0MzAyMDF9.pkQPvq3RJaA27wGzcV3bA6KEY-ZNNVLnl8EW-1JAXEY', '2025-04-13 11:26:42', '2025-04-12 11:26:42', 27, 214);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiOWFiMTVkZjctZDE1Zi00MzViLWI1NGItMWNmZjhkNjIwNzRiIiwiaWF0IjoxNzQ0NDI4OTQ3LCJleHAiOjE3NDQ0MzA3NDd9.Zkrp1ElvmnropNYWEvmhSwa6l8MQXaoPQUSRy__8S7c', '2025-04-13 11:35:48', '2025-04-12 11:35:48', 29, 216);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNTc2MTBlYzUtNzllZS00ZTc3LWEwNjEtODdhN2YwZGY5MTY1IiwiaWF0IjoxNzQ0NDI5MDA2LCJleHAiOjE3NDQ0MzA4MDZ9.vm5LkesC21NDg0nZGcSNaiKHHTZQJ8IoahMu-5lc21o', '2025-04-13 11:36:47', '2025-04-12 11:36:47', 30, 217);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNDFkNzYyOGItYTNmOC00ZWJhLThmZDAtYzExYmNlYWY1MDNmIiwiaWF0IjoxNzQ0NDI5MDQ2LCJleHAiOjE3NDQ0MzA4NDZ9.0HCobF6cOtC1BM1Jnlkg_vWeD0GoGkxBzwzF1bxWbmw', '2025-04-13 11:37:27', '2025-04-12 11:37:27', 31, 218);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZjI1MmNlZjEtNjY3Yi00MDAzLThkOGUtYjc4OWEzYjhkZTU0IiwiaWF0IjoxNzQ0NDY4Mjg3LCJleHAiOjE3NDQ0NzAwODd9.u5aUhEptdp0OJ5PV6cVvWup4FSffeF9h33zSd5OsqG8', '2025-04-13 22:31:27', '2025-04-12 22:31:27', 35, 222);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNDE3MjExMGYtYzk3MS00Y2UwLThmNmYtNjMyOTM0ZDExYzliIiwiaWF0IjoxNzQ0NDc1NTQ1LCJleHAiOjE3NDQ0NzczNDV9.Q5vG3wsjNbuh40l8Yn3VZ_6g_PcBczx0Y1tlH3-GKGI', '2025-04-14 00:32:26', '2025-04-13 00:32:26', 39, 226);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMzE0YTYxZTItY2ZkYS00YTgxLWIzMjEtNjhmOGFjNzZmOGE1IiwiaWF0IjoxNzQ0NDc2MDk5LCJleHAiOjE3NDQ0Nzc4OTl9.0lGNuSmGUWB1zV6F9-SU13b6TuJLTmkKET8yqputkhg', '2025-04-14 00:41:40', '2025-04-13 00:41:40', 41, 228);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZWQ5ZDYwZWMtZDRjZi00ZWM3LThiODItMGRhNTNiMzNlNGU1IiwiaWF0IjoxNzQ0NDc2MTMyLCJleHAiOjE3NDQ0Nzc5MzJ9.9mm24SRXzi-zN86EgQodmAXI4sT9tRQAsHcWYpm_5CM', '2025-04-14 00:42:13', '2025-04-13 00:42:13', 42, 229);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNTA2ZDg2MWYtZGM1ZS00NDdiLTk4Y2QtOWQzYzQ0MTBhOTlhIiwiaWF0IjoxNzQ0NDc2MTM3LCJleHAiOjE3NDQ0Nzc5Mzd9.cmxY89LAC5kgtPqaa4Aklj27kHf_fhoOPREDwAjz1MA', '2025-04-14 00:42:18', '2025-04-13 00:42:18', 43, 230);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMDgyNzFiZmQtZDIxNC00NDNmLThhYWQtZWE3ZWQyMTNiOTk1IiwiaWF0IjoxNzQ0NDc2MTQzLCJleHAiOjE3NDQ0Nzc5NDN9.evtKOEwy-q-cNjoYY9-6lSlk-TxH0PQF3BwtNKxy1Qs', '2025-04-14 00:42:23', '2025-04-13 00:42:23', 44, 231);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiM2I2YWEwODUtOTg1OS00N2VlLTliZjItYTVhNDBiMDA5Nzk4IiwiaWF0IjoxNzQ0NDc2MjMyLCJleHAiOjE3NDQ0NzgwMzJ9.dQpIe5hmfzmrrZAsMDj4TKO69Vf0jvBHPIz_V0i6RHk', '2025-04-14 00:43:53', '2025-04-13 00:43:53', 45, 232);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZTQ3OTAyYjktZTA2Yi00OGY4LTkyMWItOTIwMzg3ZmFmYzkwIiwiaWF0IjoxNzQ0NDc3NTQ0LCJleHAiOjE3NDQ0NzkzNDR9.KinQDYn8WqQcRh-l23W9VHvkXQADsOvyD6ZT0rbqvZQ', '2025-04-14 01:05:45', '2025-04-13 01:05:45', 55, 242);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
