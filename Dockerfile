# Stage 1: Build the .jar file with Maven
FROM maven:3.8-openjdk-17 AS build
WORKDIR /src
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Create the final, slim image to run the app
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /src/target/*.jar app.jar

# Expose the port your app runs on
EXPOSE 8080

# Run the .jar file
ENTRYPOINT ["java", "-jar", "app.jar"]