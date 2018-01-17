---
title: springboot_whitelabel Error
date: 2018-01-17 13:32:18
tags: Spring,Spring Boot
---

**浏览器错误信息**

```
Whitelabel Error Page
This application has no explicit mapping for /error, so you are seeing this as a fallback.

Wed Jan 17 13:24:22 CST 2018
There was an unexpected error (type=Not Found, status=404).
No message available
```

我这出现这个错误的原因是`WeController`类所在的包名也叫`controller`，导致`SpringBoot`识别不了。

---

其他出现此错误的情况，解决办法如下

[from stackoverflow](https://stackoverflow.com/questions/31134333/this-application-has-no-explicit-mapping-for-error)

