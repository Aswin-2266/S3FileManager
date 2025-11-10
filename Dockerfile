# Stage 1: Build the .jar file with Maven
FROM eclipse-temurin:17-jdk-focal AS build
WORKDIR /src
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Create the final, slim image to run the app
FROM eclipse-temurin:17-jdk-slim-focal
WORKDIR /app
COPY --from=build /src/target/*.jar app.jar

# Expose the port your app runs on
EXPOSE 8080

# Run the .jar file
ENTRYPOINT ["java", "-jar", "app.jar"]