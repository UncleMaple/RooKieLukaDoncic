### bug修复

* 登录后跳转问题修复，原因是request_url抓取当前页面url有的不准确（比如抓到了一个头像的请求链接），影响一小部分用户，大多数用户会直接跳到用户首页
* 登录模块优化，参考`devise` gem 包拆分登录的逻辑
* 考虑增加**微信号登录**、**手机号登录**为单机部署做准备支持外部用户
* **Issue** [按照组织的方式导入到成员方式的用户权限调整](https://gitcode.net/codechina_dev/schedule/-/issues/34)

### gitcode docker化

* 搭建两台主机做测试环境、两台可以互相通信模拟内网环境
* 调整我们的代码支持omnibus_gitlab的编译，目前我们的登录只能部署在内网环境才可以支持登录账号。
* gitaly、workhorse、gitlab-shell、praefact等模块在打包时会重新拉去代码，现在已经在gitcode做了本地化 【https://gitcode.net/gitcode-dev/】
* [OmnibusGitlab](https://gitlab.com/gitlab-org/omnibus-gitlab) 是打包我们代码的工具
* 需要调整 `.custom_sources.yml` 指向gitcode各个模块的代码仓库，调整gitlab.yml.example的配置参数
* omnibus gitlab运行时需要启动docker环境，在ubuntu docker container里打包，当前由于我们没有跟进gitlab最新版本、导致有些过期的包获取编译不通过的原因失败，还在解决中。

### 个人建议

* 增加代码review，提高代码的可维护性，这样大家既能够互相学习，也能够及时纠错。
* 我们想要跟进gitlab最新版本、现在最大的问题是前端代码修改过多（定制了我们自己的UI），不好调整。需要寻求一个技术方案来调整这块，无论对以后的项目维护还是docker化都有好处。问题是需要时间进行技术调研和前端代码拆分的人力资源。
* 可以搞一个每周分享会，各个岗位的同学分享技术或者工具的使用心得，增加交流。