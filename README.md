# standalone-jetty-hello-world
hello world servlet web app runing in standalone jetty 9 with java 8

## 1. standalone jetty setup

### 1.1 download jetty 9.x

https://www.eclipse.org/jetty/download.php

choose latest jetty 9.x version, it is `9.4.46.v20220331` now.

donwload and unzip to anywhere and set it as JETTY_HOME.

```shell
mkdir -p ~/workspace/jetty/
cd ~/workspace/jetty/
wget https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/9.4.46.v20220331/jetty-distribution-9.4.46.v20220331.zip
unzip jetty-distribution-9.4.46.v20220331.zip
export JETTY_HOME=~/workspace/jetty/jetty-distribution-9.4.46.v20220331
```

### 1.2 setup jetty-base

```shell
$ mkdir ~/workspace/jetty/jetty-base
$ cd ~/workspace/jetty/jetty-base
$ java -jar $JETTY_HOME/start.jar --add-to-start=http,deploy
$ export JETTY_BASE=~/workspace/jetty/jetty-base
$ tree $JETTY_BASE
~/workspace/jetty/jetty-base
├── start.ini
└── webapps

1 directory, 1 file
```

## 2. HelloWorld Servlet Source Code

### 2.1 source code -  `HelloWorldServlet.java`

```java
// WEB-INF/classes/com/gongpengjun/servlets/HelloWorldServlet.java
package com.gongpengjun.servlets;

import java.io.*;

import javax.servlet.http.*;
import javax.servlet.*;

public class HelloWorldServlet extends HttpServlet {
  public void doGet (HttpServletRequest req,
                     HttpServletResponse res)
    throws ServletException, IOException
  {
    PrintWriter out = res.getWriter();

    out.println("Hello, world!");
    out.close();
  }
}
```

### 2.2 servlet config - `web.xml`

```xml
<!-- WEB-INF/web.xml -->
<?xml version="1.0" encoding="ISO-8859-1"?>
<web-app version="3.0"
  xmlns="http://java.sun.com/xml/ns/javaee"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_3_0.xsd">

  <!-- To save as <CATALINA_HOME>\webapps\helloservlet\WEB-INF\web.xml -->

   <servlet>
      <servlet-name>HelloServlet</servlet-name>
      <servlet-class>com.gongpengjun.servlets.HelloWorldServlet</servlet-class>
   </servlet>

   <!-- Note: All <servlet> elements MUST be grouped together and
         placed IN FRONT of the <servlet-mapping> elements -->

   <servlet-mapping>
      <servlet-name>HelloServlet</servlet-name>
      <url-pattern>/sayhello</url-pattern>
   </servlet-mapping>
</web-app>
```

## 3. Deploy HelloWorld Servlet

## 3.1 compile - `HelloWorldServlet.java`

download `javax.servlet-api-4.0.1.jar` from [maven.java.net](https://maven.java.net/content/repositories/releases/javax/servlet/javax.servlet-api/4.0.1/) as compile dependency.

```shell
$ cd standalone-jetty-hello-world
$ javac -classpath WEB-INF/lib/javax.servlet-api-4.0.1.jar WEB-INF/classes/com/gongpengjun/servlets/HelloWorldServlet.java
$ ls -lh WEB-INF/classes/com/gongpengjun/servlets/HelloWorldServlet.class
```

### 3.2 deploy - HelloServlet

please refer step 1.2 for `JETTY_BASE`

```shell
$ cd $JETTY_BASE
# create servlet folder
$ mkdir -p webapps/helloservlet
# class file
$ mkdir -p webapps/helloservlet/WEB-INF/classes/com/gongpengjun/servlets/
$ cp standalone-jetty-hello-world/WEB-INF/classes/com/gongpengjun/servlets/HelloWorldServlet.class webapps/helloservlet/WEB-INF/classes/com/gongpengjun/servlets/
# web.xml
$ cp standalone-jetty-hello-world/WEB-INF/web.xml webapps/helloservlet/WEB-INF/
# index.html
$ cp standalone-jetty-hello-world/index.html webapps/helloservlet/
$ tree webapps/helloservlet
webapps/helloservlet
├── WEB-INF
│   ├── classes
│   │   └── com
│   │       └── gongpengjun
│   │           └── servlets
│   │               └── HelloWorldServlet.class
│   └── web.xml
└── index.html

5 directories, 3 files
```

### 3.3 launch jetty

```shell
$ cd $JETTY_BASE
$ java -jar $JETTY_HOME/start.jar
```

### 3.4 verify

launch web browser to access http://localhost:8080/helloservlet/sayhello

OR

use curl to access `http://localhost:8080/helloservlet/sayhello`

```shell
$ curl -i http://localhost:8080/helloservlet/sayhello
HTTP/1.1 200 OK
Content-Length: 14
Server: Jetty(9.4.46.v20220331)

Hello, world!
```

