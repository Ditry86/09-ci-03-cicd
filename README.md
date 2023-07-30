# Домашнее задание к занятию 9 «Процессы CI/CD»

## Знакомоство с SonarQube

[Screenshot отчета анализа SonarCube кода fail.py с ошибками](./study/screen_error.png)

Команда для проведения теста после исправления кода (в том числе, для удаления сообщений Warnings):
```
sonar-scanner   -Dsonar.projectKey=test   -Dsonar.sources=.   -Dsonar.host.url=http://158.160.101.25:9000   -Dsonar.login=59264e28f304b47f7fc00dbafcec3e6e81ae8d5f   -Dsonar.coverage.exclusions=fail.py -Dsonar.python.version=3
```
[Screenshot отчета SonarCube -1](./study/screen1.png)
[Screenshot отчета анализа SonarCube кода fail.py после исправления ошибок](./study/screen2.png)

## Знакомство с Nexus

[maven-metadata.xml](./study/maven-metadata.xml)

### Знакомство с Maven

[pom.xml](./mvn/pom.xml)

---
