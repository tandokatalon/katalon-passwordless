FROM gradle:8.5-jdk21 AS build

WORKDIR /app
COPY . /app/

RUN ./gradlew build --no-daemon

FROM scratch AS export-stage
COPY --from=build /app/build/libs/katalon-passwordless-1.0-SNAPSHOT.jar /