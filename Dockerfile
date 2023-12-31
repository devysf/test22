FROM eclipse-temurin:17.0.3_7-jre-alpine AS builder
RUN mvn package -Dmaven.test.skip=true
COPY target/yte-demo-app-0.0.1-SNAPSHOT.jar app.jar
RUN java -Djarmode=layertools -jar app.jar extract

FROM eclipse-temurin:17.0.3_7-jre-alpine
RUN adduser -D -g 5005 -u 5005 yte
ADD pinpoint-agent pinpoint-agent
RUN chown -R yte /pinpoint-agent

COPY --from=builder dependencies/ ./
COPY --from=builder spring-boot-loader/ ./
COPY --from=builder snapshot-dependencies/ ./
RUN true
COPY --from=builder company-dependencies/ ./
COPY --from=builder application/ ./

USER yte
CMD ["sh", "-c", "java $DEFAULT_MANAGED_OPTS $JAVA_OPTS org.springframework.boot.loader.JarLauncher"]