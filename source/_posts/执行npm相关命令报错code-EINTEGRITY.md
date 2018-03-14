---
title: 执行npm相关命令报错code EINTEGRITY
date: 2018-02-09 12:06:33
tags: npm
---

##### 问题：执行npm 相关命令如`npm install`，报错如下:

```shell
npm ERR! code EINTEGRITY
npm ERR! sha512-mt839mCsI5hzdBJLf1iRBwt610P35iUfvqLVuL7VFdanUwRBAmGtbsjdGIuzegplR95xx+fTHE0vBMuMJp1sLQ== integrity checksum failed when using sha512: wanted sha512-mt839mCsI5hzdBJLf1iRBwt610P35iUfvqLVuL7VFdanUwRBAmGtbsjdGIuzegplR95xx+fTHE0vBMuMJp1sLQ== but got sha512-vUaMcWXgbeV/ouYWjwDSL5JV7u6Kp397xRShl7o2a0nVQrmA1Re2o3whi/juhn3PTfzV4aIxRlMBEcqZt0TKTg==.
```

##### 解决办法执行如下命令中的一条，总有一条管用，我这次是第3条命令修复了问题。

```shell
npm cache verify
npm cache clean
npm cache clean --force
npm install npm@latest -g
npm i -g npm
```

---

参考

[官方文档](https://www.npmjs.com/get-npm)

[npm ERR! code EINTEGRITY 解决方案](https://www.jianshu.com/p/2899bd2a0a20)