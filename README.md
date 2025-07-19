# Git_DuongPhan

This repository holds the source code for the `Project_SWP` web application.

## CopyLibs library

The NetBeans build scripts require the `org-netbeans-modules-java-j2seproject-copylibstask.jar` file. It is included in the Apache NetBeans distribution in the `java*/ant/extra` directory. Download NetBeans from <https://netbeans.apache.org/> and copy the JAR to a location of your choice.

You can point the build to this file on the command line:

```bash
ant -f Project_SWP/build.xml -Dlibs.CopyLibs.classpath=/path/to/org-netbeans-modules-java-j2seproject-copylibstask.jar dist
```

Alternatively, create a `build.properties` file in this directory containing:

```properties
libs.CopyLibs.classpath=/path/to/org-netbeans-modules-java-j2seproject-copylibstask.jar
```

## Building

To produce the distributable WAR file, run:

```bash
ant -f Project_SWP/build.xml dist
```

Make sure `libs.CopyLibs.classpath` points to the JAR as shown above so that the build succeeds.
