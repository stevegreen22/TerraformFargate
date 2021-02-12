# Todo: Will need to expose ports.

FROM openjdk:8

COPY ./out/production/HelloLinius/ /tmp

WORKDIR /tmp

ENTRYPOINT ["java","HelloLinius"]