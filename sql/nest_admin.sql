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

 Date: 14/04/2025 01:36:55
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_dept` (`id`, `created_at`, `updated_at`, `name`, `order`, `default`, `mpath`, `parentId`, `created_by`, `updated_by`) VALUES (1, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', '华北', 1, 0, '1.', NULL, 1, 1);
INSERT INTO `sys_dept` (`id`, `created_at`, `updated_at`, `name`, `order`, `default`, `mpath`, `parentId`, `created_by`, `updated_by`) VALUES (2, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', '运维', 1, 0, '4.2.', 4, NULL, NULL);
INSERT INTO `sys_dept` (`id`, `created_at`, `updated_at`, `name`, `order`, `default`, `mpath`, `parentId`, `created_by`, `updated_by`) VALUES (3, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', '研发部', 1, 1, '1.3.', 1, NULL, 1);
INSERT INTO `sys_dept` (`id`, `created_at`, `updated_at`, `name`, `order`, `default`, `mpath`, `parentId`, `created_by`, `updated_by`) VALUES (4, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', '华南', 2, 0, '4.', NULL, NULL, NULL);
INSERT INTO `sys_dept` (`id`, `created_at`, `updated_at`, `name`, `order`, `default`, `mpath`, `parentId`, `created_by`, `updated_by`) VALUES (10, '2025-04-13 11:05:58.621259', '2025-04-13 11:05:58.621259', '外部', 3, 0, '10.', NULL, 1, NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_dict_item
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict_item` (`id`, `created_at`, `updated_at`, `label`, `value`, `order`, `status`, `remark`, `type_id`, `created_by`, `updated_by`) VALUES (1, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', '启用', '1', 1, 1, '', 1, NULL, NULL);
INSERT INTO `sys_dict_item` (`id`, `created_at`, `updated_at`, `label`, `value`, `order`, `status`, `remark`, `type_id`, `created_by`, `updated_by`) VALUES (5, '2025-04-12 12:07:59.379001', '2025-04-12 12:07:59.379001', '禁用', '0', 2, 1, '', 1, NULL, NULL);
INSERT INTO `sys_dict_item` (`id`, `created_at`, `updated_at`, `label`, `value`, `order`, `status`, `remark`, `type_id`, `created_by`, `updated_by`) VALUES (6, '2025-04-12 12:09:35.907445', '2025-04-12 12:09:35.907445', '男', '1', 1, 1, '', 2, NULL, NULL);
INSERT INTO `sys_dict_item` (`id`, `created_at`, `updated_at`, `label`, `value`, `order`, `status`, `remark`, `type_id`, `created_by`, `updated_by`) VALUES (7, '2025-04-12 12:09:55.402096', '2025-04-12 12:09:55.402096', '女', '0', 2, 1, '', 2, NULL, NULL);
INSERT INTO `sys_dict_item` (`id`, `created_at`, `updated_at`, `label`, `value`, `order`, `status`, `remark`, `type_id`, `created_by`, `updated_by`) VALUES (8, '2025-04-13 10:24:22.197686', '2025-04-13 10:24:22.197686', '公告', '1', 1, 1, '', 3, 1, NULL);
INSERT INTO `sys_dict_item` (`id`, `created_at`, `updated_at`, `label`, `value`, `order`, `status`, `remark`, `type_id`, `created_by`, `updated_by`) VALUES (9, '2025-04-13 10:24:29.060138', '2025-04-13 10:24:29.060138', '通知', '2', 2, 1, '', 3, 1, NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict_type` (`id`, `created_at`, `updated_at`, `name`, `code`, `status`, `remark`, `created_by`, `updated_by`) VALUES (1, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', '用户状态', 'user_status', 1, '', NULL, 1);
INSERT INTO `sys_dict_type` (`id`, `created_at`, `updated_at`, `name`, `code`, `status`, `remark`, `created_by`, `updated_by`) VALUES (2, '2025-04-12 12:08:15.499276', '2025-04-12 12:08:15.499276', '用户性别', 'user_gender', 1, '', NULL, 1);
INSERT INTO `sys_dict_type` (`id`, `created_at`, `updated_at`, `name`, `code`, `status`, `remark`, `created_by`, `updated_by`) VALUES (3, '2025-04-13 10:24:08.111950', '2025-04-13 10:24:08.111950', '公告类型', 'notice_type', 1, '', 1, NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

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
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (98, '2025-04-13 16:07:20.427038', '2025-04-13 16:07:20.427038', 36, 'system_notice', '/system/notice', 'view.system_notice', NULL, 'ic:outline-notifications', 9, 0, 0, 0, NULL, 1, '通知公告', 'route.system_notice', NULL, 0, 0, 0, NULL, NULL, 1, 2, 2);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (99, '2025-04-13 16:13:47.289494', '2025-04-13 16:13:47.289494', 98, '', NULL, NULL, 'system:notice:list', NULL, 1, 0, 0, 0, NULL, 1, '列表', NULL, NULL, 0, 0, 0, NULL, NULL, 2, 2, 2);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (100, '2025-04-13 16:14:03.075460', '2025-04-13 16:14:03.075460', 98, '', NULL, NULL, 'system:notice:read', '', 2, 0, 0, 0, NULL, 1, '详情', NULL, NULL, 0, 0, 0, NULL, NULL, 2, 2, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (101, '2025-04-13 16:14:25.829637', '2025-04-13 16:14:25.829637', 98, '', NULL, NULL, 'system:notice:create', '', 3, 0, 0, 0, NULL, 1, '创建', NULL, NULL, 0, 0, 0, NULL, NULL, 2, 2, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (102, '2025-04-13 16:14:36.427214', '2025-04-13 16:14:36.427214', 98, '', NULL, NULL, 'system:notice:update', '', 4, 0, 0, 0, NULL, 1, '修改', NULL, NULL, 0, 0, 0, NULL, NULL, 2, 2, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (103, '2025-04-13 16:14:47.595467', '2025-04-13 16:14:47.595467', 98, '', NULL, NULL, 'system:notice:delete', '', 5, 0, 0, 0, NULL, 1, '删除', NULL, NULL, 0, 0, 0, NULL, NULL, 2, 2, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (104, '2025-04-13 23:56:24.790031', '2025-04-13 23:56:24.790031', 36, 'system_notice_notice-operate', '/system/notice/notice-operate', 'view.system_notice_notice-operate', NULL, 'ic:outline-notifications', 10, 0, 0, 0, 'system_notice', 1, '公告操作', 'route.system_notice_notice-operate', NULL, 0, 1, 0, NULL, NULL, 1, 2, 2);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (105, '2025-04-13 23:57:16.669670', '2025-04-13 23:57:16.669670', 104, '', NULL, NULL, 'system:notice:create', '', 1, 0, 0, 0, NULL, 1, '创建', NULL, NULL, 0, 0, 0, NULL, NULL, 2, 2, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `parent_id`, `name`, `path`, `component`, `permission`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`, `type`, `created_by`, `updated_by`) VALUES (106, '2025-04-13 23:57:31.841662', '2025-04-13 23:57:31.841662', 104, '', NULL, NULL, 'system:notice:update', '', 2, 0, 0, 0, NULL, 1, '修改', NULL, NULL, 0, 0, 0, NULL, NULL, 2, 2, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `created_by` int DEFAULT NULL COMMENT '创建人',
  `updated_by` int DEFAULT NULL COMMENT '修改者',
  `name` varchar(50) DEFAULT NULL COMMENT '公告名称',
  `content` text NOT NULL COMMENT '公告内容',
  `type` tinyint NOT NULL DEFAULT '1' COMMENT '公告类型 1 公告 2 通知',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '公告状态 1 正常 0 停用',
  PRIMARY KEY (`id`),
  KEY `FK_786b0a16729e0ed3bbf109b9c42` (`created_by`),
  KEY `FK_4023370aad3add3a505428c1298` (`updated_by`),
  CONSTRAINT `FK_4023370aad3add3a505428c1298` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_786b0a16729e0ed3bbf109b9c42` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
BEGIN;
INSERT INTO `sys_notice` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `name`, `content`, `type`, `status`) VALUES (1, '2025-04-13 16:40:05.794076', '2025-04-13 16:40:05.794076', 2, 2, '项目动态', '<h2 style=\"line-height: 1.4;\"><strong>2024-12-24</strong> &nbsp;</h2>\n<ul>\n<li><strong>小张</strong>创建了开源项目 <strong>Nest+VueAdmin，</strong>并且提交了第一个 commit !</li>\n</ul>\n<h2><strong>2025-03-02 </strong></h2>\n<ul>\n<li><strong>小张</strong>完成了前后端的对接 !</li>\n</ul>\n<h2><strong>2025-03-12&nbsp;&nbsp;</strong></h2>\n<ul>\n<li><strong>小张 </strong>完成了Docker的部署 !&nbsp;</li>\n</ul>\n<h2><strong>2025-04-13&nbsp;</strong></h2>\n<ul>\n<li><strong>小张 </strong>继续努力中</li>\n</ul>', 1, 1);
INSERT INTO `sys_notice` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `name`, `content`, `type`, `status`) VALUES (2, '2025-04-13 16:58:43.921657', '2025-04-13 16:58:43.921657', 2, 2, '项目信息', '<ul>\n<li>前端源码地址 <a href=\"https://gitee.com/mrzym/vue3-naive-admin\" target=\"_blank\" rel=\"noopener\">gitee</a> &nbsp; &nbsp;<a href=\"https://github.com/mrzym99/vue3-naive-admin\" target=\"_blank\" rel=\"noopener\">github</a></li>\n<li>后端源码地址 <a href=\"https://gitee.com/mrzym/nest-admin\" target=\"_blank\" rel=\"noopener\">gitee</a> &nbsp; &nbsp;<a href=\"https://github.com/mrzym99/nest-admin\" target=\"_blank\" rel=\"noopener\">github</a></li>\n<li>在线预览地址 <a href=\"https://nest.mrzym.top/\" target=\"_blank\" rel=\"noopener\">https://nest.mrzym.top/</a></li>\n</ul>', 1, 1);
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` (`id`, `created_at`, `updated_at`, `name`, `value`, `description`, `status`, `default`, `created_by`, `updated_by`) VALUES (1, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', '超级管理员', 'superadmin', 'I\'m the most awesome.', 1, 0, NULL, 1);
INSERT INTO `sys_role` (`id`, `created_at`, `updated_at`, `name`, `value`, `description`, `status`, `default`, `created_by`, `updated_by`) VALUES (2, '2025-04-09 16:37:40.000000', '2025-04-13 10:44:36.017308', '管理员', 'admin', '管理员', 1, 0, 1, 2);
INSERT INTO `sys_role` (`id`, `created_at`, `updated_at`, `name`, `value`, `description`, `status`, `default`, `created_by`, `updated_by`) VALUES (3, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', '测试', 'test', '测试角色', 1, 0, NULL, 2);
INSERT INTO `sys_role` (`id`, `created_at`, `updated_at`, `name`, `value`, `description`, `status`, `default`, `created_by`, `updated_by`) VALUES (4, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', '游客', 'guest', '游客', 1, 1, NULL, 2);
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
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 2);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 3);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 4);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 5);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 6);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 7);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 8);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 9);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 10);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 11);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 12);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 13);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 14);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 15);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 16);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 17);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 18);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 19);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 20);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 21);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 22);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 23);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 24);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 25);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 26);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 27);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 28);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 29);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 30);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 31);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 32);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 33);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 34);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 35);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 36);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 37);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 39);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 40);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 41);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 42);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 43);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 44);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 45);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 46);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 47);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 48);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 49);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 50);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 51);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 52);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 53);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 54);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 55);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 56);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 57);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 58);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 59);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 60);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 61);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 62);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 63);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 64);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 65);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 66);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 67);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 68);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 69);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 70);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 71);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 72);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 73);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 74);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 75);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 76);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 77);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 78);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 79);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 80);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 81);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 82);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 83);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 84);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 85);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 86);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 87);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 88);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 89);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 90);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 98);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 99);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 100);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 101);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 102);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 103);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 104);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 105);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (2, 106);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 5);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 7);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 8);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 10);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 12);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 13);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 16);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 17);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 18);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 20);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 21);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 26);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 27);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 29);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 30);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 31);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 32);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 35);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 36);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 37);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 39);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 40);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 42);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 44);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 45);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 46);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 47);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 49);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 51);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 52);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 53);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 54);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 55);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 58);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 59);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 61);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 63);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 65);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 67);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 71);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 72);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 73);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 74);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 77);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 78);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 79);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 83);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 87);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 88);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 89);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 98);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 99);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 100);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (3, 104);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (4, 10);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (4, 26);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (4, 49);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (4, 65);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (4, 83);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 2);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 3);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 4);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 5);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 6);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 7);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 8);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 9);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 10);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 11);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 12);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 13);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 14);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 15);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 16);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 17);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 18);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 19);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 20);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 21);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 22);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 23);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 24);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 25);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 26);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 27);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 28);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 29);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 30);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 31);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 32);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 33);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 34);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 35);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 36);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 37);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 39);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 40);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 41);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 42);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 43);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 44);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 45);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 46);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 47);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 48);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 49);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 50);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 51);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 52);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 53);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 54);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 55);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 56);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 57);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 58);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 59);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 60);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 61);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 62);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 63);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 64);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 65);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 66);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 67);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 68);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 69);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 70);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 71);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 72);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 73);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 74);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 75);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 76);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 77);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 78);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 79);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 80);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 81);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 82);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 83);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 84);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 85);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 86);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 87);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 88);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 89);
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES (7, 90);
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_task
-- ----------------------------
BEGIN;
INSERT INTO `sys_task` (`id`, `created_at`, `updated_at`, `name`, `service`, `type`, `status`, `start_time`, `end_time`, `limit`, `every`, `data`, `jobOpts`, `remark`, `cron`) VALUES (5, '2025-04-11 23:18:04.075099', '2025-04-11 23:18:04.075099', '清除登录日志', 'LogClearJob.clearLoginLog', 0, 1, NULL, NULL, -1, 60000, '', '{\"count\":1,\"key\":\"__default__:5:::0 0 3 * * 1\",\"cron\":\"0 0 3 * * 1\",\"jobId\":5}', '0 秒：表示第0秒。\n0 分钟：表示在小时的第0分钟。\n3 小时：表示在凌晨3点。\n* 日期：表示每天。\n* 月份：表示每个月。\n1 星期中星期几：1 表示星期一', '0 0 3 * * 1');
INSERT INTO `sys_task` (`id`, `created_at`, `updated_at`, `name`, `service`, `type`, `status`, `start_time`, `end_time`, `limit`, `every`, `data`, `jobOpts`, `remark`, `cron`) VALUES (6, '2025-04-11 23:18:36.212907', '2025-04-11 23:18:36.212907', '清除验证码日志', 'LogClearJob.clearCaptchaLog', 0, 1, NULL, NULL, -1, 60000, '', '{\"count\":1,\"key\":\"__default__:6:::0 0 3 * * 1\",\"cron\":\"0 0 3 * * 1\",\"jobId\":6}', '', '0 0 3 * * 1');
INSERT INTO `sys_task` (`id`, `created_at`, `updated_at`, `name`, `service`, `type`, `status`, `start_time`, `end_time`, `limit`, `every`, `data`, `jobOpts`, `remark`, `cron`) VALUES (7, '2025-04-11 23:18:56.168804', '2025-04-11 23:18:56.168804', '清除任务日志', 'LogClearJob.clearTaskLog', 0, 1, NULL, NULL, -1, 60000, '', '{\"count\":1,\"key\":\"__default__:7:::0 0 3 * * 1\",\"cron\":\"0 0 3 * * 1\",\"jobId\":7}', '', '0 0 3 * * 1');
INSERT INTO `sys_task` (`id`, `created_at`, `updated_at`, `name`, `service`, `type`, `status`, `start_time`, `end_time`, `limit`, `every`, `data`, `jobOpts`, `remark`, `cron`) VALUES (8, '2025-04-11 23:19:19.592586', '2025-04-11 23:19:19.592586', '发送邮件', 'EmailJob.send', 0, 0, NULL, NULL, -1, 60000, '{\n    \"to\": \"2715158815@qq.com\",\n    \"subject\": \"晚安提醒!\",\n    \"content\": \"不早啦，小张你该洗洗睡啦!晚安！\"\n}', '{\"count\":1,\"key\":\"__default__:8:::59 59 23 * * *\",\"cron\":\"59 59 23 * * *\",\"jobId\":8}', '', '59 59 23 * * *');
INSERT INTO `sys_task` (`id`, `created_at`, `updated_at`, `name`, `service`, `type`, `status`, `start_time`, `end_time`, `limit`, `every`, `data`, `jobOpts`, `remark`, `cron`) VALUES (10, '2025-04-13 02:51:33.521935', '2025-04-13 02:51:33.521935', '删除过期的access_token', 'TokenClearJob.clearExpiredAccessToken', 0, 1, NULL, NULL, -1, 60000, '', '{\"count\":1,\"key\":\"__default__:10:::0 0 3 * * ?\",\"cron\":\"0 0 3 * * ?\",\"jobId\":10}', '', '0 0 3 * * ?');
INSERT INTO `sys_task` (`id`, `created_at`, `updated_at`, `name`, `service`, `type`, `status`, `start_time`, `end_time`, `limit`, `every`, `data`, `jobOpts`, `remark`, `cron`) VALUES (11, '2025-04-13 02:55:47.921729', '2025-04-13 02:55:47.921729', '删除过期的RefreshToken', 'TokenClearJob.clearExpiredRefreshToken', 0, 1, NULL, NULL, -1, 60000, '', '{\"count\":1,\"key\":\"__default__:11:::0 0 3 * * 1\",\"cron\":\"0 0 3 * * 1\",\"jobId\":11}', '', '0 0 3 * * 1');
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
INSERT INTO `sys_task_log` (`id`, `created_at`, `updated_at`, `status`, `detail`, `consume_time`, `task_id`) VALUES (1, '2025-04-14 01:36:30.725214', '2025-04-14 01:36:30.725214', 1, NULL, 19, 7);
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
INSERT INTO `sys_user_roles` (`user_id`, `role_id`) VALUES (4, 4);
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
INSERT INTO `user` (`id`, `created_at`, `updated_at`, `username`, `password`, `status`, `profile_id`, `dept_id`) VALUES (1, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 'superadmin', '$argon2id$v=19$m=65536,t=3,p=4$A1nAM36+dJvXJvgsV9SnoA$3htBUFv591QOVs9SB6B3bH9CFUfV7YOYOSaDWu1R3m4', 1, 1, 3);
INSERT INTO `user` (`id`, `created_at`, `updated_at`, `username`, `password`, `status`, `profile_id`, `dept_id`) VALUES (2, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 'admin', '$argon2id$v=19$m=65536,t=3,p=4$uUvBxUpFRd89cqVaNStsww$6u0Crp7gqx7b1E5QT/XSo5OCusvSKX56eqErPCdzSqg', 1, 2, 3);
INSERT INTO `user` (`id`, `created_at`, `updated_at`, `username`, `password`, `status`, `profile_id`, `dept_id`) VALUES (3, '2025-04-09 16:37:40.000000', '2025-04-09 16:37:40.000000', 'test', '$argon2id$v=19$m=65536,t=3,p=4$ig8ebM6uC2S7OCjFQ0y27w$rgauYvUKerQfql3nB/V9QseShyTAzPGWbjeaD1YtCPs', 1, 3, 2);
INSERT INTO `user` (`id`, `created_at`, `updated_at`, `username`, `password`, `status`, `profile_id`, `dept_id`) VALUES (4, '2025-04-12 10:33:06.523520', '2025-04-12 10:33:06.523520', 'guest', '$argon2id$v=19$m=65536,t=3,p=4$S8N6k7WgL2X8tYBs4QrTvA$udk99vXABr+sFiQhmYEZj71ve11We3D6UcjYYAtF1zc', 1, 4, 10);
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
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user_access_token
-- ----------------------------
BEGIN;
INSERT INTO `user_access_token` (`value`, `expired_at`, `created_at`, `userId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjIsInJvbGVzIjpbImFkbWluIl0sImlhdCI6MTc0NDU2NDQwMSwiZXhwIjoxNzQ0NTY2MjAxfQ.UrhmyLUfk64P44eXZPYKefaflhnQyQQ_TXtPekWa9oE', '2025-04-14 01:43:21', '2025-04-14 01:13:21', 2, 77);
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
INSERT INTO `user_profile` (`created_at`, `updated_at`, `nick_name`, `email`, `phone`, `avatar`, `signature`, `address`, `birth_date`, `introduction`, `id`, `gender`) VALUES ('2025-02-21 17:15:27.107185', '2025-02-21 17:15:27.107185', '超级管理员', 'superadmin@qq.com', '', 'https://nest-admin-1308002460.cos.ap-chengdu.myqcloud.com/1742912393529-WechatIMG469-removebg-preview.png', '哼…这具躯壳终究无法承载吾『终焉之暗·灭世魔神』的万亿分之一力量吗…', '中国 成都', '2005-05-06 00:00:00', '(◣_◢) 您的中二能量已突破事件视界——', 1, 1);
INSERT INTO `user_profile` (`created_at`, `updated_at`, `nick_name`, `email`, `phone`, `avatar`, `signature`, `address`, `birth_date`, `introduction`, `id`, `gender`) VALUES ('2025-02-24 17:27:35.418875', '2025-02-24 17:27:35.418875', '管理员', 'admin@qq.com', NULL, 'http://myblogimgbucket.oss-cn-beijing.aliyuncs.com/1741512156799-WechatIMG431.jpg', '\"风停在窗边，嘱咐你要热爱这个世界。\"', NULL, NULL, NULL, 2, 1);
INSERT INTO `user_profile` (`created_at`, `updated_at`, `nick_name`, `email`, `phone`, `avatar`, `signature`, `address`, `birth_date`, `introduction`, `id`, `gender`) VALUES ('2025-02-26 14:52:05.341684', '2025-02-26 14:52:05.341684', '测试', 'test@qq.com', NULL, 'http://myblogimgbucket.oss-cn-beijing.aliyuncs.com/1741512170833-WechatIMG432.jpg', '\"在平凡的日子里，做自己的光。\"', NULL, NULL, NULL, 3, 1);
INSERT INTO `user_profile` (`created_at`, `updated_at`, `nick_name`, `email`, `phone`, `avatar`, `signature`, `address`, `birth_date`, `introduction`, `id`, `gender`) VALUES ('2025-03-30 20:58:26.874215', '2025-03-30 20:58:26.874215', '游客', 'guest@qq.com', NULL, 'https://myblogimgbucket.oss-cn-beijing.aliyuncs.com/WechatIMG435.jpg', NULL, NULL, NULL, NULL, 4, 1);
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
) ENGINE=InnoDB AUTO_INCREMENT=264 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user_refresh_token
-- ----------------------------
BEGIN;
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNzhkZmYxYjEtOTRlMi00OGMyLThmYjAtNDFhYzhkM2JjOTk4IiwiaWF0IjoxNzQ0MjE5OTY5LCJleHAiOjE3NDQyMjM1Njl9.NtuR4tkmBxGvLXaKLuOgbQQmRcY4StiGxVQDihPbvNs', '2025-04-17 01:32:49', '2025-04-10 01:32:49', NULL, 181);
INSERT INTO `user_refresh_token` (`value`, `expired_at`, `created_at`, `accessTokenId`, `id`) VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYTY0NjY2MGMtYzIyMC00NmViLWFhNzItMmViZDA1MjRmOWFmIiwiaWF0IjoxNzQ0NTY0NDAxLCJleHAiOjE3NDQ1NjYyMDF9.dzitGYLht8FWa73xam8XGRjXrSi6z-aVCWYshxkYNKY', '2025-04-15 01:13:21', '2025-04-14 01:13:21', 77, 263);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
