---
title: Nexus私服相关
date: 2018-02-25 23:05:17
tags:
---



> 本篇文章只写一些个人认为值得注意的地方，一定要***自己动手***做一边。
>
> [这篇写的比较全，可以先看](https://www.jianshu.com/p/e4a3ab0298df)
>
> [书：Maven实战第九章]()

##### 一、安装Nexus私服

我这是在Mac上安装的，版本不是最新的，最新移步 [**官网**](https://www.sonatype.com/download-oss-sonatype)。[详细的安装介绍](https://www.jianshu.com/p/e4a3ab0298df)。

> brew install nexus

等了20分钟，终于安装完成了，这些命令放在看得见的地方备用。

> nexus start : 启动
>
> nexus status : 状态
>
> nexus stop : 停止
>
> nexus restart : 重启
>
> 访问：localhost:8081/nexus
>
> 用户名/密码：admin/admin123

##### 二、什么是私服？私服各种仓库的作用是什么？

- 私服，就是架在你的PC和远程仓库之间的“中转站”。相当于一个不赚差价的中间商。

- 私服仓库种类和作用

  - `hosted`的宿主仓库

    > 主要部署无法从公共仓库获取的构件（如 oracle 的 JDBC 驱动）以及自己或第三方的项目构件

  - `proxy`的代理仓库

    > 代理公共的远程仓库，如[Central Repository](http://central.maven.org/maven2/)

  - `virtual`的虚拟仓库

    > 适配Maven1转换格式的，可以忽略

  - `group`的**仓库组**

    > 为了统一管理多个仓库用。本身不是库，是上面其他库的一个聚合，要构建只需向仓库组要就可以了，方便管理的特点正好吻合其概念。

##### 三、要想用私服，在项目`pom`怎么写？不改`pom`，如何全局生效使用私服？

> 这里所说的都是针对自己PC上Maven如何配置修改的。

- 加入下面依赖，即可在这个项目中使用私服，换一个项目就不行了。

  ```xml
  <repositories>
      <repository>
          <id>nexus</id>
          <name>Nexus</name>
          <url>http://localhost:8081/nexus/content/groups/public/</url>
          <releases><enabled>true</enabled></releases>
          <snapshots><enabled>true</enabled></snapshots>
      </repository>
  </repositories>
  <pluginRepositories>
      <pluginRepository>
          <id>nexus</id>
          <name>Nexus</name>
          <url>http://localhost:8081/nexus/content/groups/public/</url>
          <releases><enabled>true</enabled></releases>
          <snapshots><enabled>true</enabled></snapshots>
      </pluginRepository>
  </pluginRepositories>
  ```



- 私服全局生效，要修改`idea`中配置的`Maven`的`settings.xml`

  - 配置私服的镜像以使得依赖都走私服获取，配置`profile`目的是开启对构件发布版的支持。其中`profile`中的`url`标签已经没用了，因为请求都走`mirror`中的`url`了。到此已经可以走私服获取依赖啦。

    ```xml
     
      <mirrors>   
         <mirror>
          <id>nexus</id>
          <mirrorOf>*</mirrorOf>
          <name>for nexus </name>
          <url>http://localhost:8081/nexus/content/groups/public/</url>
         </mirror>
      </mirrors>
       <profile>
          <id>nexus</id>
          <repositories>
            <repository>
              <id>central</id>
              <name>central</name>
              <url>http://central</url>
              <releases><enabled>true</enabled></releases>
              <snapshots><enabled>true</enabled></snapshots>
            </repository>
          </repositories>
          <pluginRepositories>
            <pluginRepository>
                <id>central</id>
                <name>central</name>
                <url>http://central</url>
                <releases><enabled>true</enabled></releases>
                <snapshots><enabled>true</enabled></snapshots>
            </pluginRepository>
        </pluginRepositories>
        </profile>
      </profiles>
      <activeProfiles>
        <activeProfile>nexus</activeProfile>
      </activeProfiles>
    ```

##### 四、本地如何发布构建到私服呢？

- 首先，发布构建到私服需要认证，那么就需要在`settings.xml`中加认证信息。

  ```xml
   <servers>  
     <server>
        <id>releases</id>
        <username>admin</username>
        <password>admin123</password>
      </server>
      <server>
        <id>snapshots</id>
        <username>admin</username>
        <password>admin123</password>
      </server>
    </servers>
  ```

  ​


- 其次，需要在你项目`pom`中加配置。**注意**：下面pom中的2个`repository.id`与上面`settings.xml`中的2个`server.id`要一致。

  ```xml
      <distributionManagement>
          <repository>
              <id>releases</id>
              <url>http://localhost:8081/nexus/content/repositories/releases</url>
          </repository>
          <snapshotRepository>
              <id>snapshots</id>
              <url>http://localhost:8081/nexus/content/repositories/snapshots</url>
          </snapshotRepository>
      </distributionManagement>
  ```



- 一条测试命令

  > ```
  > curl -u username:password http://url/artifactory/libs-snapshot-local/com/myproject/api/1.0-SNAPSHOT/api-1.0-20160128.114425-1.jar --request PUT --data target/api-1.0-SNAPSHOT.jar 
  > ```

##### 五、关于idea中`Maven Projects`下面的`Lifecycle的deploy`、`Plugins的deploy`、`mvn clean deploy`的区别

如果idea中Maven配置文件`settings.xml`与PC安装的Maven的`settings.xml`一致，那么`Lifecycle`的`deploy`与`mvn clean deploy`行为一致，否则会有一个报`Return code is 401…`，即未认证，[这儿是错误详情](http://blog.csdn.net/happyteafriends/article/details/8174110)。`Plugins`下面的都是单独的`Goal`，一次只执行一个`Goal`。其它2个是执行的生命周期的一个或多个阶段。



---

参考：

[关于生命周期、命令行和插件](https://my.oschina.net/mzdbxqh/blog/849040)

[Maven 生命周期](https://www.jianshu.com/p/fd43b3d0fdb0)