export enum ErrorEnum {
  SERVER_ERROR = '500:服务繁忙，请稍后再试',

  // auth
  LOGIN_FIRST = '1000:请先登录',
  AUTH_R_TOKEN_INVALID = '1000:refreshToken已过期',
  AUTH_INVALID_LOGIN = '1000:登录信息已失效，请重新登录',
  AUTH_TOKEN_INVALID = '1001:accessToken已过期',
  AUTH_NO_PERMISSION = '1002:您没有权限',
  AUTH_DEMO_NO_OPERATE = '1002:非常抱歉，当前无法进行修改操作',
  AUTH_NOT_ALLOWED_TO_LOGOUT_USER = '1003:不允许下线该用户',
  AUTH_NOT_ALLOWED_TO_LOGOUT_ADMIN = '1004:不允许下线管理员',
  AUTH_CAPTCHA_ERROR = '1005:验证码错误',
  AUTH_MAXIMUM_FIVE_VERIFICATION_CODES_PER_DAY = '1006:一天最多发送5条验证码',
  AUTH_VERIFICATION_CODE_SEND_FAILED = '1007:验证码发送失败',

  // user
  USER_NOT_EXIST = '2000:用户不存在',
  USER_EXIST = '2001:用户已存在',
  USER_NAME_OR_PASSWORD_ERROR = '2002:用户名或密码错误',
  USER_PASSWORD_NOT_MATCH = '2003:两次密码不一致',
  USER_BANNED = '2004:用户已被禁用',
  USER_PASSWORD_ERROR = '2005:原密码不匹配',
  USER_EMAIL_EXIST = '2006:邮箱已被注册',
  USER_USERNAME_EXIST = '2007:用户名已存在',
  USER_NOT_ALLOWED_TO_DISABLE_ADMIN = '2008:不允许禁用管理员',
  USER_FORCED_OFFLINE = '2009:您被强制下线 请十分钟后再登录',
  USER_PASSWORD_ERROR_RULE = '2010:密码格式不正确，6-18位字符，包含字母、数字、特殊字符',

  // dept
  DEPT_EXIST = '3000:部门已存在',
  DEPT_NOT_EXIST = '3001:部门不存在',
  DEPT_USED_BY_USER = '3002:部门存在关联用户，请先解除关联用户再重试',
  DEPT_USED_BY_CHILD = '3003:部门存在子部门，请先解除子部门再重试',

  // menu
  MENU_EXIST = '4000:菜单或权限已存在',
  MENU_PERMISSION_REQUIRE_PARENT = '4001:该节点父级菜单不能为空',
  MENU_REQUIRE_PARENT = '4002:没有找到该节点父级菜单',
  MENU_REQUIRE_DIR_PARENT = '4003:该节点仅支持目录类型父节点',
  MENU_PERMISSION_NOT_VALID_PARENT = '4004:权限类型节点下无法添加子节点',
  MENU_USED_BY_ROLE = '4005:菜单存在关联角色，请先解除关联角色再重试',

  // ROLE
  ROLE_EXIST = '5000:角色已存在',
  ROLE_NOT_EXIST = '5001:角色不存在',
  ROLE_USED_BY_USER = '5002:角色存在关联用户，请先解除关联用户再重试',
  ROLE_USED_BY_MENU = '5003:角色存在关联菜单，请先解除关联菜单再重试',
  ROLE_USED_BY_DEPT = '5004:角色存在关联部门，请先解除关联部门',
  ROLE_IS_DEFAULT = '5005:角色为默认角色，不允许删除',

  // UPLOAD
  UPLOAD_FAIL = '6000:文件上传失败',

  // VERIFICATION CODE
  VERIFICATION_CODE_ERROR = '7000:验证码错误',
  VERIFICATION_CODE_SEND_FAIL = '7001:验证码发送失败',
  VERIFICATION_CODE_SEND_LIMIT = '7002:验证码发送次数已达上限',
  VERIFICATION_CODE_USED = '7002:验证码不存在或已过期，请重新发送',

  // LIMIT
  TOO_MANY_REQUESTS = '8001:请求频率过快，请一分钟后再试',

  // TASK
  TASK_INSECURE_MISSION = '9001:不安全的任务，确保执行的加入@Mission注解',
  TASK_EXECUTED_MISSION_NOT_FOUND = '9002:所执行的任务不存在',
  TASK_MISSION_EXECUTION_FAILED = '9003:任务执行失败',
  TASK_MISSION_NOT_FOUND = '9004:任务不存在',

  // Dict
  DICT_TYPE_NOT_FOUND = '10001:字典类型不存在',
  DICT_TYPE_HAS_CHILDREN = '10002:该字典类型下有字典项，请先删除字典项再重试',
  DICT_ITEM_EXIST = '10003:该字典项的值已存在，请修改后重试',

  // Sql
  SQL_EXPORT_FAIL = '11000:sql导出失败',
  SQL_IMPORT_FAIL = '11001:sql导入失败',
  SQL_DOWNLOAD_FAIL = '11002:sql下载失败',
  SQL_NOT_FOUND = '11003:请上传sql文件',
}
