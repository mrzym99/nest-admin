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

 Date: 23/03/2025 10:32:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_captcha_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_captcha_log`;
CREATE TABLE `sys_captcha_log` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
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
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `created_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '创建人',
  `updated_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '修改者',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '部门名称',
  `order` int DEFAULT '0' COMMENT '排序',
  `default` tinyint NOT NULL DEFAULT '0' COMMENT '是否系统默认部门',
  `mpath` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '',
  `parentId` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_c75280b01c49779f2323536db67` (`parentId`) USING BTREE,
  CONSTRAINT `FK_c75280b01c49779f2323536db67` FOREIGN KEY (`parentId`) REFERENCES `sys_dept` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_dept` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `name`, `order`, `default`, `mpath`, `parentId`) VALUES ('30117850-21c4-4b7f-8d56-9cf277937df5', '2025-02-21 16:51:23.136053', '2025-02-21 16:51:23.136053', 'superadmin', NULL, '华北', 1, 0, '30117850-21c4-4b7f-8d56-9cf277937df5.', NULL);
INSERT INTO `sys_dept` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `name`, `order`, `default`, `mpath`, `parentId`) VALUES ('73606857-fbc5-494c-89a3-986aa728c769', '2025-03-09 15:32:02.084182', '2025-03-09 15:32:02.084182', '7eddd6ca-b564-4a53-be05-a1db1c962c6f', NULL, '运维', 1, 0, 'b2bd8a3d-7c67-43de-a0c8-136a6e1ac862.73606857-fbc5-494c-89a3-986aa728c769.', 'b2bd8a3d-7c67-43de-a0c8-136a6e1ac862');
INSERT INTO `sys_dept` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `name`, `order`, `default`, `mpath`, `parentId`) VALUES ('a1ac5353-6fac-4918-8e5f-4b0fbc3e3af0', '2025-02-21 16:52:24.458666', '2025-02-21 16:52:24.458666', 'superadmin', NULL, '研发部', 1, 1, '30117850-21c4-4b7f-8d56-9cf277937df5.a1ac5353-6fac-4918-8e5f-4b0fbc3e3af0.', '30117850-21c4-4b7f-8d56-9cf277937df5');
INSERT INTO `sys_dept` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `name`, `order`, `default`, `mpath`, `parentId`) VALUES ('b2bd8a3d-7c67-43de-a0c8-136a6e1ac862', '2025-02-21 16:51:55.978566', '2025-02-21 16:51:55.978566', 'superadmin', NULL, '华南', 2, 0, 'b2bd8a3d-7c67-43de-a0c8-136a6e1ac862.', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_item
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_item`;
CREATE TABLE `sys_dict_item` (
  `id` varchar(36) NOT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `created_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `updated_by` varchar(255) DEFAULT NULL COMMENT '修改者',
  `label` varchar(50) NOT NULL,
  `value` varchar(50) NOT NULL,
  `order` int DEFAULT NULL COMMENT '字典项排序',
  `status` tinyint NOT NULL DEFAULT '1',
  `remark` varchar(255) DEFAULT NULL,
  `type_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of sys_dict_item
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict_item` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `label`, `value`, `order`, `status`, `remark`, `type_id`) VALUES ('fa64cc3a-cdf7-44ea-922e-b22fd93c3a89', '2025-03-23 00:51:47.667785', '2025-03-23 00:51:47.667785', NULL, NULL, '测试字典项', 'test', 1, 1, '测试字典项', 'a8061ab8-fb27-476a-b46b-f01021f66c96');
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type` (
  `id` varchar(36) NOT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `created_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `updated_by` varchar(255) DEFAULT NULL COMMENT '修改者',
  `name` varchar(50) NOT NULL,
  `code` varchar(50) NOT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_74d0045ff7fab9f67adc0b1bda` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict_type` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `name`, `code`, `status`, `remark`) VALUES ('a8061ab8-fb27-476a-b46b-f01021f66c96', '2025-03-22 22:41:21.389724', '2025-03-22 22:41:21.389724', NULL, NULL, '测试', '123', 1, '测试字典类型');
COMMIT;

-- ----------------------------
-- Table structure for sys_login_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_login_log`;
CREATE TABLE `sys_login_log` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `created_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '创建人',
  `updated_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '修改者',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `provider` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `user_agent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `user_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_3029712e0df6a28edaee46fd470` (`user_id`) USING BTREE,
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
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `created_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '创建人',
  `updated_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '修改者',
  `parent_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单父级ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '路由名称',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '菜单路径',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '菜单组件',
  `permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '菜单权限',
  `type` int DEFAULT NULL COMMENT '菜单类型',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '菜单图标',
  `order` int DEFAULT '0' COMMENT '菜单排序',
  `is_ext` tinyint DEFAULT '0' COMMENT '是否外链',
  `ext_open_mode` tinyint DEFAULT '1' COMMENT '外链打开模式 1 项目内打开 2 项目外打开',
  `keep_alive` tinyint DEFAULT '0' COMMENT '是否缓存',
  `active_menu` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '设置当前路由高亮的菜单项，一般用于详情页',
  `status` int DEFAULT '1' COMMENT '菜单状态 1 启用 0 禁用',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '菜单/权限名称',
  `i18n_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '国际化 key',
  `route_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '路由名称',
  `icon_type` int DEFAULT NULL COMMENT '图标类型',
  `hide_in_menu` tinyint DEFAULT '0' COMMENT '是否隐藏',
  `multi_tab` tinyint DEFAULT '0' COMMENT '是否显示多标签页',
  `href` varchar(255) DEFAULT NULL COMMENT '外链地址',
  `fixed_index_in_tab` int DEFAULT NULL COMMENT '是否显示多标签页',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('05218e60-3eae-4803-afcb-786bfda4e100', '2025-03-03 17:52:31.768374', '2025-03-03 17:52:31.768374', NULL, NULL, '8ec61125-cec6-4d14-a247-58ed01533040', '', '', '', 'system:role:create', 2, '', 3, 0, 0, 0, NULL, 1, '创建', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('0eb29306-e4f9-4bb6-a803-4d589b85d751', '2025-03-23 10:18:40.477923', '2025-03-23 10:18:40.477923', NULL, NULL, '45ce9a79-f00f-4887-84f0-68492ee35b77', '', NULL, NULL, 'system:dict-type:delete', 2, '', 5, 0, 0, 0, NULL, 1, '字典类型删除', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('11062117-82e2-462b-a12e-706f06aae2eb', '2025-03-03 21:38:07.228381', '2025-03-03 21:38:07.228381', NULL, NULL, 'e63f1774-d10c-4c27-9776-133f9c8ade0c', '', '', '', 'system:task:delete', 2, '', 5, 0, 0, 0, NULL, 1, '删除', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('158f8876-c8aa-496d-83b7-a30f1475d8fe', '2025-03-03 21:50:09.671611', '2025-03-03 21:50:09.671611', NULL, NULL, 'a6e7f104-bc14-4399-9eec-c6da852d2e0a', '', '', '', 'upload:upload', 2, '', 2, 0, 0, 0, NULL, 1, '上传', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('20c703d7-8b7f-4b8f-a413-718baf283c25', '2025-03-03 11:26:40.154479', '2025-03-03 11:26:40.154479', NULL, NULL, '8aee338e-036b-4957-9325-9c67167d33db', 'tools_storage_local', '/tools/storage/local', 'view.tools_storage_local', '', 1, 'mdi:record-circle-outline', 1, 0, 0, 0, NULL, 1, '本地存储', 'route.tools_storage_local', NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('224f264f-f8b2-46f4-a40c-91e009ffafc5', '2025-03-03 21:23:48.253734', '2025-03-03 21:23:48.253734', NULL, NULL, '60ff95d2-0591-4c4d-818e-1b9e71029e4a', '', '', '', 'system:parameter:delete', 2, '', 5, 0, 0, 0, NULL, 1, '删除', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('22b097cf-fa6e-43ac-b81e-f1b7b981e1ff', '2025-03-03 11:18:33.363511', '2025-03-03 11:18:33.363511', NULL, NULL, '89a72c78-d913-4d7d-b825-ad2046d384c4', 'system_monitor_captcha-log', '/system/monitor/captcha-log', 'view.system_monitor_captcha-log', '', 1, 'mdi:email-fast-outline', 3, 0, 0, 0, NULL, 1, '验证码日志', 'route.system_monitor_captcha-log', NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('24efe79c-a7f0-4ca3-b98c-580dbb31b014', '2025-03-03 17:51:25.979669', '2025-03-03 17:51:25.979669', NULL, NULL, '527dab80-6860-48c3-8aa3-b70428711cb7', '', '', '', 'system:dept:read', 2, '', 2, 0, 0, 0, NULL, 1, '详情', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('26178ddf-5654-42cd-9aa7-2d7cdfe48a3e', '2025-02-25 17:40:45.820496', '2025-02-25 17:40:45.820496', NULL, NULL, '527dab80-6860-48c3-8aa3-b70428711cb7', '', '', '', 'system:dept:create', 2, '', 3, 0, 0, 0, NULL, 1, '创建', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('2b4c4b75-955a-477c-8190-9c1474d75a3f', '2025-03-03 22:12:29.578943', '2025-03-03 22:12:29.578943', NULL, NULL, '', 'user-center', '/user-center', 'layout.base$view.user-center', '', 1, 'mdi:account-heart-outline', 12, 0, 0, 0, NULL, 1, '个人中心', 'route.user-center', NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('2fb0054a-2452-4567-bc13-d8f4185a1a48', '2025-03-03 17:48:36.491000', '2025-03-03 17:48:36.491000', NULL, NULL, '527dab80-6860-48c3-8aa3-b70428711cb7', '', '', '', 'system:dept:update', 2, '', 4, 0, 0, 0, NULL, 1, '修改', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('30f1ed7f-554f-4465-9fa7-ea2a252ecaa7', '2025-03-04 21:41:46.729845', '2025-03-04 21:41:46.729845', NULL, NULL, 'd8c1f623-9fde-4005-a9a4-8192a89db90d', '', '', '', 'system:log:task:list', 2, '', 1, 0, 0, 0, NULL, 1, '列表', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('3d1f445c-f662-49d6-8122-2eedea1d5cbb', '2025-03-03 11:24:44.623056', '2025-03-03 11:24:44.623056', NULL, NULL, '', 'tools', '/tools', 'layout.base', '', 0, 'mdi:toolbox-outline', 3, 0, 0, 0, NULL, 1, '系统工具', 'route.tools', NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('3d44cc58-25d5-45ab-9a59-8d590a59174b', '2025-03-03 17:54:07.636784', '2025-03-03 17:54:07.636784', NULL, NULL, 'b0058d7b-bc3e-4407-8dc9-e4987b20c27c', '', '', '', 'system:menu:create', 2, '', 3, 0, 0, 0, NULL, 1, '创建', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('3e6354d8-7cd7-493d-959d-e71a4b36fdc9', '2025-03-03 21:29:27.233641', '2025-03-03 21:29:27.233641', NULL, NULL, '20c703d7-8b7f-4b8f-a413-718baf283c25', '', '', '', 'tool:storage:delete', 2, '', 3, 0, 0, 0, NULL, 1, '删除', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('3e723f23-d5fe-41ac-a255-882b2e46eb3f', '2025-03-03 11:14:54.089003', '2025-03-03 11:14:54.089003', NULL, NULL, '733cdfa0-489b-409e-99dc-159c6da3f70c', 'system_schedule', '/system/schedule', '', '', 0, 'mdi:calendar-clock-outline', 6, 0, 0, 0, NULL, 1, '任务调度', 'route.system_schedule', NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('43a2faa4-edbd-4b0b-8486-f0b6f2e86bae', '2025-03-03 17:55:42.287617', '2025-03-03 17:55:42.287617', NULL, NULL, '6e845f4d-6be4-445a-9423-53507aed82a1', '', '', '', 'system:online:list', 2, '', 1, 0, 0, 0, NULL, 1, '列表', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('45ce9a79-f00f-4887-84f0-68492ee35b77', '2025-03-23 10:16:00.637978', '2025-03-23 10:16:00.637978', NULL, NULL, '733cdfa0-489b-409e-99dc-159c6da3f70c', 'system_dict', '/system/dict', 'view.system_dict', NULL, 1, 'mdi:format-list-numbered', 8, 0, 0, 0, NULL, 1, '字典管理', 'route.system_dict', NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('490a5058-5baa-4934-b391-5fa38869da29', '2025-03-23 10:18:03.368936', '2025-03-23 10:18:03.368936', NULL, NULL, '45ce9a79-f00f-4887-84f0-68492ee35b77', '', NULL, NULL, 'system:dict-type:create', 2, '', 3, 0, 0, 0, NULL, 1, '字典类型创建', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('4ee93aeb-218a-4a36-b204-f5e7ef9ce336', '2025-03-03 17:49:15.671722', '2025-03-03 17:49:15.671722', NULL, NULL, '527dab80-6860-48c3-8aa3-b70428711cb7', '', '', '', 'system:dept:list', 2, '', 1, 0, 0, 0, NULL, 1, '列表', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('527dab80-6860-48c3-8aa3-b70428711cb7', '2025-02-24 11:35:16.809155', '2025-02-24 11:35:16.809155', NULL, NULL, '733cdfa0-489b-409e-99dc-159c6da3f70c', 'system_dept', '/system/dept', 'view.system_dept', '', 1, 'ic:outline-reduce-capacity', 1, 0, 0, 0, NULL, 1, '部门管理', 'route.system_dept', NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('57b6d55e-cc2f-4493-b70a-671c00ca911f', '2025-03-03 21:38:56.023470', '2025-03-03 21:38:56.023470', NULL, NULL, 'e63f1774-d10c-4c27-9776-133f9c8ade0c', '', '', '', 'system:task:start', 2, '', 7, 0, 0, 0, NULL, 1, '启动', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('5846a1ef-d49e-4e0b-930e-9c13f7d53103', '2025-03-23 10:20:03.553159', '2025-03-23 10:20:03.553159', NULL, NULL, '45ce9a79-f00f-4887-84f0-68492ee35b77', '', NULL, NULL, 'system:dict-item:delete', 2, '', 10, 0, 0, 0, NULL, 1, '字典项删除', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('5afd8f11-fda7-4a1f-a1dd-a7879ee38c8c', '2025-03-03 21:39:31.256088', '2025-03-03 21:39:31.256088', NULL, NULL, 'e63f1774-d10c-4c27-9776-133f9c8ade0c', '', '', '', 'system:task:stop', 2, '', 8, 0, 0, 0, NULL, 1, '停止任务', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('5cedfe60-be30-428e-8733-2158618a4399', '2025-03-03 17:54:26.438755', '2025-03-03 17:54:26.438755', NULL, NULL, 'b0058d7b-bc3e-4407-8dc9-e4987b20c27c', '', '', '', 'system:menu:update', 2, '', 4, 0, 0, 0, NULL, 1, '修改', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('5ff0e3a1-8a8f-40be-9182-78ddf0cd82e3', '2025-03-03 22:05:51.342879', '2025-03-03 22:05:51.342879', NULL, NULL, '', 'about', '/about', 'layout.base$view.about', '', 1, 'fluent:book-information-24-regular', 13, 0, 0, 0, NULL, 1, '关于', 'route.about', NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('60ff95d2-0591-4c4d-818e-1b9e71029e4a', '2025-03-03 11:12:26.662829', '2025-03-03 11:12:26.662829', NULL, NULL, '733cdfa0-489b-409e-99dc-159c6da3f70c', 'system_parameter', '/system/parameter', 'view.system_parameter', '', 1, 'mdi:database-cog-outline', 7, 0, 0, 0, NULL, 1, '参数管理', 'route.system_parameter', NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('615b41e0-6781-4c4c-96f1-a2fcced4e759', '2025-03-23 10:18:23.254830', '2025-03-23 10:18:23.254830', NULL, NULL, '45ce9a79-f00f-4887-84f0-68492ee35b77', '', NULL, NULL, 'system:dict-type:update', 2, '', 4, 0, 0, 0, NULL, 1, '字典类型修改', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('64810e7b-1f24-461b-b157-450d367e5d5b', '2025-03-23 10:17:41.022528', '2025-03-23 10:17:41.022528', NULL, NULL, '45ce9a79-f00f-4887-84f0-68492ee35b77', '', NULL, NULL, 'system:dict-type:read', 2, '', 2, 0, 0, 0, NULL, 1, '字典类型详情', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('65878bdf-abc4-4177-aab0-a05d93a89035', '2025-03-03 17:52:12.253476', '2025-03-03 17:52:12.253476', NULL, NULL, '8ec61125-cec6-4d14-a247-58ed01533040', '', '', '', 'system:role:read', 2, '', 2, 0, 0, 0, NULL, 1, '详情', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('67da4bc1-9d62-4eee-91c5-5688d4c269d1', '2025-03-23 10:19:17.895298', '2025-03-23 10:19:17.895298', NULL, NULL, '45ce9a79-f00f-4887-84f0-68492ee35b77', '', NULL, NULL, 'system:dict-item:read', 2, '', 7, 0, 0, 0, NULL, 1, '字典项详情', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('6e845f4d-6be4-445a-9423-53507aed82a1', '2025-02-25 21:47:39.778860', '2025-02-25 21:47:39.778860', NULL, NULL, '89a72c78-d913-4d7d-b825-ad2046d384c4', 'system_monitor_online', '/system/monitor/online', 'view.system_monitor_online', '', 1, 'mdi:account-multiple-check-outline', 1, 0, 0, 0, NULL, 1, '在线用户', 'route.system_monitor_online', NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('6f0fe391-d12e-4232-9078-7f746d596288', '2025-03-03 21:23:21.470548', '2025-03-03 21:23:21.470548', NULL, NULL, '60ff95d2-0591-4c4d-818e-1b9e71029e4a', '', '', '', 'system:parameter:create', 2, '', 3, 0, 0, 0, NULL, 1, '创建', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('6f65b835-f3f0-42a5-a39d-2a4a443b69be', '2025-03-03 21:37:45.499782', '2025-03-03 21:37:45.499782', NULL, NULL, 'e63f1774-d10c-4c27-9776-133f9c8ade0c', '', '', '', 'system:task:update', 2, '', 4, 0, 0, 0, NULL, 1, '修改', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('70238d0b-0fa0-4477-bded-fe36e62af9ee', '2025-03-03 21:36:44.768918', '2025-03-03 21:36:44.768918', NULL, NULL, 'e63f1774-d10c-4c27-9776-133f9c8ade0c', '', '', '', 'system:task:read', 2, '', 2, 0, 0, 0, NULL, 1, '详情', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('733cdfa0-489b-409e-99dc-159c6da3f70c', '2025-02-24 10:02:58.349389', '2025-02-24 10:02:58.349389', NULL, NULL, '', 'system', '/system', 'layout.base', '', 0, 'ic:outline-settings', 2, 0, 0, 0, NULL, 1, '系统管理', 'route.system', NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('74c2fc82-c8dc-490e-9ae3-17cab4193f08', '2025-03-03 11:25:20.194909', '2025-03-03 11:25:20.194909', NULL, NULL, '3d1f445c-f662-49d6-8122-2eedea1d5cbb', 'tools_mail', '/tools/mail', 'view.tools_mail', '', 1, 'mdi:email-arrow-right-outline', 1, 0, 0, 0, NULL, 1, '发送邮件', 'route.tools_mail', NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('7523ec31-a5fd-4b39-92f3-9cc4ebaa3e39', '2025-03-12 23:49:17.045839', '2025-03-12 23:49:17.045839', NULL, NULL, 'fcb1b735-48cf-454b-aeb2-4ac470de2826', 'blog_zym', '/blog/zym', 'view.iframe-page', NULL, 0, 'mdi:book-open-variant-outline', 1, 1, 0, 0, NULL, 1, '小张的博客', 'route.blog_zym', NULL, 0, 0, 0, 'http://mrzym.top', NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('7571fa79-918d-4d7e-b620-e4a6b94023b7', '2025-03-03 21:29:50.659801', '2025-03-03 21:29:50.659801', NULL, NULL, 'a6e7f104-bc14-4399-9eec-c6da852d2e0a', '', '', '', 'tool:oss:list', 2, '', 1, 0, 0, 0, NULL, 1, '列表', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('79ef844a-76d1-4932-b6af-e5c4d735b67c', '2025-03-03 21:32:51.462319', '2025-03-03 21:32:51.462319', NULL, NULL, 'e63f1774-d10c-4c27-9776-133f9c8ade0c', '', '', '', 'system:task:list', 2, '', 1, 0, 0, 0, NULL, 1, '列表', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('7b266e11-2e39-4d6d-a09d-96044905d354', '2025-03-04 23:33:45.986931', '2025-03-04 23:33:45.986931', NULL, NULL, '8d1065a6-2393-4f36-b0db-2c9dcf9e6e3e', '', '', '', 'system:log:login:delete', 2, '', 2, 0, 0, 0, NULL, 1, '删除', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('7ed7b3df-09d1-4dcd-a6d5-8e80785b3ad4', '2025-02-24 14:20:18.866433', '2025-02-24 14:20:18.866433', NULL, NULL, '733cdfa0-489b-409e-99dc-159c6da3f70c', 'system_user', '/system/user', 'view.system_user', '', 1, 'mdi:account-cog-outline', 4, 0, 0, 0, NULL, 1, '用户管理', 'route.system_user', NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('7f6976ba-c8a2-4bfb-9b28-f867f9630624', '2025-03-03 21:24:05.748627', '2025-03-03 21:24:05.748627', NULL, NULL, '60ff95d2-0591-4c4d-818e-1b9e71029e4a', '', '', '', 'system:parameter:update', 2, '', 4, 0, 0, 0, NULL, 1, '修改', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('8191018a-156d-4190-96ca-8c97ddc521c4', '2025-03-03 21:20:56.147642', '2025-03-03 21:20:56.147642', NULL, NULL, '60ff95d2-0591-4c4d-818e-1b9e71029e4a', '', '', '', 'system:parameter:list', 2, '', 1, 0, 0, 0, NULL, 1, '列表', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('88a5cc81-d9fc-4d49-9a50-36b0a97bb12a', '2025-03-09 16:48:53.728622', '2025-03-09 16:48:53.728622', NULL, NULL, '7ed7b3df-09d1-4dcd-a6d5-8e80785b3ad4', '', '', '', 'system:user:read', 2, '', 2, 0, 0, 0, NULL, 1, '详情', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('89a72c78-d913-4d7d-b825-ad2046d384c4', '2025-02-25 21:46:14.723505', '2025-02-25 21:46:14.723505', NULL, NULL, '733cdfa0-489b-409e-99dc-159c6da3f70c', 'system_monitor', '/system/monitor', '', '', 0, 'mdi:monitor-eye', 5, 0, 0, 0, NULL, 1, '系统监控', 'route.system_monitor', NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('8aee338e-036b-4957-9325-9c67167d33db', '2025-03-03 11:25:57.179355', '2025-03-03 11:25:57.179355', NULL, NULL, '3d1f445c-f662-49d6-8122-2eedea1d5cbb', 'tools_storage', '/tools/storage', '', '', 0, 'mdi:folder-cog-outline', 2, 0, 0, 0, NULL, 1, '存储管理', 'route.tools_storage', NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('8b55026b-8a35-42c6-8bd8-d5044e8acc6a', '2025-03-03 17:53:06.601273', '2025-03-03 17:53:06.601273', NULL, NULL, '8ec61125-cec6-4d14-a247-58ed01533040', '', '', '', 'system:role:delete', 2, '', 5, 0, 0, 0, NULL, 1, '删除', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('8bf0f5ea-608c-475a-b9e0-d40fdb89853a', '2025-03-11 23:45:03.865852', '2025-03-11 23:45:03.865852', NULL, NULL, 'fcb1b735-48cf-454b-aeb2-4ac470de2826', 'blog_zym-href', '/blog/zym-href', 'layout.base$iframe-page', NULL, 1, 'mdi:book-open-page-variant-outline', 2, 1, 1, 0, NULL, 1, '小张的博客(外链)', 'route.blog_zym', NULL, 0, 0, 0, 'http://mrzym.top', NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('8cac45d6-15ab-45b3-8f89-d87f81bd2914', '2025-03-03 17:49:55.215412', '2025-03-03 17:49:55.215412', NULL, NULL, '527dab80-6860-48c3-8aa3-b70428711cb7', '', '', '', 'system:dept:delete', 2, '', 5, 0, 0, 0, NULL, 1, '删除', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('8d1065a6-2393-4f36-b0db-2c9dcf9e6e3e', '2025-03-03 11:21:35.468822', '2025-03-03 11:21:35.468822', NULL, NULL, '89a72c78-d913-4d7d-b825-ad2046d384c4', 'system_monitor_login-log', '/system/monitor/login-log', 'view.system_monitor_login-log', '', 1, 'mdi:account-file-text-outline', 2, 0, 0, 0, NULL, 1, '登录日志', 'route.system_monitor_login-log', NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('8e35bd57-07c9-4603-a2d2-8ead7229bf38', '2025-03-09 16:48:27.104366', '2025-03-09 16:48:27.104366', NULL, NULL, '7ed7b3df-09d1-4dcd-a6d5-8e80785b3ad4', '', '', '', 'system:user:list', 2, '', 1, 0, 0, 0, NULL, 1, '列表', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('8ec61125-cec6-4d14-a247-58ed01533040', '2025-02-24 11:36:53.191060', '2025-02-24 11:36:53.191060', NULL, NULL, '733cdfa0-489b-409e-99dc-159c6da3f70c', 'system_role', '/system/role', 'view.system_role', '', 1, 'mdi:account-group-outline', 2, 0, 0, 0, NULL, 1, '角色管理', 'route.system_role', NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('92369b98-5fe8-4349-8f87-83d6ae491222', '2025-03-03 11:22:16.256186', '2025-03-03 11:22:16.256186', NULL, NULL, '89a72c78-d913-4d7d-b825-ad2046d384c4', 'system_monitor_serve', '/system/monitor/serve', 'view.system_monitor_serve', '', 1, 'mdi:server-outline', 4, 0, 0, 0, NULL, 1, '服务监控', 'route.system_monitor_serve', NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('95ef477e-b2f0-438b-8173-148efa795800', '2025-03-03 17:53:47.136671', '2025-03-03 17:53:47.136671', NULL, NULL, 'b0058d7b-bc3e-4407-8dc9-e4987b20c27c', '', '', '', 'system:menu:read', 2, '', 2, 0, 0, 0, NULL, 1, '详情', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('961833d1-34b0-4601-a1b1-2f470372138e', '2025-03-23 10:19:35.843536', '2025-03-23 10:19:35.843536', NULL, NULL, '45ce9a79-f00f-4887-84f0-68492ee35b77', '', NULL, NULL, 'system:dict-item:create', 2, '', 8, 0, 0, 0, NULL, 1, '字典项创建', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('9b75ef20-c56a-4851-a40d-483add22807a', '2025-03-03 21:49:54.324091', '2025-03-03 21:49:54.324091', NULL, NULL, '20c703d7-8b7f-4b8f-a413-718baf283c25', '', '', '', 'upload:upload', 2, '', 2, 0, 0, 0, NULL, 1, '上传', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('a1117070-eb52-409c-87af-18a8b34d0be4', '2025-03-03 17:53:22.709654', '2025-03-03 17:53:22.709654', NULL, NULL, 'b0058d7b-bc3e-4407-8dc9-e4987b20c27c', '', '', '', 'system:menu:list', 2, '', 1, 0, 0, 0, NULL, 1, '列表', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('a6e7f104-bc14-4399-9eec-c6da852d2e0a', '2025-03-03 11:27:18.717941', '2025-03-03 11:27:18.717941', NULL, NULL, '8aee338e-036b-4957-9325-9c67167d33db', 'tools_storage_oss', '/tools/storage/oss', 'view.tools_storage_oss', '', 1, 'mdi:cloud-check-variant-outline', 2, 0, 0, 0, NULL, 1, 'Oss存储', 'route.tools_storage_oss', NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('a8fae68f-2010-46e6-99a6-321a8c84a9c3', '2025-03-23 10:19:51.066804', '2025-03-23 10:19:51.066804', NULL, NULL, '45ce9a79-f00f-4887-84f0-68492ee35b77', '', NULL, NULL, 'system:dict-item:update', 2, '', 9, 0, 0, 0, NULL, 1, '字典项修改', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('b0058d7b-bc3e-4407-8dc9-e4987b20c27c', '2025-02-24 14:17:08.673906', '2025-02-24 14:17:08.673906', NULL, NULL, '733cdfa0-489b-409e-99dc-159c6da3f70c', 'system_menu', '/system/menu', 'view.system_menu', '', 1, 'mdi:list-box-outline', 3, 0, 0, 0, NULL, 1, '菜单管理', 'route.system_menu', NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('b0db8e90-1975-41f6-b7e3-edd0c18f14de', '2025-03-09 16:49:09.823710', '2025-03-09 16:49:09.823710', NULL, NULL, '7ed7b3df-09d1-4dcd-a6d5-8e80785b3ad4', '', '', '', 'system:user:create', 2, '', 3, 0, 0, 0, NULL, 1, '创建', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('b1d88fb7-3909-4cb8-94eb-eba227a10f8a', '2025-03-03 21:28:46.224477', '2025-03-03 21:28:46.224477', NULL, NULL, '20c703d7-8b7f-4b8f-a413-718baf283c25', '', '', '', 'tool:storage:list', 2, '', 1, 0, 0, 0, NULL, 1, '列表', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('b385439f-9d49-4928-b46c-07011fac91a6', '2025-03-03 21:38:34.756050', '2025-03-03 21:38:34.756050', NULL, NULL, 'e63f1774-d10c-4c27-9776-133f9c8ade0c', '', '', '', 'system:task:once', 2, '', 6, 0, 0, 0, NULL, 1, '启动一次', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('b9689729-bfe9-449e-b34c-20c8251bbffd', '2025-02-24 10:01:41.926367', '2025-02-24 10:01:41.926367', NULL, NULL, '', 'home', '/home', 'layout.base$view.home', '', 1, 'ic:outline-other-houses', 1, 0, 0, 0, NULL, 1, '首页', 'route.home', NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('bc46716e-44e8-4011-ab77-9019bdf8bd98', '2025-03-03 21:37:07.623316', '2025-03-03 21:37:07.623316', NULL, NULL, 'e63f1774-d10c-4c27-9776-133f9c8ade0c', '', '', '', 'system:task:create', 2, '', 3, 0, 0, 0, NULL, 1, '创建', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('c202fe6e-9155-434b-b797-fba36ef9e5c5', '2025-03-03 21:22:51.401940', '2025-03-03 21:22:51.401940', NULL, NULL, '60ff95d2-0591-4c4d-818e-1b9e71029e4a', '', '', '', 'system:parameter:read', 2, '', 2, 0, 0, 0, NULL, 1, '详情', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('c478b017-2cf8-44ae-81f5-85acb28202ed', '2025-03-09 16:49:28.142486', '2025-03-09 16:49:28.142486', NULL, NULL, '7ed7b3df-09d1-4dcd-a6d5-8e80785b3ad4', '', '', '', 'system:user:update', 2, '', 4, 0, 0, 0, NULL, 1, '修改', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('c9580366-5440-4451-b81e-309d027679f4', '2025-03-03 17:54:46.192200', '2025-03-03 17:54:46.192200', NULL, NULL, 'b0058d7b-bc3e-4407-8dc9-e4987b20c27c', '', '', '', 'system:menu:delete', 2, '', 5, 0, 0, 0, NULL, 1, '删除', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('d01fa481-1e35-4d0a-9c6f-3ef86fb52750', '2025-03-09 16:51:48.070173', '2025-03-09 16:51:48.070173', NULL, NULL, '7ed7b3df-09d1-4dcd-a6d5-8e80785b3ad4', '', '', '', 'system:user:pass:reset', 2, '', 6, 0, 0, 0, NULL, 1, '重置密码', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('d5b734d2-f112-4014-bb62-041c0fe2a0b4', '2025-03-03 17:51:54.637531', '2025-03-03 17:51:54.637531', NULL, NULL, '8ec61125-cec6-4d14-a247-58ed01533040', '', '', '', 'system:role:list', 2, '', 1, 0, 0, 0, NULL, 1, '列表', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('d8c1f623-9fde-4005-a9a4-8192a89db90d', '2025-03-03 11:16:45.577273', '2025-03-03 11:16:45.577273', NULL, NULL, '3e723f23-d5fe-41ac-a255-882b2e46eb3f', 'system_schedule_task-log', '/system/schedule/task-log', 'view.system_schedule_task-log', '', 1, 'mdi:invoice-text-clock-outline', 2, 0, 0, 0, NULL, 1, '任务日志', 'route.system_schedule_task-log', NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('e04f6384-93b2-41b8-9f32-10e0ae04f637', '2025-03-03 17:56:25.695577', '2025-03-03 17:56:25.695577', NULL, NULL, '8d1065a6-2393-4f36-b0db-2c9dcf9e6e3e', '', '', '', 'system:log:login:list', 2, '', 1, 0, 0, 0, NULL, 1, '列表', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('e63f1774-d10c-4c27-9776-133f9c8ade0c', '2025-03-03 11:16:08.733708', '2025-03-03 11:16:08.733708', NULL, NULL, '3e723f23-d5fe-41ac-a255-882b2e46eb3f', 'system_schedule_task', '/system/schedule/task', 'view.system_schedule_task', '', 1, 'mdi:timer-cog-outline', 1, 0, 0, 0, NULL, 1, '定时任务', 'route.system_schedule_task', NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('e8503703-694e-4c2e-8521-164452dcfed1', '2025-03-03 17:52:52.165369', '2025-03-03 17:52:52.165369', NULL, NULL, '8ec61125-cec6-4d14-a247-58ed01533040', '', '', '', 'system:role:update', 2, '', 4, 0, 0, 0, NULL, 1, '修改', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('eb95d541-04e2-47ae-9f92-9773ade8cc03', '2025-03-04 23:34:10.129717', '2025-03-04 23:34:10.129717', NULL, NULL, '22b097cf-fa6e-43ac-b81e-f1b7b981e1ff', '', '', '', 'system:log:captcha:delete', 2, '', 2, 0, 0, 0, NULL, 1, '删除', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('efb078ac-ca26-4cc9-9690-9cbdcd9aab79', '2025-03-03 17:56:44.193147', '2025-03-03 17:56:44.193147', NULL, NULL, '22b097cf-fa6e-43ac-b81e-f1b7b981e1ff', '', '', '', 'system:log:captcha:list', 2, '', 1, 0, 0, 0, NULL, 1, '列表', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('f175c4be-9d89-49f5-a052-d7381a5b40e0', '2025-03-23 10:16:38.127317', '2025-03-23 10:16:38.127317', NULL, NULL, '45ce9a79-f00f-4887-84f0-68492ee35b77', '', NULL, NULL, 'system:dict-type:list', 2, '', 1, 0, 0, 0, NULL, 1, '字典类型列表', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('f6017b6c-55a4-430a-9d4d-896ef9258520', '2025-03-23 10:18:58.733578', '2025-03-23 10:18:58.733578', NULL, NULL, '45ce9a79-f00f-4887-84f0-68492ee35b77', '', NULL, NULL, 'system:dict-item:list', 2, '', 6, 0, 0, 0, NULL, 1, '字典项列表', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('f68dfe04-075b-4345-b582-4f8a718ddc11', '2025-03-03 21:25:54.455985', '2025-03-03 21:25:54.455985', NULL, NULL, '74c2fc82-c8dc-490e-9ae3-17cab4193f08', '', '', '', 'tool:mail:send', 2, '', 1, 0, 0, 0, NULL, 1, '发送', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('f70685c1-fcfa-41a2-8904-85168321dd01', '2025-03-04 23:33:16.176880', '2025-03-04 23:33:16.176880', NULL, NULL, 'd8c1f623-9fde-4005-a9a4-8192a89db90d', '', '', '', 'system:log:task:delete', 2, '', 2, 0, 0, 0, NULL, 1, '删除', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('f7671af7-c2f2-44b4-808e-689d52e93745', '2025-03-03 17:56:03.854346', '2025-03-03 17:56:03.854346', NULL, NULL, '6e845f4d-6be4-445a-9423-53507aed82a1', '', '', '', 'system:online:kick', 2, '', 2, 0, 0, 0, NULL, 1, '下线', NULL, NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `sys_menu` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `parent_id`, `name`, `path`, `component`, `permission`, `type`, `icon`, `order`, `is_ext`, `ext_open_mode`, `keep_alive`, `active_menu`, `status`, `title`, `i18n_key`, `route_name`, `icon_type`, `hide_in_menu`, `multi_tab`, `href`, `fixed_index_in_tab`) VALUES ('fcb1b735-48cf-454b-aeb2-4ac470de2826', '2025-03-16 18:31:55.109762', '2025-03-16 18:31:55.109762', NULL, NULL, '', 'Blog', '/blog', 'layout.base', NULL, 0, 'mdi:book-heart-outline', 4, 0, 0, 0, NULL, 1, '博客', 'route.blog', NULL, 0, 0, 0, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_parameter
-- ----------------------------
DROP TABLE IF EXISTS `sys_parameter`;
CREATE TABLE `sys_parameter` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `created_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '创建人',
  `updated_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '修改者',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '参数名称',
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '参数键',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '参数值',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_parameter
-- ----------------------------
BEGIN;
INSERT INTO `sys_parameter` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `name`, `key`, `value`, `remark`) VALUES ('a8397f55-d0ec-4524-8573-a990e45d80c5', '2025-03-23 10:31:35.138857', '2025-03-23 10:31:35.138857', NULL, NULL, '测试参数', 'test-param', 'test-param', '仅测试');
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `created_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '创建人',
  `updated_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '修改者',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `value` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色标识',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '角色描述',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '角色状态 1 启用 0 禁用',
  `default` tinyint DEFAULT NULL COMMENT '是否系统默认角色',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `IDX_223de54d6badbe43a5490450c3` (`name`) USING BTREE,
  UNIQUE KEY `IDX_05edc0a51f41bb16b7d8137da9` (`value`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `name`, `value`, `description`, `status`, `default`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '2025-02-21 16:53:46.279755', '2025-02-21 16:53:46.279755', 'superadmin', NULL, '测试', 'test', '测试角色', 1, 0);
INSERT INTO `sys_role` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `name`, `value`, `description`, `status`, `default`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', '2025-03-04 21:54:54.357716', '2025-03-04 21:54:54.357716', '7eddd6ca-b564-4a53-be05-a1db1c962c6f', NULL, '游客', 'guest', '游客', 1, 1);
INSERT INTO `sys_role` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `name`, `value`, `description`, `status`, `default`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '2025-02-21 16:53:12.915722', '2025-02-21 16:53:12.915722', 'superadmin', NULL, '管理员', 'admin', '管理员', 1, 0);
COMMIT;

-- ----------------------------
-- Table structure for sys_role_menus
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menus`;
CREATE TABLE `sys_role_menus` (
  `role_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `menu_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`role_id`,`menu_id`) USING BTREE,
  KEY `IDX_35ce749b04d57e226d059e0f63` (`role_id`) USING BTREE,
  KEY `IDX_2b95fdc95b329d66c18f5baed6` (`menu_id`) USING BTREE,
  CONSTRAINT `FK_2b95fdc95b329d66c18f5baed6d` FOREIGN KEY (`menu_id`) REFERENCES `sys_menu` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_35ce749b04d57e226d059e0f633` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_role_menus
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '158f8876-c8aa-496d-83b7-a30f1475d8fe');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '20c703d7-8b7f-4b8f-a413-718baf283c25');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '22b097cf-fa6e-43ac-b81e-f1b7b981e1ff');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '24efe79c-a7f0-4ca3-b98c-580dbb31b014');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '2b4c4b75-955a-477c-8190-9c1474d75a3f');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '30f1ed7f-554f-4465-9fa7-ea2a252ecaa7');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '3d1f445c-f662-49d6-8122-2eedea1d5cbb');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '3e723f23-d5fe-41ac-a255-882b2e46eb3f');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '43a2faa4-edbd-4b0b-8486-f0b6f2e86bae');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '45ce9a79-f00f-4887-84f0-68492ee35b77');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '4ee93aeb-218a-4a36-b204-f5e7ef9ce336');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '527dab80-6860-48c3-8aa3-b70428711cb7');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '5ff0e3a1-8a8f-40be-9182-78ddf0cd82e3');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '60ff95d2-0591-4c4d-818e-1b9e71029e4a');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '64810e7b-1f24-461b-b157-450d367e5d5b');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '65878bdf-abc4-4177-aab0-a05d93a89035');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '67da4bc1-9d62-4eee-91c5-5688d4c269d1');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '6e845f4d-6be4-445a-9423-53507aed82a1');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '70238d0b-0fa0-4477-bded-fe36e62af9ee');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '733cdfa0-489b-409e-99dc-159c6da3f70c');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '74c2fc82-c8dc-490e-9ae3-17cab4193f08');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '7523ec31-a5fd-4b39-92f3-9cc4ebaa3e39');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '7571fa79-918d-4d7e-b620-e4a6b94023b7');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '79ef844a-76d1-4932-b6af-e5c4d735b67c');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '7ed7b3df-09d1-4dcd-a6d5-8e80785b3ad4');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '8191018a-156d-4190-96ca-8c97ddc521c4');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '88a5cc81-d9fc-4d49-9a50-36b0a97bb12a');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '89a72c78-d913-4d7d-b825-ad2046d384c4');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '8aee338e-036b-4957-9325-9c67167d33db');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '8bf0f5ea-608c-475a-b9e0-d40fdb89853a');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '8d1065a6-2393-4f36-b0db-2c9dcf9e6e3e');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '8e35bd57-07c9-4603-a2d2-8ead7229bf38');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '8ec61125-cec6-4d14-a247-58ed01533040');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '92369b98-5fe8-4349-8f87-83d6ae491222');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '95ef477e-b2f0-438b-8173-148efa795800');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', '9b75ef20-c56a-4851-a40d-483add22807a');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', 'a1117070-eb52-409c-87af-18a8b34d0be4');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', 'a6e7f104-bc14-4399-9eec-c6da852d2e0a');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', 'b0058d7b-bc3e-4407-8dc9-e4987b20c27c');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', 'b1d88fb7-3909-4cb8-94eb-eba227a10f8a');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', 'b9689729-bfe9-449e-b34c-20c8251bbffd');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', 'c202fe6e-9155-434b-b797-fba36ef9e5c5');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', 'd5b734d2-f112-4014-bb62-041c0fe2a0b4');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', 'd8c1f623-9fde-4005-a9a4-8192a89db90d');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', 'e04f6384-93b2-41b8-9f32-10e0ae04f637');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', 'e63f1774-d10c-4c27-9776-133f9c8ade0c');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', 'efb078ac-ca26-4cc9-9690-9cbdcd9aab79');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', 'f175c4be-9d89-49f5-a052-d7381a5b40e0');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', 'f6017b6c-55a4-430a-9d4d-896ef9258520');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', 'f68dfe04-075b-4345-b582-4f8a718ddc11');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('43df8dd8-a7ab-4fdc-82bf-c322f206d8e1', 'fcb1b735-48cf-454b-aeb2-4ac470de2826');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', '20c703d7-8b7f-4b8f-a413-718baf283c25');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', '22b097cf-fa6e-43ac-b81e-f1b7b981e1ff');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', '24efe79c-a7f0-4ca3-b98c-580dbb31b014');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', '30f1ed7f-554f-4465-9fa7-ea2a252ecaa7');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', '3d1f445c-f662-49d6-8122-2eedea1d5cbb');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', '3e723f23-d5fe-41ac-a255-882b2e46eb3f');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', '43a2faa4-edbd-4b0b-8486-f0b6f2e86bae');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', '4ee93aeb-218a-4a36-b204-f5e7ef9ce336');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', '527dab80-6860-48c3-8aa3-b70428711cb7');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', '5ff0e3a1-8a8f-40be-9182-78ddf0cd82e3');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', '60ff95d2-0591-4c4d-818e-1b9e71029e4a');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', '6e845f4d-6be4-445a-9423-53507aed82a1');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', '733cdfa0-489b-409e-99dc-159c6da3f70c');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', '7571fa79-918d-4d7e-b620-e4a6b94023b7');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', '79ef844a-76d1-4932-b6af-e5c4d735b67c');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', '7ed7b3df-09d1-4dcd-a6d5-8e80785b3ad4');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', '8191018a-156d-4190-96ca-8c97ddc521c4');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', '89a72c78-d913-4d7d-b825-ad2046d384c4');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', '8aee338e-036b-4957-9325-9c67167d33db');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', '8d1065a6-2393-4f36-b0db-2c9dcf9e6e3e');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', '8e35bd57-07c9-4603-a2d2-8ead7229bf38');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', '8ec61125-cec6-4d14-a247-58ed01533040');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', '92369b98-5fe8-4349-8f87-83d6ae491222');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', 'a1117070-eb52-409c-87af-18a8b34d0be4');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', 'a6e7f104-bc14-4399-9eec-c6da852d2e0a');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', 'b0058d7b-bc3e-4407-8dc9-e4987b20c27c');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', 'b1d88fb7-3909-4cb8-94eb-eba227a10f8a');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', 'b9689729-bfe9-449e-b34c-20c8251bbffd');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', 'd5b734d2-f112-4014-bb62-041c0fe2a0b4');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', 'd8c1f623-9fde-4005-a9a4-8192a89db90d');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', 'e04f6384-93b2-41b8-9f32-10e0ae04f637');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', 'e63f1774-d10c-4c27-9776-133f9c8ade0c');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('9c361d40-3d44-4f76-9896-770d0ac4bba1', 'efb078ac-ca26-4cc9-9690-9cbdcd9aab79');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '05218e60-3eae-4803-afcb-786bfda4e100');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '0eb29306-e4f9-4bb6-a803-4d589b85d751');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '11062117-82e2-462b-a12e-706f06aae2eb');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '158f8876-c8aa-496d-83b7-a30f1475d8fe');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '20c703d7-8b7f-4b8f-a413-718baf283c25');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '224f264f-f8b2-46f4-a40c-91e009ffafc5');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '22b097cf-fa6e-43ac-b81e-f1b7b981e1ff');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '24efe79c-a7f0-4ca3-b98c-580dbb31b014');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '26178ddf-5654-42cd-9aa7-2d7cdfe48a3e');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '2b4c4b75-955a-477c-8190-9c1474d75a3f');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '2fb0054a-2452-4567-bc13-d8f4185a1a48');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '30f1ed7f-554f-4465-9fa7-ea2a252ecaa7');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '3d1f445c-f662-49d6-8122-2eedea1d5cbb');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '3d44cc58-25d5-45ab-9a59-8d590a59174b');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '3e6354d8-7cd7-493d-959d-e71a4b36fdc9');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '3e723f23-d5fe-41ac-a255-882b2e46eb3f');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '43a2faa4-edbd-4b0b-8486-f0b6f2e86bae');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '45ce9a79-f00f-4887-84f0-68492ee35b77');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '490a5058-5baa-4934-b391-5fa38869da29');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '4ee93aeb-218a-4a36-b204-f5e7ef9ce336');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '527dab80-6860-48c3-8aa3-b70428711cb7');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '57b6d55e-cc2f-4493-b70a-671c00ca911f');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '5846a1ef-d49e-4e0b-930e-9c13f7d53103');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '5afd8f11-fda7-4a1f-a1dd-a7879ee38c8c');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '5cedfe60-be30-428e-8733-2158618a4399');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '5ff0e3a1-8a8f-40be-9182-78ddf0cd82e3');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '60ff95d2-0591-4c4d-818e-1b9e71029e4a');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '615b41e0-6781-4c4c-96f1-a2fcced4e759');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '64810e7b-1f24-461b-b157-450d367e5d5b');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '65878bdf-abc4-4177-aab0-a05d93a89035');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '67da4bc1-9d62-4eee-91c5-5688d4c269d1');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '6e845f4d-6be4-445a-9423-53507aed82a1');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '6f0fe391-d12e-4232-9078-7f746d596288');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '6f65b835-f3f0-42a5-a39d-2a4a443b69be');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '70238d0b-0fa0-4477-bded-fe36e62af9ee');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '733cdfa0-489b-409e-99dc-159c6da3f70c');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '74c2fc82-c8dc-490e-9ae3-17cab4193f08');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '7523ec31-a5fd-4b39-92f3-9cc4ebaa3e39');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '7571fa79-918d-4d7e-b620-e4a6b94023b7');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '79ef844a-76d1-4932-b6af-e5c4d735b67c');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '7b266e11-2e39-4d6d-a09d-96044905d354');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '7ed7b3df-09d1-4dcd-a6d5-8e80785b3ad4');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '7f6976ba-c8a2-4bfb-9b28-f867f9630624');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '8191018a-156d-4190-96ca-8c97ddc521c4');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '88a5cc81-d9fc-4d49-9a50-36b0a97bb12a');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '89a72c78-d913-4d7d-b825-ad2046d384c4');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '8aee338e-036b-4957-9325-9c67167d33db');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '8b55026b-8a35-42c6-8bd8-d5044e8acc6a');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '8bf0f5ea-608c-475a-b9e0-d40fdb89853a');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '8cac45d6-15ab-45b3-8f89-d87f81bd2914');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '8d1065a6-2393-4f36-b0db-2c9dcf9e6e3e');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '8e35bd57-07c9-4603-a2d2-8ead7229bf38');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '8ec61125-cec6-4d14-a247-58ed01533040');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '92369b98-5fe8-4349-8f87-83d6ae491222');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '95ef477e-b2f0-438b-8173-148efa795800');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '961833d1-34b0-4601-a1b1-2f470372138e');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', '9b75ef20-c56a-4851-a40d-483add22807a');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', 'a1117070-eb52-409c-87af-18a8b34d0be4');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', 'a6e7f104-bc14-4399-9eec-c6da852d2e0a');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', 'a8fae68f-2010-46e6-99a6-321a8c84a9c3');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', 'b0058d7b-bc3e-4407-8dc9-e4987b20c27c');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', 'b0db8e90-1975-41f6-b7e3-edd0c18f14de');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', 'b1d88fb7-3909-4cb8-94eb-eba227a10f8a');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', 'b385439f-9d49-4928-b46c-07011fac91a6');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', 'b9689729-bfe9-449e-b34c-20c8251bbffd');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', 'bc46716e-44e8-4011-ab77-9019bdf8bd98');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', 'c202fe6e-9155-434b-b797-fba36ef9e5c5');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', 'c478b017-2cf8-44ae-81f5-85acb28202ed');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', 'c9580366-5440-4451-b81e-309d027679f4');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', 'd01fa481-1e35-4d0a-9c6f-3ef86fb52750');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', 'd5b734d2-f112-4014-bb62-041c0fe2a0b4');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', 'd8c1f623-9fde-4005-a9a4-8192a89db90d');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', 'e04f6384-93b2-41b8-9f32-10e0ae04f637');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', 'e63f1774-d10c-4c27-9776-133f9c8ade0c');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', 'e8503703-694e-4c2e-8521-164452dcfed1');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', 'eb95d541-04e2-47ae-9f92-9773ade8cc03');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', 'efb078ac-ca26-4cc9-9690-9cbdcd9aab79');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', 'f175c4be-9d89-49f5-a052-d7381a5b40e0');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', 'f6017b6c-55a4-430a-9d4d-896ef9258520');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', 'f68dfe04-075b-4345-b582-4f8a718ddc11');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', 'f70685c1-fcfa-41a2-8904-85168321dd01');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', 'f7671af7-c2f2-44b4-808e-689d52e93745');
INSERT INTO `sys_role_menus` (`role_id`, `menu_id`) VALUES ('bf468315-8ceb-4e18-8fc7-bd9743c5a4c7', 'fcb1b735-48cf-454b-aeb2-4ac470de2826');
COMMIT;

-- ----------------------------
-- Table structure for sys_task
-- ----------------------------
DROP TABLE IF EXISTS `sys_task`;
CREATE TABLE `sys_task` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
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
  `cron` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Cron表达式',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_task
-- ----------------------------
BEGIN;
INSERT INTO `sys_task` (`id`, `created_at`, `updated_at`, `name`, `service`, `type`, `status`, `start_time`, `end_time`, `limit`, `every`, `data`, `jobOpts`, `remark`, `cron`) VALUES ('447a78de-5e70-48c4-9482-0d8166894af6', '2025-03-03 00:30:16.827792', '2025-03-03 00:30:16.827792', '清除验证码日志', 'LogClearJob.clearCaptchaLog', 0, 1, NULL, NULL, -1, 60000, '', '{\"count\":1,\"key\":\"__default__:447a78de-5e70-48c4-9482-0d8166894af6:::0 0 3 * * 1\",\"cron\":\"0 0 3 * * 1\",\"jobId\":\"447a78de-5e70-48c4-9482-0d8166894af6\"}', '', '0 0 3 * * 1');
INSERT INTO `sys_task` (`id`, `created_at`, `updated_at`, `name`, `service`, `type`, `status`, `start_time`, `end_time`, `limit`, `every`, `data`, `jobOpts`, `remark`, `cron`) VALUES ('6103bcdb-a142-4411-97ba-3791dceb2e5c', '2025-03-03 00:34:27.146590', '2025-03-03 00:34:27.146590', '发送邮件', 'EmailJob.send', 0, 1, NULL, NULL, -1, 60000, '{\n    \"to\": \"2715158815@qq.com\",\n    \"subject\": \"晚安提醒!\",\n    \"content\": \"不早啦，小张你该洗洗睡啦!晚安！\"\n}', '{\"count\":1,\"key\":\"__default__:6103bcdb-a142-4411-97ba-3791dceb2e5c:::59 59 23 * * *\",\"cron\":\"59 59 23 * * *\",\"jobId\":\"6103bcdb-a142-4411-97ba-3791dceb2e5c\"}', '', '59 59 23 * * *');
INSERT INTO `sys_task` (`id`, `created_at`, `updated_at`, `name`, `service`, `type`, `status`, `start_time`, `end_time`, `limit`, `every`, `data`, `jobOpts`, `remark`, `cron`) VALUES ('9e522100-3329-4a6c-b142-1fd694935cf8', '2025-03-03 00:32:29.505597', '2025-03-03 00:32:29.505597', '清除任务日志', 'LogClearJob.clearTaskLog', 0, 1, NULL, NULL, -1, 60000, '', '{\"count\":1,\"key\":\"__default__:9e522100-3329-4a6c-b142-1fd694935cf8:::0 0 3 * * 1\",\"cron\":\"0 0 3 * * 1\",\"jobId\":\"9e522100-3329-4a6c-b142-1fd694935cf8\"}', '', '0 0 3 * * 1');
INSERT INTO `sys_task` (`id`, `created_at`, `updated_at`, `name`, `service`, `type`, `status`, `start_time`, `end_time`, `limit`, `every`, `data`, `jobOpts`, `remark`, `cron`) VALUES ('e7ef514b-e684-41e1-94d3-765d18cf59fb', '2025-02-27 17:22:38.139741', '2025-02-27 17:22:38.139741', '清除登录日志', 'LogClearJob.clearLoginLog', 0, 1, NULL, NULL, 1, 60000, '', '{\"count\":1,\"key\":\"__default__:e7ef514b-e684-41e1-94d3-765d18cf59fb:::0 0 3 * * 1\",\"cron\":\"0 0 3 * * 1\",\"limit\":1,\"jobId\":\"e7ef514b-e684-41e1-94d3-765d18cf59fb\"}', '0 秒：表示第0秒。\n0 分钟：表示在小时的第0分钟。\n3 小时：表示在凌晨3点。\n* 日期：表示每天。\n* 月份：表示每个月。\n1 星期中星期几：1 表示星期一', '0 0 3 * * 1');
COMMIT;

-- ----------------------------
-- Table structure for sys_task_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_task_log`;
CREATE TABLE `sys_task_log` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '任务状态 1 成功 0 失败',
  `detail` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '任务日志信息',
  `consume_time` int DEFAULT '0' COMMENT '任务耗时',
  `task_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_f4d9c36052fdb188ff5c089454b` (`task_id`) USING BTREE,
  CONSTRAINT `FK_f4d9c36052fdb188ff5c089454b` FOREIGN KEY (`task_id`) REFERENCES `sys_task` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_task_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_user_roles
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_roles`;
CREATE TABLE `sys_user_roles` (
  `user_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `role_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`) USING BTREE,
  KEY `IDX_96311d970191a044ec048011f4` (`user_id`) USING BTREE,
  KEY `IDX_6d61c5b3f76a3419d93a421669` (`role_id`) USING BTREE,
  CONSTRAINT `FK_6d61c5b3f76a3419d93a4216695` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`),
  CONSTRAINT `FK_96311d970191a044ec048011f44` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_user_roles
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_roles` (`user_id`, `role_id`) VALUES ('4c51b321-dedb-4110-827d-ccbcd83b5867', '9c361d40-3d44-4f76-9896-770d0ac4bba1');
INSERT INTO `sys_user_roles` (`user_id`, `role_id`) VALUES ('7eddd6ca-b564-4a53-be05-a1db1c962c6f', 'bf468315-8ceb-4e18-8fc7-bd9743c5a4c7');
INSERT INTO `sys_user_roles` (`user_id`, `role_id`) VALUES ('ac09dac7-e2e6-44d4-86c8-fe614301b441', '43df8dd8-a7ab-4fdc-82bf-c322f206d8e1');
COMMIT;

-- ----------------------------
-- Table structure for task_entity
-- ----------------------------
DROP TABLE IF EXISTS `task_entity`;
CREATE TABLE `task_entity` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `service` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务服务',
  `type` tinyint NOT NULL DEFAULT '1' COMMENT '任务类型 1:cron 2:interval',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '任务状态 1 启用 0 禁用',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `limit` int DEFAULT '0' COMMENT '限制执行次数，负数则无限制',
  `corn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'corn表达式',
  `every` int DEFAULT NULL COMMENT '执行间隔，毫秒单位',
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '执行数据',
  `jobOpts` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '执行选项配置',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of task_entity
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for tool_storage
-- ----------------------------
DROP TABLE IF EXISTS `tool_storage`;
CREATE TABLE `tool_storage` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文件名',
  `fileName` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '真实文件名',
  `ext_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `size` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
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
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `status` tinyint DEFAULT '1' COMMENT '状态 1 启用 0 禁用',
  `profile_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `dept_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `IDX_78a916df40e02a9deb1c4b75ed` (`username`) USING BTREE,
  UNIQUE KEY `REL_f44d0cd18cfd80b0fed7806c3b` (`profile_id`) USING BTREE,
  KEY `FK_c330c4acd2740fac489be6d2889` (`dept_id`) USING BTREE,
  CONSTRAINT `FK_c330c4acd2740fac489be6d2889` FOREIGN KEY (`dept_id`) REFERENCES `sys_dept` (`id`),
  CONSTRAINT `FK_f44d0cd18cfd80b0fed7806c3b7` FOREIGN KEY (`profile_id`) REFERENCES `user_profile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` (`id`, `created_at`, `updated_at`, `username`, `password`, `status`, `profile_id`, `dept_id`) VALUES ('4c51b321-dedb-4110-827d-ccbcd83b5867', '2025-02-26 14:52:05.359710', '2025-02-26 14:52:05.359710', 'guest', '$argon2id$v=19$m=65536,t=3,p=4$xY9C8HMfnfy0e5e92y1Ang$+dBO8pgZXnwTRglKi71FxoZniJj8p4zYzuyYqAy/MGk', 1, '4fa2bd87-7460-453f-be65-76128af9518d', '73606857-fbc5-494c-89a3-986aa728c769');
INSERT INTO `user` (`id`, `created_at`, `updated_at`, `username`, `password`, `status`, `profile_id`, `dept_id`) VALUES ('7eddd6ca-b564-4a53-be05-a1db1c962c6f', '2025-02-21 17:15:27.122051', '2025-02-21 17:15:27.122051', 'admin', '$argon2id$v=19$m=65536,t=3,p=4$OuefvcN4RNSOCSmXzbdydA$D05DU67SEEgVNI1P6ja4KFRf3WAzCtVWts8VrjmCu2I', 1, '6463122f-a435-430c-9d69-c7fbddaf0de8', 'a1ac5353-6fac-4918-8e5f-4b0fbc3e3af0');
INSERT INTO `user` (`id`, `created_at`, `updated_at`, `username`, `password`, `status`, `profile_id`, `dept_id`) VALUES ('ac09dac7-e2e6-44d4-86c8-fe614301b441', '2025-02-24 17:27:35.436561', '2025-02-24 17:27:35.436561', 'test', '$argon2id$v=19$m=65536,t=3,p=4$gQlOORO3f79TZAGmEZDkBw$UGBBjhY4Vs3sVktqA0UG8QQ5agODZ+O8xsr0x2Q04/U', 1, 'a32e725f-7a75-4770-b9d7-c9e15852c028', 'a1ac5353-6fac-4918-8e5f-4b0fbc3e3af0');
COMMIT;

-- ----------------------------
-- Table structure for user_access_token
-- ----------------------------
DROP TABLE IF EXISTS `user_access_token`;
CREATE TABLE `user_access_token` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `expired_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `userId` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_c9c6ac4970ddbe5a8c4887e1e7e` (`userId`) USING BTREE,
  CONSTRAINT `FK_c9c6ac4970ddbe5a8c4887e1e7e` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user_access_token
-- ----------------------------
BEGIN;
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('019f4f0e-f2f8-4ec5-80ef-6143d57f3da8', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiJhYzA5ZGFjNy1lMmU2LTQ0ZDQtODZjOC1mZTYxNDMwMWI0NDEiLCJyb2xlcyI6WyJ0ZXN0Il0sImlhdCI6MTc0MDkyODcxNywiZXhwIjoxNzQwOTMwNTE3fQ.lfIL4ky7NGscET51RX_N72nea1T0TlxZkjkeBpYB_BM', '2025-03-02 23:48:38', '2025-03-02 23:18:38', 'ac09dac7-e2e6-44d4-86c8-fe614301b441');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('053bb242-6b73-4173-9358-98c6275e1ec9', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI3ZWRkZDZjYS1iNTY0LTRhNTMtYmUwNS1hMWRiMWM5NjJjNmYiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3NDIyNzUwNTgsImV4cCI6MTc0MjM2MTQ1OH0.4KqJMnqxONX2sjSlRYKeH1oWIgykmY5JYQhYH574mMg', '2025-03-19 13:17:39', '2025-03-18 13:17:39', '7eddd6ca-b564-4a53-be05-a1db1c962c6f');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('0583e358-12df-4d48-8ab3-c440ce82868d', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI3ZWRkZDZjYS1iNTY0LTRhNTMtYmUwNS1hMWRiMWM5NjJjNmYiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3NDIyNjk3NTIsImV4cCI6MTc0MjM1NjE1Mn0.MbvTlrbhhGSZaPRPt0mD4-ISB67BYoZSTTy7qQT7JwY', '2025-03-19 11:49:12', '2025-03-18 11:49:12', '7eddd6ca-b564-4a53-be05-a1db1c962c6f');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('07d25aa2-35b3-469c-b10a-f13c1cc99844', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI3ZWRkZDZjYS1iNTY0LTRhNTMtYmUwNS1hMWRiMWM5NjJjNmYiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3NDIyOTA5NDQsImV4cCI6MTc0MjM3NzM0NH0.AKmz5ESu8T766avHTrCk6_Tw36pRZhXGadZ1ivRKdNI', '2025-03-19 17:42:25', '2025-03-18 17:42:25', '7eddd6ca-b564-4a53-be05-a1db1c962c6f');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('0dd0cd40-96e7-40a6-97f1-b6f58d7836bc', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI3ZWRkZDZjYS1iNTY0LTRhNTMtYmUwNS1hMWRiMWM5NjJjNmYiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3NDI0NTg4ODQsImV4cCI6MTc0MjU0NTI4NH0.BhAoL6olytTz3cb85H4SMQTNoyOkWAHt2lN0N_pv_Vs', '2025-03-21 16:21:24', '2025-03-20 16:21:24', '7eddd6ca-b564-4a53-be05-a1db1c962c6f');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('100a798f-99e4-47b1-afb5-c69c0fa8f3f6', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI0YzUxYjMyMS1kZWRiLTQxMTAtODI3ZC1jY2JjZDgzYjU4NjciLCJyb2xlcyI6WyJndWVzdCJdLCJpYXQiOjE3NDI0NTA4NDcsImV4cCI6MTc0MjUzNzI0N30.EyT18AT8yKb5yg_zBGPmqcYl8X7w6Qh030KgXSi_sjY', '2025-03-21 14:07:27', '2025-03-20 14:07:27', '4c51b321-dedb-4110-827d-ccbcd83b5867');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('10b8b92b-cb98-4c81-b33f-1508c0adabe3', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI3ZWRkZDZjYS1iNTY0LTRhNTMtYmUwNS1hMWRiMWM5NjJjNmYiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3NDI2OTY2MzksImV4cCI6MTc0Mjc4MzAzOX0.HfYsMGJk3CPl1OLT6LV9gJiPHZ4SRYgsyhqOJNmppFI', '2025-03-24 10:24:00', '2025-03-23 10:24:00', '7eddd6ca-b564-4a53-be05-a1db1c962c6f');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('17a7367f-931e-4bda-a137-0b43c23ab80b', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI3ZWRkZDZjYS1iNTY0LTRhNTMtYmUwNS1hMWRiMWM5NjJjNmYiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3NDI1NDE4MjEsImV4cCI6MTc0MjU0NTQyMX0.j52jvWP06gviEwrojzWfMPbFafjfwINjuwO-xPDzwJA', '2025-03-21 16:23:42', '2025-03-21 15:23:42', '7eddd6ca-b564-4a53-be05-a1db1c962c6f');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('1e651335-38b7-41a5-bace-3607c249c37f', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI3ZWRkZDZjYS1iNTY0LTRhNTMtYmUwNS1hMWRiMWM5NjJjNmYiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3NDIwOTQyNjQsImV4cCI6MTc0MjA5NjA2NH0.Io3PhmjRW9HNjC4smyMY_Ht9eZG_hxcahP85Mw6FmWw', '2025-03-16 11:34:25', '2025-03-16 11:04:25', '7eddd6ca-b564-4a53-be05-a1db1c962c6f');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('2362a089-eba7-4692-bca2-1f5cf424b821', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI0YzUxYjMyMS1kZWRiLTQxMTAtODI3ZC1jY2JjZDgzYjU4NjciLCJyb2xlcyI6WyJndWVzdCJdLCJpYXQiOjE3NDIyNzQ2MjgsImV4cCI6MTc0MjM2MTAyOH0.bi4uqTyDhKM_orur9RTQ5vzja3A6vAYC5tmaJoejNfM', '2025-03-19 13:10:28', '2025-03-18 13:10:28', '4c51b321-dedb-4110-827d-ccbcd83b5867');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('2dd5a20c-8be5-49b6-9763-06169e9636ce', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiJhYzA5ZGFjNy1lMmU2LTQ0ZDQtODZjOC1mZTYxNDMwMWI0NDEiLCJyb2xlcyI6WyJ0ZXN0Il0sImlhdCI6MTc0MDg0MjQ5MiwiZXhwIjoxNzQwODQ0MjkyfQ.JXHMgVv6zA_hO0a1yrTp4k6WJ7mH4YmXHgY2ldkX-iw', '2025-03-01 23:51:32', '2025-03-01 23:21:32', 'ac09dac7-e2e6-44d4-86c8-fe614301b441');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('3236100e-069b-4f21-897a-e61cf3ff2014', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI3ZWRkZDZjYS1iNTY0LTRhNTMtYmUwNS1hMWRiMWM5NjJjNmYiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3NDI1MjAxNTEsImV4cCI6MTc0MjUyMzc1MX0.-Di70B-r6a9ZEqyBvIntR0qf_tZGqlEZo3iVnkmNvD4', '2025-03-21 10:22:31', '2025-03-21 09:22:31', '7eddd6ca-b564-4a53-be05-a1db1c962c6f');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('36b939a7-f9d4-4aa9-8a92-de4a5f03b1ca', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI3ZWRkZDZjYS1iNTY0LTRhNTMtYmUwNS1hMWRiMWM5NjJjNmYiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3NDIyNjk2ODIsImV4cCI6MTc0MjM1NjA4Mn0.GBwgXJH-ZW2GhuFmUI3ceOuFZsHk--dYOl4BCIHf_aU', '2025-03-19 11:48:03', '2025-03-18 11:48:03', '7eddd6ca-b564-4a53-be05-a1db1c962c6f');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('3c6e60ae-ed6f-4908-8742-7e3d2bac7b3f', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI3ZWRkZDZjYS1iNTY0LTRhNTMtYmUwNS1hMWRiMWM5NjJjNmYiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3NDI0OTM2NjEsImV4cCI6MTc0MjQ5NzI2MX0.2wkk3aGJ3z5qdoNaqYRR3YpP5oC6vhSqoF434H2166Q', '2025-03-21 03:01:02', '2025-03-21 02:01:02', '7eddd6ca-b564-4a53-be05-a1db1c962c6f');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('3ff802cd-cae9-4344-91eb-d84de025d796', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI3ZWRkZDZjYS1iNTY0LTRhNTMtYmUwNS1hMWRiMWM5NjJjNmYiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3NDI2ODk5NzcsImV4cCI6MTc0MjY5MzU3N30.VbRI-G9XK3m_bep21DdE7sq2rZtW7X_MoNvhsaNLaUk', '2025-03-23 09:32:57', '2025-03-23 08:32:57', '7eddd6ca-b564-4a53-be05-a1db1c962c6f');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('4237b1da-047c-4c16-be6b-f6bca4bda7d5', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI3ZWRkZDZjYS1iNTY0LTRhNTMtYmUwNS1hMWRiMWM5NjJjNmYiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3NDI1MzkwMjMsImV4cCI6MTc0MjU0MjYyM30.BjxzCwxiJILzmkHIySWjoCd0JyxNG5S6uqdLFVGsjIg', '2025-03-21 15:37:04', '2025-03-21 14:37:04', '7eddd6ca-b564-4a53-be05-a1db1c962c6f');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('492c8e63-4d75-4e1d-b83b-a0b92fb86ab5', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiJhYzA5ZGFjNy1lMmU2LTQ0ZDQtODZjOC1mZTYxNDMwMWI0NDEiLCJyb2xlcyI6WyJ0ZXN0Il0sImlhdCI6MTc0MDg0NDA4MiwiZXhwIjoxNzQwODQ1ODgyfQ.7t-MIs_4SwvcN4-Dnl2mPwIxuay8vl6EFGdWYrrHK8I', '2025-03-02 00:18:03', '2025-03-01 23:48:03', 'ac09dac7-e2e6-44d4-86c8-fe614301b441');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('4be47f35-a53f-4688-9cf2-28310b42ccfa', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiJhYzA5ZGFjNy1lMmU2LTQ0ZDQtODZjOC1mZTYxNDMwMWI0NDEiLCJyb2xlcyI6WyJ0ZXN0Il0sImlhdCI6MTc0MDk4NjA5NSwiZXhwIjoxNzQwOTg3ODk1fQ.1eyPEbPJAIbBOLuNe5JHnm0ElX0UK1XjCcJFdKw9BZE', '2025-03-03 15:44:56', '2025-03-03 15:14:56', 'ac09dac7-e2e6-44d4-86c8-fe614301b441');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('5025d60c-69b2-4253-9e88-7acea1137810', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiJhYzA5ZGFjNy1lMmU2LTQ0ZDQtODZjOC1mZTYxNDMwMWI0NDEiLCJyb2xlcyI6WyJ0ZXN0Il0sImlhdCI6MTc0MDg0Mjc2NywiZXhwIjoxNzQwODQ0NTY3fQ.DmygL-OQjPNZ8Bxh9inWMN5hC9TwqMKX_UyF-CuGACA', '2025-03-01 23:56:07', '2025-03-01 23:26:07', 'ac09dac7-e2e6-44d4-86c8-fe614301b441');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('5d50314b-1345-4eb4-af2c-e7755f96d5cf', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiJhYzA5ZGFjNy1lMmU2LTQ0ZDQtODZjOC1mZTYxNDMwMWI0NDEiLCJyb2xlcyI6WyJ0ZXN0Il0sImlhdCI6MTc0MjQzNzA2NywiZXhwIjoxNzQyNTIzNDY3fQ.rfSflqCK4bk80GiHECKqoY-RZlblypQ3a1cUCQFE22c', '2025-03-21 10:17:47', '2025-03-20 10:17:47', 'ac09dac7-e2e6-44d4-86c8-fe614301b441');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('5e986c1b-4f11-4464-9595-3adce81f153f', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI3ZWRkZDZjYS1iNTY0LTRhNTMtYmUwNS1hMWRiMWM5NjJjNmYiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3NDIyMzAyMjksImV4cCI6MTc0MjMxNjYyOX0.OO7Yw41uyVILSYbLw294nqibIMGEQjzGhkWotQ9JbLQ', '2025-03-18 16:50:30', '2025-03-17 16:50:30', '7eddd6ca-b564-4a53-be05-a1db1c962c6f');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('64a1efd7-2bd7-45b6-8476-98cdacc17e39', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI3ZWRkZDZjYS1iNTY0LTRhNTMtYmUwNS1hMWRiMWM5NjJjNmYiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3NDI0NTQ5MTMsImV4cCI6MTc0MjU0MTMxM30.DX122Xk00wsk-VKILtxeEQxbUScJZEC1AAzi0TEJ7Gs', '2025-03-21 15:15:13', '2025-03-20 15:15:13', '7eddd6ca-b564-4a53-be05-a1db1c962c6f');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('64c7dc26-7391-491b-a23f-4870e94ca12b', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI3ZWRkZDZjYS1iNTY0LTRhNTMtYmUwNS1hMWRiMWM5NjJjNmYiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3NDI0OTM4MjUsImV4cCI6MTc0MjQ5NzQyNX0.shmDPTxMR_o5RIDV1eODEATmpU1auBxTZtEnsP1nJQk', '2025-03-21 03:03:45', '2025-03-21 02:03:45', '7eddd6ca-b564-4a53-be05-a1db1c962c6f');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('695707e5-0697-4ecf-9f0f-a6d08194eeda', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI3ZWRkZDZjYS1iNTY0LTRhNTMtYmUwNS1hMWRiMWM5NjJjNmYiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3NDIyNjA1ODQsImV4cCI6MTc0MjM0Njk4NH0.EzD7xPqcFS93qlnHIxiZ875DqbD5Qb1hoyJ3D39QGv4', '2025-03-19 09:16:24', '2025-03-18 09:16:24', '7eddd6ca-b564-4a53-be05-a1db1c962c6f');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('6c717b7e-1d64-4515-b796-537b3a440d58', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI3ZWRkZDZjYS1iNTY0LTRhNTMtYmUwNS1hMWRiMWM5NjJjNmYiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3NDIyMjc1MTQsImV4cCI6MTc0MjIyOTMxNH0.1rB4oRL-FPE3frDWUFb0aa1ezpHxuQIPy-tYkhfLlMM', '2025-03-18 00:35:15', '2025-03-18 00:05:15', '7eddd6ca-b564-4a53-be05-a1db1c962c6f');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('6f7c20a4-1510-4dfe-8fdb-1ced23f00cd8', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiJhYzA5ZGFjNy1lMmU2LTQ0ZDQtODZjOC1mZTYxNDMwMWI0NDEiLCJyb2xlcyI6WyJ0ZXN0Il0sImlhdCI6MTc0MTE5MDk1NywiZXhwIjoxNzQxMTkyNzU3fQ.iOsSjAbUdqH8PQYePNZaYgczVS2z02IzOsDFh_zpGlw', '2025-03-06 00:39:18', '2025-03-06 00:09:18', 'ac09dac7-e2e6-44d4-86c8-fe614301b441');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('704714ee-bf0a-41cd-a49c-4907c4dec0e2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiJhYzA5ZGFjNy1lMmU2LTQ0ZDQtODZjOC1mZTYxNDMwMWI0NDEiLCJyb2xlcyI6WyJ0ZXN0Il0sImlhdCI6MTc0MTUxMDU4NiwiZXhwIjoxNzQxNTEyMzg2fQ.jlARDpPf9g_0sdXM6pEPQA5tmp6jXPluaRQGUClWCK4', '2025-03-09 17:26:26', '2025-03-09 16:56:26', 'ac09dac7-e2e6-44d4-86c8-fe614301b441');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('73cc8e3c-28e2-4044-9e84-9ffb07bed26d', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI3ZWRkZDZjYS1iNTY0LTRhNTMtYmUwNS1hMWRiMWM5NjJjNmYiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3NDI2OTQ3MDgsImV4cCI6MTc0MjY5ODMwOH0.IRWLtkoJ1Zi5-wLLsKvJIkVcBB5vVrtjCLSEP1OWugg', '2025-03-23 10:51:49', '2025-03-23 09:51:49', '7eddd6ca-b564-4a53-be05-a1db1c962c6f');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('7729205a-92f4-45de-8658-d11ecfa5a277', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI3ZWRkZDZjYS1iNTY0LTRhNTMtYmUwNS1hMWRiMWM5NjJjNmYiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3NDI0MzkzMjgsImV4cCI6MTc0MjUyNTcyOH0.VZHb3J8mmiNZetn0mxWdugo25xdekgpaOwUjdFYo76A', '2025-03-21 10:55:29', '2025-03-20 10:55:29', '7eddd6ca-b564-4a53-be05-a1db1c962c6f');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('82664570-fd38-4b18-96c9-837b8ab4fdc1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI3ZWRkZDZjYS1iNTY0LTRhNTMtYmUwNS1hMWRiMWM5NjJjNmYiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3NDIyMzE5NjIsImV4cCI6MTc0MjMxODM2Mn0.Bw0_H9pafofyITsoDYm8oX9kWa9rz9YtHpLF6hSILRo', '2025-03-19 01:19:23', '2025-03-18 01:19:23', '7eddd6ca-b564-4a53-be05-a1db1c962c6f');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('89e4bf8b-2b3d-471a-b97d-3170cb9906c7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiJhYzA5ZGFjNy1lMmU2LTQ0ZDQtODZjOC1mZTYxNDMwMWI0NDEiLCJyb2xlcyI6WyJ0ZXN0Il0sImlhdCI6MTc0MTA5NDIxMiwiZXhwIjoxNzQxMDk2MDEyfQ.63FDuOt6EN1fiHBiqxyksF0I2W-OlL6omloaW2NUjWo', '2025-03-04 21:46:53', '2025-03-04 21:16:53', 'ac09dac7-e2e6-44d4-86c8-fe614301b441');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('9ede44ca-3250-4072-ba9e-89458581dbc9', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI3ZWRkZDZjYS1iNTY0LTRhNTMtYmUwNS1hMWRiMWM5NjJjNmYiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3NDI0NDA3NTcsImV4cCI6MTc0MjUyNzE1N30.UUrDt9hulrYb8Vs_DVHi3qn1BfvN6DnKeFGEHI8G0rE', '2025-03-21 11:19:18', '2025-03-20 11:19:18', '7eddd6ca-b564-4a53-be05-a1db1c962c6f');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('9f2f5bbb-630b-45ce-83ee-aa676f065146', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI3ZWRkZDZjYS1iNTY0LTRhNTMtYmUwNS1hMWRiMWM5NjJjNmYiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3NDIyODgwMzEsImV4cCI6MTc0MjM3NDQzMX0.-Ygc2JZ0aY2zzBAXcJtB-1JB4ly7euHi-etXbt_Zesc', '2025-03-19 16:53:52', '2025-03-18 16:53:52', '7eddd6ca-b564-4a53-be05-a1db1c962c6f');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('a2ffb6e4-715c-4870-9ac7-7c7ba64f7b1d', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI3ZWRkZDZjYS1iNTY0LTRhNTMtYmUwNS1hMWRiMWM5NjJjNmYiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3NDIyNzYyNDgsImV4cCI6MTc0MjM2MjY0OH0.gW8zuwcSvYzuRx5JSyRcwrvldspZi_g8wmSF6b-sCso', '2025-03-19 13:37:29', '2025-03-18 13:37:29', '7eddd6ca-b564-4a53-be05-a1db1c962c6f');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('ac120602-caa0-4d19-a09c-3489e168239c', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiJhYzA5ZGFjNy1lMmU2LTQ0ZDQtODZjOC1mZTYxNDMwMWI0NDEiLCJyb2xlcyI6WyJ0ZXN0Il0sImlhdCI6MTc0MDg0MjYxNywiZXhwIjoxNzQwODQ0NDE3fQ.D-4wPsUiggnCNgoFaJG4Ts2IMK56THkUPHK3dRLuUBI', '2025-03-01 23:53:37', '2025-03-01 23:23:37', 'ac09dac7-e2e6-44d4-86c8-fe614301b441');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('ad3f915d-0fa9-4677-bd10-8bd53e37d3c4', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI3ZWRkZDZjYS1iNTY0LTRhNTMtYmUwNS1hMWRiMWM5NjJjNmYiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3NDI1NzQ5MDUsImV4cCI6MTc0MjU3ODUwNX0.fZPUOCSAwGu2SYuz0lP8kT7DZYoZittSv6B2NSfkACg', '2025-03-22 01:35:05', '2025-03-22 00:35:05', '7eddd6ca-b564-4a53-be05-a1db1c962c6f');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('b530e0a4-ebd3-4198-b172-3dc6bcf7405c', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI3ZWRkZDZjYS1iNTY0LTRhNTMtYmUwNS1hMWRiMWM5NjJjNmYiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3NDIxMzk4MTIsImV4cCI6MTc0MjE0MTYxMn0.AYuRddUe3-9MxjDtLpBR215HycAhxfFTI4Msy8SV2sQ', '2025-03-17 00:13:32', '2025-03-16 23:43:32', '7eddd6ca-b564-4a53-be05-a1db1c962c6f');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('ba04f7df-34db-4b4d-b99e-af887187a4c5', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI3ZWRkZDZjYS1iNTY0LTRhNTMtYmUwNS1hMWRiMWM5NjJjNmYiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3NDIzMTkzMDUsImV4cCI6MTc0MjMyMTEwNX0.J0kaUpRFAO30zDbPDNJtIARlkYfQ4MpYaR0d7FQGSVE', '2025-03-19 02:05:05', '2025-03-19 01:35:05', '7eddd6ca-b564-4a53-be05-a1db1c962c6f');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('bf3f415a-c8c4-44f5-b6db-b806559b2a18', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiJhYzA5ZGFjNy1lMmU2LTQ0ZDQtODZjOC1mZTYxNDMwMWI0NDEiLCJyb2xlcyI6WyJ0ZXN0Il0sImlhdCI6MTc0MTAwOTI5NCwiZXhwIjoxNzQxMDExMDk0fQ.Ga7K0LqYBQOpu1NnFne5k0AIWmaeLlHYMQcIHBrnSZk', '2025-03-03 22:11:35', '2025-03-03 21:41:35', 'ac09dac7-e2e6-44d4-86c8-fe614301b441');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('c4ca68da-bd19-42b0-a3b5-1fec972c5a68', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI3ZWRkZDZjYS1iNTY0LTRhNTMtYmUwNS1hMWRiMWM5NjJjNmYiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3NDI1NTI4ODAsImV4cCI6MTc0MjU1NjQ4MH0.zMONA3bx8A9xpeDVLz2k3jovPEiYa_d0ZloBOU6NIm0', '2025-03-21 19:28:00', '2025-03-21 18:28:00', '7eddd6ca-b564-4a53-be05-a1db1c962c6f');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('c95e13d6-c111-46b9-a145-26c6d976750b', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiJhYzA5ZGFjNy1lMmU2LTQ0ZDQtODZjOC1mZTYxNDMwMWI0NDEiLCJyb2xlcyI6WyJ0ZXN0Il0sImlhdCI6MTc0MDk5MDI4MiwiZXhwIjoxNzQwOTkyMDgyfQ.QBuXBuDzDuGzvSLohVRLzGPLz6-3kSox0HOEy6rR6mY', '2025-03-03 16:54:42', '2025-03-03 16:24:42', 'ac09dac7-e2e6-44d4-86c8-fe614301b441');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('cc5da264-9a3c-4b84-8f9a-03be250fcc19', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI3ZWRkZDZjYS1iNTY0LTRhNTMtYmUwNS1hMWRiMWM5NjJjNmYiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3NDIyNzg4OTgsImV4cCI6MTc0MjM2NTI5OH0.BJdkMlcjKqIqIaLeJhZYltmW4eW2L8DAOdcfPzG-YzY', '2025-03-19 14:21:38', '2025-03-18 14:21:38', '7eddd6ca-b564-4a53-be05-a1db1c962c6f');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('d8529544-9f2c-4e94-964f-e4298cf52667', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiJhYzA5ZGFjNy1lMmU2LTQ0ZDQtODZjOC1mZTYxNDMwMWI0NDEiLCJyb2xlcyI6WyJ0ZXN0Il0sImlhdCI6MTc0MTEwMjgzNywiZXhwIjoxNzQxMTA0NjM3fQ.XbmH9cJzwYeFqtP925-_LTog1hffstM1QSuiGXuW7u0', '2025-03-05 00:10:38', '2025-03-04 23:40:38', 'ac09dac7-e2e6-44d4-86c8-fe614301b441');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('e0e4f847-cdb9-4047-a719-af3e1a19cd9e', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiJhYzA5ZGFjNy1lMmU2LTQ0ZDQtODZjOC1mZTYxNDMwMWI0NDEiLCJyb2xlcyI6WyJ0ZXN0Il0sImlhdCI6MTc0MTg4MDYwMCwiZXhwIjoxNzQxODgyNDAwfQ.K9vRXz7TSzB3upiEV2rrSzFTPnGLjuP8AiMcGwSsYJI', '2025-03-14 00:13:21', '2025-03-13 23:43:21', 'ac09dac7-e2e6-44d4-86c8-fe614301b441');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('e7732ff3-d270-45e9-aafd-37851efe1494', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI3ZWRkZDZjYS1iNTY0LTRhNTMtYmUwNS1hMWRiMWM5NjJjNmYiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3NDIzMDQ1NTQsImV4cCI6MTc0MjM5MDk1NH0.Q1n0KjrtaVab9UbSptZN1AOlhazkP5epm5HPEtKksd0', '2025-03-19 21:29:14', '2025-03-18 21:29:14', '7eddd6ca-b564-4a53-be05-a1db1c962c6f');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('e7ca5cdf-146f-4f38-b611-5ecb3b282441', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI0YzUxYjMyMS1kZWRiLTQxMTAtODI3ZC1jY2JjZDgzYjU4NjciLCJyb2xlcyI6WyJndWVzdCJdLCJpYXQiOjE3NDIyNzUzMTQsImV4cCI6MTc0MjM2MTcxNH0.nuMMFI_r9wB1KeuKXgvQACyjCOu_RMGFHqowOSlZKdw', '2025-03-19 13:21:55', '2025-03-18 13:21:55', '4c51b321-dedb-4110-827d-ccbcd83b5867');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('f6143ab5-5afa-4e90-94b5-dc121f7bcd73', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI0YzUxYjMyMS1kZWRiLTQxMTAtODI3ZC1jY2JjZDgzYjU4NjciLCJyb2xlcyI6WyJndWVzdCJdLCJpYXQiOjE3NDIyMzI5ODYsImV4cCI6MTc0MjMxOTM4Nn0.NqTn053Kyf4GwS9TY4HI5mdQ6EVW2WcVtkXK-cb8kNA', '2025-03-19 01:36:26', '2025-03-18 01:36:26', '4c51b321-dedb-4110-827d-ccbcd83b5867');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('f668c8f2-ca96-4faa-b699-709f905c61a4', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI3ZWRkZDZjYS1iNTY0LTRhNTMtYmUwNS1hMWRiMWM5NjJjNmYiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3NDI0Mzc1MjUsImV4cCI6MTc0MjUyMzkyNX0.4k_3gLfUI-d-XuJdki96AtaR4IoUi_9S787AF4WjKys', '2025-03-21 10:25:25', '2025-03-20 10:25:25', '7eddd6ca-b564-4a53-be05-a1db1c962c6f');
INSERT INTO `user_access_token` (`id`, `value`, `expired_at`, `created_at`, `userId`) VALUES ('f77d561e-bd5e-422e-b7b3-dab27c088e29', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI3ZWRkZDZjYS1iNTY0LTRhNTMtYmUwNS1hMWRiMWM5NjJjNmYiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3NDI0NjI5MzYsImV4cCI6MTc0MjU0OTMzNn0.F-GUMSIAlRUmbGJMUfhjtEXtfHy1rRCwDoPZLHNGybo', '2025-03-21 17:28:56', '2025-03-20 17:28:56', '7eddd6ca-b564-4a53-be05-a1db1c962c6f');
COMMIT;

-- ----------------------------
-- Table structure for user_profile
-- ----------------------------
DROP TABLE IF EXISTS `user_profile`;
CREATE TABLE `user_profile` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `nick_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '昵称',
  `gender` enum('0','1') NOT NULL DEFAULT '1' COMMENT '性别 1 男 0 女',
  `email` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'email',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '手机号',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '头像',
  `signature` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '个人签名',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '地址',
  `birth_date` datetime DEFAULT NULL COMMENT '出生日期',
  `introduction` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '简介',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user_profile
-- ----------------------------
BEGIN;
INSERT INTO `user_profile` (`id`, `created_at`, `updated_at`, `nick_name`, `gender`, `email`, `phone`, `avatar`, `signature`, `address`, `birth_date`, `introduction`) VALUES ('4fa2bd87-7460-453f-be65-76128af9518d', '2025-02-26 14:52:05.341684', '2025-02-26 14:52:05.341684', '游客', '1', 'guest@qq.com', NULL, 'http://myblogimgbucket.oss-cn-beijing.aliyuncs.com/1741512170833-WechatIMG432.jpg', NULL, NULL, NULL, NULL);
INSERT INTO `user_profile` (`id`, `created_at`, `updated_at`, `nick_name`, `gender`, `email`, `phone`, `avatar`, `signature`, `address`, `birth_date`, `introduction`) VALUES ('6463122f-a435-430c-9d69-c7fbddaf0de8', '2025-02-21 17:15:27.107185', '2025-02-21 17:15:27.107185', 'admin', '1', 'admin@qq.com', '', 'https://nest-admin-1308002460.cos.ap-chengdu.myqcloud.com/1742493899162-WechatIMG462.jpg', '落叶的一生 只是为了归根', '中国 成都', '2005-05-06 00:00:00', '三岁学习 Javascript，七岁岁主导编写Javascript高级程序设计第五版，十五岁在塞纳河畔教尤雨溪写Vue，时光荏苒1，往事随风，如果可以重来，我要教Java之父学Python。');
INSERT INTO `user_profile` (`id`, `created_at`, `updated_at`, `nick_name`, `gender`, `email`, `phone`, `avatar`, `signature`, `address`, `birth_date`, `introduction`) VALUES ('a32e725f-7a75-4770-b9d7-c9e15852c028', '2025-02-24 17:27:35.418875', '2025-02-24 17:27:35.418875', '测试', '0', 'test@qq.com', NULL, 'http://myblogimgbucket.oss-cn-beijing.aliyuncs.com/1741512156799-WechatIMG431.jpg', NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for user_refresh_token
-- ----------------------------
DROP TABLE IF EXISTS `user_refresh_token`;
CREATE TABLE `user_refresh_token` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `expired_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `accessTokenId` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `REL_0fb9e76570bb35fd7dd7f78f73` (`accessTokenId`) USING BTREE,
  CONSTRAINT `FK_0fb9e76570bb35fd7dd7f78f73c` FOREIGN KEY (`accessTokenId`) REFERENCES `user_access_token` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user_refresh_token
-- ----------------------------
BEGIN;
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('081047a0-c5fa-4570-bc0f-866ea5bcd7ab', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiM2ZlMDRiOTQtZDljNi00M2ZiLWI5M2QtMjA4YTcyZjg0YWYwIiwiaWF0IjoxNzQwOTI4NzE3LCJleHAiOjE3NDA5MzA1MTd9.57zm_n-upgF02_wueMn147rLGkW82HQkMNAik58a_NE', '2025-03-09 23:18:38', '2025-03-02 23:18:38', '019f4f0e-f2f8-4ec5-80ef-6143d57f3da8');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('0bc17190-4188-4090-9e74-e332cd106d2a', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiOTQzZTllYzgtNThjZC00MGE3LWFmNzItNzgzNzUxN2E1Y2JiIiwiaWF0IjoxNzQyNjk2NjM5LCJleHAiOjE3NDI3ODMwMzl9.fmO8LX_DIn66_jMtLO-ruZy99QT4WIJ4Fhb_45aSalk', '2025-03-30 10:24:00', '2025-03-23 10:24:00', '10b8b92b-cb98-4c81-b33f-1508c0adabe3');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('0d2a16fd-a3a4-45b6-bb20-94527771dd9e', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNDJiODM1NTYtYzJhNS00NDg0LWEwMDctMTNmNmJiYzE1ZDdkIiwiaWF0IjoxNzQxMDk0MjEyLCJleHAiOjE3NDEwOTYwMTJ9.BuKy9zm007QhswPvg907PRY5RniHgAz_PkdVsHE-iK8', '2025-03-11 21:16:53', '2025-03-04 21:16:53', '89e4bf8b-2b3d-471a-b97d-3170cb9906c7');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('0d7b0161-197a-441b-8093-9e18f7714b75', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYzk5N2E5NjctNzg5Mi00MTY1LTgxOGQtNmIyMDVjMWE5NmE1IiwiaWF0IjoxNzQxNTEwNTg2LCJleHAiOjE3NDE1MTIzODZ9.Zq2sy2TjvxQkrxfYtJSA4xdA7tCsrM3BAZ3ewbgLnYU', '2025-03-16 16:56:26', '2025-03-09 16:56:26', '704714ee-bf0a-41cd-a49c-4907c4dec0e2');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('155da815-9dc4-4cae-8086-d9a1572c6405', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiODBkZGMxMDktNDAwYi00ZmI4LWI5NzMtY2ZhYzg2ZmE0NmU5IiwiaWF0IjoxNzQyNDkzNjYxLCJleHAiOjE3NDI0OTcyNjF9.sP7mFAMAeYZfKAh5vrSrQOnYMRSQ0j4OtVFzFTr460Q', '2025-03-28 02:01:02', '2025-03-21 02:01:02', '3c6e60ae-ed6f-4908-8742-7e3d2bac7b3f');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('161082dc-2675-4de7-9e29-a53c4f630668', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZDEyMzA1NjItZmQ3YS00NGRmLWFmYTItZjBmY2ZiY2Y5OTYyIiwiaWF0IjoxNzQxMTAyODM3LCJleHAiOjE3NDExMDQ2Mzd9.U3rZ-ov_9R5yDcL41I7IIqY5Nnfm-XhBqZGzphwjCJE', '2025-03-11 23:40:38', '2025-03-04 23:40:38', 'd8529544-9f2c-4e94-964f-e4298cf52667');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('1a1ddbe8-f6c3-4323-861b-04c3cb433f13', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNTU2MTk1NDktMGE5Yi00ODQyLWI4NWYtMjYzYTZiZWM5NDEwIiwiaWF0IjoxNzQyNTQxODIxLCJleHAiOjE3NDI1NDU0MjF9.aAFM-sjjn4qvYYrvcNZ-SGzgceJAxp1aecL6WBWbOu0', '2025-03-28 15:23:42', '2025-03-21 15:23:42', '17a7367f-931e-4bda-a137-0b43c23ab80b');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('1f27f653-9787-4719-abc6-d0a99627c726', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZWFlZTg1OWItNDMyMS00NGI0LWFiYTMtODJhZWVjMDdmNjI5IiwiaWF0IjoxNzQyMjMxOTYyLCJleHAiOjE3NDIzMTgzNjJ9.xQRVsFLhWZwSx1m4gBUuZHRwgarzE4BQDi__6fKWd6o', '2025-03-18 01:19:23', '2025-03-18 01:19:23', '82664570-fd38-4b18-96c9-837b8ab4fdc1');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('1f35b70e-b41a-41fe-8fc3-a952336a22c2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMGFlMzUxMDMtNDdhYS00MjI1LTlmMDEtZDJmNzQ5ZDM1YmRhIiwiaWF0IjoxNzQyNTM5MDIzLCJleHAiOjE3NDI1NDI2MjN9.trzQG7IzstPE-bx7u2S94RNM4SyxIxc1cBFfdVjfWrs', '2025-03-28 14:37:04', '2025-03-21 14:37:04', '4237b1da-047c-4c16-be6b-f6bca4bda7d5');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('2a493452-9174-4ec0-9f68-9b98aa254516', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZjQ2OWExNjQtMzM2MC00Mjk5LTkyMzAtZjdiYmVjOTEzMjU0IiwiaWF0IjoxNzQwODQyNjE3LCJleHAiOjE3NDA4NDQ0MTd9.CGlKasGIaoRPUdgpkeFOHPUXQZYDKxUh8TNtpkg1cpo', '2025-03-08 23:23:37', '2025-03-01 23:23:37', 'ac120602-caa0-4d19-a09c-3489e168239c');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('2d7718c8-2935-4390-bbdd-b0acd2d152b9', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYWUzNTUwNzEtNGRkMS00YTJiLTgzYzctMzY2NmQ0Y2Q1ZDczIiwiaWF0IjoxNzQyMjc1MzE0LCJleHAiOjE3NDIzNjE3MTR9.0RbT1CJWi1BnlwmVNzQf7LKzhmVsneC-_Yi_BNHEVsA', '2025-03-18 13:21:55', '2025-03-18 13:21:55', 'e7ca5cdf-146f-4f38-b611-5ecb3b282441');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('3992d83b-3ff5-45a4-a62f-72ab15238d2c', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZGNjN2M3N2UtOWRjNy00NWE1LWI1Y2EtMmViZGFhYTZiZTg1IiwiaWF0IjoxNzQyNDM5MzI4LCJleHAiOjE3NDI1MjU3Mjh9.WyTS58al3FVT5IBzGYkEGLK6T2aNMVmdhguJD3US_M4', '2025-03-27 10:55:29', '2025-03-20 10:55:29', '7729205a-92f4-45de-8658-d11ecfa5a277');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('3b191297-a690-42e2-a4de-4e7d366c64f6', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNmZjZjA1MzYtNDY5Zi00Y2JkLWIwN2EtZmQyZjQxODdhNDUxIiwiaWF0IjoxNzQyMTM5ODEyLCJleHAiOjE3NDIxNDE2MTJ9.0ycruqeFk9rNUyUihZC6W55oAw9fvyGRCV_dPW4_T5w', '2025-03-23 23:43:32', '2025-03-16 23:43:32', 'b530e0a4-ebd3-4198-b172-3dc6bcf7405c');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('3f1f4106-447b-49f1-b2a1-a951a72c0098', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMDhmOTUxZDgtMGMxZi00OTA1LTliZjItMTc0YTQwNTMyMjdlIiwiaWF0IjoxNzQyNDM3MDY3LCJleHAiOjE3NDI1MjM0Njd9.NqxmyweygRyF1zdyPqQZ8hcxS5q_WNkoPnqDRUREBdQ', '2025-03-27 10:17:47', '2025-03-20 10:17:47', '5d50314b-1345-4eb4-af2c-e7755f96d5cf');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('410e27ae-4c09-46f4-9285-d0921a122f20', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNTdiYjZmMzEtNjNiYy00ZTJjLTk3YjUtNDJiOTRlZTFlOGFkIiwiaWF0IjoxNzQyMzE5MzA1LCJleHAiOjE3NDIzMjExMDV9.1zrUmEAbkDRz0o73boMouyyIPXQLrZVTGpMIB5rf2m0', '2025-03-26 01:35:05', '2025-03-19 01:35:05', 'ba04f7df-34db-4b4d-b99e-af887187a4c5');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('4138d3a9-df08-4a10-ad84-a920b0863405', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMWM2ZGE5NmMtZjYyNy00NmVhLTg4N2EtOTM0NzZlZWVmNjRhIiwiaWF0IjoxNzQwODQyNDkyLCJleHAiOjE3NDA4NDQyOTJ9.ZX3IBW63RcJTRa4e626h4Ds9ewN6h9DuNOD5ybl39rw', '2025-03-08 23:21:32', '2025-03-01 23:21:32', '2dd5a20c-8be5-49b6-9763-06169e9636ce');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('5146f65e-2f23-4a75-be4f-ea45d1107c1a', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZWExOGFhMGEtMzFlMy00NmRkLTgyZGQtNzJmMmY1ZjA5MmIxIiwiaWF0IjoxNzQyMjMwMjI5LCJleHAiOjE3NDIzMTY2Mjl9.HJ6DEC3lpCmi2yoKnkyafLwO4CTYG436yiP9a1nACeg', '2025-03-17 16:50:30', '2025-03-17 16:50:30', '5e986c1b-4f11-4464-9595-3adce81f153f');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('54b79bfc-644f-4896-a285-ee088c5920cf', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiOGNlZjVjNWEtMDczMC00YmQxLWIxMDQtZmE0M2ZkOTFiOTU2IiwiaWF0IjoxNzQyMjc1MDU4LCJleHAiOjE3NDIzNjE0NTh9.invQLJIDBkmGGESklDfmsa-ovCL0AR5AOG-OE1qJiuo', '2025-03-18 13:17:39', '2025-03-18 13:17:39', '053bb242-6b73-4173-9358-98c6275e1ec9');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('555caeb7-4a8e-4b44-b12f-07e5b0daca5c', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZGRkZDFkMWYtYWVkZC00NmMyLTg5MjYtM2VjYmM3MjMyMjZlIiwiaWF0IjoxNzQyNDkzODI1LCJleHAiOjE3NDI0OTc0MjV9.lxsoPYxfCiW7C6KzuQUxyI9AiPPSJt9cm9-oD7d3Ckk', '2025-03-28 02:03:45', '2025-03-21 02:03:45', '64c7dc26-7391-491b-a23f-4870e94ca12b');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('5b9c1295-1188-4a62-9cb5-0a4e429b124f', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNTJiNTk1Y2EtOTE3Mi00MGE4LWJkOTQtM2JlNTYxNTNmOGUxIiwiaWF0IjoxNzQyNTc0OTA1LCJleHAiOjE3NDI1Nzg1MDV9.XzdmgMFOmXdbgZkcpID9GzamHTIKygBdIO3qDJC_6eU', '2025-03-29 00:35:05', '2025-03-22 00:35:05', 'ad3f915d-0fa9-4677-bd10-8bd53e37d3c4');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('5cc56e3f-cda8-4a78-b5a0-81c4a3f21ec6', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMjMwNTBjOTQtMDM3NC00M2E4LTk5NzMtYjY5MGM2ZmFhZDgwIiwiaWF0IjoxNzQyMjY5NjgyLCJleHAiOjE3NDIzNTYwODJ9.Azkck7sShAgCL2PA2A0L1YwLNPH3r6WIzeFbcn-hKXA', '2025-03-18 11:48:03', '2025-03-18 11:48:03', '36b939a7-f9d4-4aa9-8a92-de4a5f03b1ca');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('63be98d9-b00d-497a-b08a-806e1c92122c', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMzdlMmJjOTEtZWE4Zi00N2E5LTk2ZDktYmE3N2VmMjNlNmI1IiwiaWF0IjoxNzQyMjg4MDMxLCJleHAiOjE3NDIzNzQ0MzF9.VelQe1uP_o3zvtZJpSvx0slxghpvlhLjP5qpGugbLpY', '2025-03-18 16:53:52', '2025-03-18 16:53:52', '9f2f5bbb-630b-45ce-83ee-aa676f065146');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('6619d72f-2f58-49cc-bdfa-b1b0f665c88e', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiODBjNjhiMWItMWM5Mi00YThkLTlhZmYtMDhiNDg3MGUyZGI3IiwiaWF0IjoxNzQyNTUyODgwLCJleHAiOjE3NDI1NTY0ODB9.iqjSrsKlJbT32gAjcDfgnAxp0CMiNdlHBDC0b_rP83s', '2025-03-28 18:28:00', '2025-03-21 18:28:00', 'c4ca68da-bd19-42b0-a3b5-1fec972c5a68');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('6688b826-20ff-4380-acc3-adcc8e6399e2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZmYzODA3ZTUtYTY5NC00NDQ4LWExOTAtNzI1MTZjNjYwNzIyIiwiaWF0IjoxNzQwODQ0MDgyLCJleHAiOjE3NDA4NDU4ODJ9.k2ZsqpdigI4AuUdQR2ZrdwnD6yKf8_m6DE15GCMq9BQ', '2025-03-08 23:48:03', '2025-03-01 23:48:03', '492c8e63-4d75-4e1d-b83b-a0b92fb86ab5');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('6ac63574-d684-4698-bb1b-dcc33efc8d54', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiOTQ0YjQ3ZmUtNTJlOC00ZGQ5LWJjYzYtM2QxNjE0MTNjM2NkIiwiaWF0IjoxNzQxMTkwOTU3LCJleHAiOjE3NDExOTI3NTd9.9CpJ0w3lO1jwn9QAHxTby4QBILBXcNVbLmirXIk-SRs', '2025-03-13 00:09:18', '2025-03-06 00:09:18', '6f7c20a4-1510-4dfe-8fdb-1ced23f00cd8');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('707794d4-7e9b-4d7e-8130-0cd9ec4f827a', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNDUwMmQ4MzgtMWQ1Zi00YmJmLWJmNGUtNzE4ZGZkMGYzYTA0IiwiaWF0IjoxNzQyMjYwNTg0LCJleHAiOjE3NDIzNDY5ODR9.piJwr11kUtTolDh0gQSVDqSQQvA08t8ja3XccpQL5tI', '2025-03-18 09:16:24', '2025-03-18 09:16:24', '695707e5-0697-4ecf-9f0f-a6d08194eeda');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('752e2ca2-2498-493a-a6f9-455ef508ff77', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNmM5ODBjODktNmQ4ZC00NDZjLWIzNWItOWE4OWE0NDczNjA3IiwiaWF0IjoxNzQyNDQwNzU3LCJleHAiOjE3NDI1MjcxNTd9.QIwfz6WHimGpx6kboSmlh2crmaJ7YPJcOC6MTSQFxjA', '2025-03-27 11:19:18', '2025-03-20 11:19:18', '9ede44ca-3250-4072-ba9e-89458581dbc9');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('7578f34d-afd9-439d-bcf7-181156626d22', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMGZhMzc4YzYtMmUxOS00ZjFiLWEwZjYtNDZhNzA4NDBlMGYxIiwiaWF0IjoxNzQyNDUwODQ3LCJleHAiOjE3NDI1MzcyNDd9.zTWD7fF6T_gZv_wG8V6L8dZkoAd7tD0SerKxtkDrdEg', '2025-03-27 14:07:27', '2025-03-20 14:07:27', '100a798f-99e4-47b1-afb5-c69c0fa8f3f6');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('816e6b80-e4fc-4255-989b-315925a62a47', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYzY1OWVkN2EtZjU4NS00MzFiLTllZWEtYTUzNmM4YjYxMzFmIiwiaWF0IjoxNzQxODgwNjAwLCJleHAiOjE3NDE4ODI0MDB9.hh3jFem1BKOC3AYeRyDNOTJqstoylDnyfS9FNnod3wQ', '2025-03-20 23:43:21', '2025-03-13 23:43:21', 'e0e4f847-cdb9-4047-a719-af3e1a19cd9e');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('833e52ec-5c73-48fb-a624-23dc1d531f5e', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYjE4NzQ0MTktYWM1Yy00ZmQxLWJlMDgtZWQ0MzA2MDJkYzI1IiwiaWF0IjoxNzQyNDU4ODg0LCJleHAiOjE3NDI1NDUyODR9.yYjzenCBr_IEibYgiroosmBqNsY8vgLTx4t-X561_HY', '2025-03-27 16:21:24', '2025-03-20 16:21:24', '0dd0cd40-96e7-40a6-97f1-b6f58d7836bc');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('833fcb58-3b7e-4219-8ce3-16cef2e7702c', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZDQ0NDkyOTMtYjQ5ZC00M2E3LWFiMDYtZGRmOTA4NDg5OGU5IiwiaWF0IjoxNzQyMjkwOTQ0LCJleHAiOjE3NDIzNzczNDR9.tlyNYdvI3OGTyu39_6QNz3rm9aUdF9zb10yiLCf8a8A', '2025-03-18 17:42:25', '2025-03-18 17:42:25', '07d25aa2-35b3-469c-b10a-f13c1cc99844');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('841d8e11-0f14-4729-9e5a-f11e48ca5874', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMmQzOGIzMGYtMWUyOC00MDY5LWI4ODAtYTJmMzcxZmY4MjIzIiwiaWF0IjoxNzQyNTIwMTUxLCJleHAiOjE3NDI1MjM3NTF9.P9hK_ZoSgW-HJYVaa6yH_tNx-mLojp6ort3bSKVhgQc', '2025-03-28 09:22:31', '2025-03-21 09:22:31', '3236100e-069b-4f21-897a-e61cf3ff2014');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('8f2b501e-1730-4f45-afd0-a41b8ec30a8c', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYWZhZjhlZDYtMjdiYS00NGFmLThjNGQtNTdmNWZkYjM4MTUzIiwiaWF0IjoxNzQyMjY5NzUyLCJleHAiOjE3NDIzNTYxNTJ9.LdEFEnS7lNRWV5Pj7QZIo9aS9NXq2k7AVtPgiNgmdzU', '2025-03-18 11:49:12', '2025-03-18 11:49:12', '0583e358-12df-4d48-8ab3-c440ce82868d');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('a004c831-f457-4776-9a77-6f928a9ac446', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMGIyY2M0ZDctMmI2MC00YTE1LWFkMTQtY2JkOThkZDA1N2Y1IiwiaWF0IjoxNzQyMjc2MjQ4LCJleHAiOjE3NDIzNjI2NDh9.2bme81LIeS7EG-Ml6jfwsmqTxEa3jYoG8dh-kv4uQfQ', '2025-03-18 13:37:29', '2025-03-18 13:37:29', 'a2ffb6e4-715c-4870-9ac7-7c7ba64f7b1d');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('ac23fe28-ead2-4cdf-8a5f-6af2925fdf93', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNjNjMjZkNDMtODVlNC00MGY5LTk0YWQtZjgxMDVkMzYzOWU2IiwiaWF0IjoxNzQyNDM3NTI1LCJleHAiOjE3NDI1MjM5MjV9.LNcOpJ8SbTGEHV1tiey40tGXJjR3t3UTngN7rh9N6XA', '2025-03-27 10:25:25', '2025-03-20 10:25:25', 'f668c8f2-ca96-4faa-b699-709f905c61a4');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('b235941c-f44c-45e3-8eea-46fb963ea216', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNzhjYjQzOTMtYmJjYS00NTg4LWI0YjQtYzg3MzBmOGFkNWMzIiwiaWF0IjoxNzQwOTkwMjgyLCJleHAiOjE3NDA5OTIwODJ9.LjzKWlTMvDhFAsUp0JG5Pc1PCTNLWzqq1tO9gVsr_i0', '2025-03-10 16:24:42', '2025-03-03 16:24:42', 'c95e13d6-c111-46b9-a145-26c6d976750b');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('b746ebd4-a227-4f27-ab69-d8786ff4b8b0', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiY2FjNTUzNzYtYmZiMS00ZDVhLTllOWEtNzFlOTNiNTE0YzI5IiwiaWF0IjoxNzQyMjMyOTg2LCJleHAiOjE3NDIzMTkzODZ9.E_FSwh8glStNv5UGKGiO-52Vtt-XUD3sC_49V6uKsYE', '2025-03-18 01:36:26', '2025-03-18 01:36:26', 'f6143ab5-5afa-4e90-94b5-dc121f7bcd73');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('b90a6497-cd5f-4490-8b3a-265926e5ef76', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMjBhOTJmYWUtMWEwYi00ODBhLTlkZDktYjc0MDFjNDNlYmFmIiwiaWF0IjoxNzQwOTg2MDk1LCJleHAiOjE3NDA5ODc4OTV9.-MSYLETCvJe-YlIsaFOvc9eqGSyG6En1DUA38jy6Y_k', '2025-03-10 15:14:56', '2025-03-03 15:14:56', '4be47f35-a53f-4688-9cf2-28310b42ccfa');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('c0e858a5-4d76-4cf6-9f80-6e90f7252def', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZTBhZTI0MTItMjgxMi00NzQ5LWE4MjQtYWFjNjUyNTU1MjA3IiwiaWF0IjoxNzQyNDU0OTEzLCJleHAiOjE3NDI1NDEzMTN9.GvH08aZ-6r47w2aFbIYzeCEp9nU26r8_Qfun_7ItOII', '2025-03-27 15:15:13', '2025-03-20 15:15:13', '64a1efd7-2bd7-45b6-8476-98cdacc17e39');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('c48ff666-173f-479e-a80a-695b845ecbd7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMTg1ZGNkZmUtOWE5Zi00NmMyLWIwMjMtYTMyODUxNjEyZjgzIiwiaWF0IjoxNzQyMjI3NTE0LCJleHAiOjE3NDIyMjkzMTR9.IvxA1LzIOIVzVmodN8mviAPF3t-C5QT28UpAcojPN34', '2025-03-25 00:05:15', '2025-03-18 00:05:15', '6c717b7e-1d64-4515-b796-537b3a440d58');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('c833ede1-67eb-4e70-a688-f945d7faea23', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNDIzYWQ1YjEtMmRkMS00NTkxLTgwNTctYTk4YjQxMzNlMTk5IiwiaWF0IjoxNzQyMjc4ODk4LCJleHAiOjE3NDIzNjUyOTh9.AJhEajHcYp3sylEcstd_RNNSO6UCIFQ6drnXg20QPek', '2025-03-18 14:21:38', '2025-03-18 14:21:38', 'cc5da264-9a3c-4b84-8f9a-03be250fcc19');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('c9f4bedc-1df4-47fa-91e4-af77a4fa89de', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNDQzNzg1ZGMtZTE1MS00NDYxLWJhMTgtYzZiOGFmZGViZmI2IiwiaWF0IjoxNzQyMzA0NTU0LCJleHAiOjE3NDIzOTA5NTR9.o5DGxeWyFdt_riHTLaZYUgmhSvsTGetFG3qPSl6Y-3g', '2025-03-18 21:29:14', '2025-03-18 21:29:14', 'e7732ff3-d270-45e9-aafd-37851efe1494');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('cb368734-95f1-40b1-8287-aebeef01c1ed', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiZTQxM2NiNDQtNzBhMC00OGM2LTk3ZWEtMzdhYjc4ODUwYTc3IiwiaWF0IjoxNzQyNDYyOTM2LCJleHAiOjE3NDI1NDkzMzZ9.ZcEx9TmIPC2qnbeExvmriSe8Ry9rnv0Bzl6nF0kK2Oo', '2025-03-27 17:28:56', '2025-03-20 17:28:56', 'f77d561e-bd5e-422e-b7b3-dab27c088e29');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('cc845681-b7b5-459a-976e-563c7fb0ec09', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNWQ5MWNiMDktODJhYi00ZjFiLTkzNzktZDFhY2MyNjMxNGMzIiwiaWF0IjoxNzQxMDA5Mjk0LCJleHAiOjE3NDEwMTEwOTR9.zfwVApmVXWzcjXlLfDHWkt1IYq8zVySUwCWPQi1Lxfs', '2025-03-10 21:41:35', '2025-03-03 21:41:35', 'bf3f415a-c8c4-44f5-b6db-b806559b2a18');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('d59a6210-0389-4269-ba61-eb86a4988046', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiYzI4ZDBjZDQtNjYwMS00M2QxLWJlMDQtZDU5MmYyNjdmNzc2IiwiaWF0IjoxNzQyMDk0MjY0LCJleHAiOjE3NDIwOTYwNjR9.9B1eaOHbRElrzLavdNgeKgGy946t2ovzBOmXQk1p5qo', '2025-03-23 11:04:25', '2025-03-16 11:04:25', '1e651335-38b7-41a5-bace-3607c249c37f');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('da22a96e-e73c-4f79-9000-2283d10fbc5d', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiNTVhYmJlZGMtMjMzMC00MGE0LWI4MjAtMzA0MDNhYjk5NTI5IiwiaWF0IjoxNzQyNjg5OTc3LCJleHAiOjE3NDI2OTM1Nzd9.Fve1KQccTBjMFObXpfuIzGpmlN4M5L_61Ga8Pd0WvmQ', '2025-03-30 08:32:57', '2025-03-23 08:32:57', '3ff802cd-cae9-4344-91eb-d84de025d796');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('dff08058-ba90-4e1f-bc0d-ce7921adad2c', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiY2ZmZmY3N2QtN2IzOS00MTY2LWFlZjUtMjNmMmQ5MzIxNTVkIiwiaWF0IjoxNzQyMjc0NjI4LCJleHAiOjE3NDIzNjEwMjh9.7Tf1GYStKltJQLQhx052rW3tg4gghktCc7xFlqDUhBc', '2025-03-18 13:10:28', '2025-03-18 13:10:28', '2362a089-eba7-4692-bca2-1f5cf424b821');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('e7a08953-1e44-4bb8-9cad-57ed7e947154', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMGE4Y2M2ZjMtZjVmMy00NTdhLWEzMTMtZWI3MDdhMzdjMWJlIiwiaWF0IjoxNzQwODQyNzY3LCJleHAiOjE3NDA4NDQ1Njd9.p3ZPjzzEKBaTPmCxxhZ8g5oO43qf6sktlJr6M1UsRSs', '2025-03-08 23:26:07', '2025-03-01 23:26:07', '5025d60c-69b2-4253-9e88-7acea1137810');
INSERT INTO `user_refresh_token` (`id`, `value`, `expired_at`, `created_at`, `accessTokenId`) VALUES ('fc402c69-17fb-4a54-bb35-2ced4f763e51', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiN2RiODViYjctN2UwNy00OWNjLThhMGMtMDAwOGYwMDc5Y2ViIiwiaWF0IjoxNzQyNjk0NzA4LCJleHAiOjE3NDI2OTgzMDh9.Sc4c8cqPEVDe5-P9gbd5cTIA-n1XZHI2mxM4an_RqXY', '2025-03-30 09:51:49', '2025-03-23 09:51:49', '73cc8e3c-28e2-4044-9e84-9ffb07bed26d');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
