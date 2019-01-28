#### trying to get jacoco to measure coverage in war files

###### to build the container go

```
./project.sh build
```

###### to run the container without coverage go

```
./project.sh run 8080
```

Then go to http://localhost:8080/jacoexperiment or https://localhost:8080/jacocoexperiment/any-thing
The servlet has an `if` in it so that we can see if we are measuring coverage successfully.

##### to try to run container with coverage go

```
./project.sh coverage 8080
```

I get

```
Error: Could not find or load main class javaagent:.usr.local.tomcat.jacoco-agent.jar
```

However, when I tried the same thing on an existing project, I got something more like this instead

```
Failed to find Premain-Class manifest attribute in /usr/local/tomcat/jacoco-agent.jar
Error occurred during initialization of VM
```

So probably need to solve both issues.

