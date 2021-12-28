---
title: "Gitlab EE Module Prepend Flow"
excerpt: "Gitlab EE 模块加载机制的技术调研."
---

<!-- # Gitlab EE Module Prepend Flow -->

gitlab 现在使用`ApplicationController.prepend_mod`加载ee模块

在运行初始化时加载ee模块的代码: `config/initializers/0_inject_enterprise_edition_module.rb`

ee目录下有单独的子目录：
```shell
ee/app/controllers/foos_controller.rb
ee/app/finders/foos_finder.rb
ee/app/helpers/foos_helper.rb
ee/app/mailers/foos_mailer.rb
ee/app/models/foo.rb
ee/app/policies/foo_policy.rb
ee/app/serializers/foo_entity.rb
ee/app/serializers/foo_serializer.rb
ee/app/services/foo/create_service.rb
ee/app/validators/foo_attr_validator.rb
ee/app/workers/foo_worker.rb
ee/app/views/foo.html.haml
ee/app/views/foo/_bar.html.haml
```
<figure>
  <img src="{{ '/assets/images/ee-module.png' | relative_url }}" alt="ee-module-pic">
</figure>

对应的`controller`、`model`、`view`代码都可以复写

db文件夹下有ee专属的`数据库migration`改动

_Q：Geo模块的作用?_

这种方式能起作用是因为它在ce版本的`eager-load/auto-load`路径中有配置，可以在[config/application.rb.](https://gitlab.com/gitlab-org/gitlab/-/blob/925d3d4ebc7a2c72964ce97623ae41b8af12538d/config/application.rb#L42-52)

<figure>
  <img src="{{ '/assets/images/eager-load.png' | relative_url }}" alt="eager-load">
</figure>
