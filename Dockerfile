FROM maven:3.6.0-jdk-8

RUN mkdir /jacocoexperiment
COPY jacocoexperiment/pom.xml /jacocoexperiment/pom.xml
# make sure only a pom.xml update causes the dependencies to get downloaded again
RUN mvn -f /jacocoexperiment dependency:go-offline
RUN rm -rf jacocoexperiment
COPY jacocoexperiment /jacocoexperiment

RUN mvn -f /jacocoexperiment/pom.xml install
RUN mvn -DgroupId=org.jacoco -DartifactId=org.jacoco.agent -Dversion=0.8.3 dependency:get

FROM tomcat:7.0.92-jre8

COPY --from=0 /jacocoexperiment/target/jacocoexperiment-1.0-SNAPSHOT.war webapps/jacocoexperiment.war
COPY --from=0 /root/.m2/repository/org/jacoco/org.jacoco.agent/0.8.3/org.jacoco.agent-0.8.3.jar jacoco-agent.jar
