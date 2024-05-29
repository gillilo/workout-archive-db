#PostgreSQL 13 버전을 베이스 이미지로 사용
FROM postgres:13

#sql backup error시 dbeaver connection settings - main - local client - postgreSQL binaries로 선택 후 커넥션, 백업하기
#init.sql파일을 /docker-entrypoint-initdb.d/ 로 복사, /docker-entrypoint-initdb.d/에 있는 sql문은 컨테이너가 처음 실행 시 자동실행됨
COPY ./init/init.sql /docker-entrypoint-initdb.d/

#postgresql.conf파일을 /etc/postgresql/postgresql.conf 로 복사, 기본 설정 파일을 덮어쓰기하여 새로운 설정 적용
COPY ./config/postgresql.conf /etc/postgresql/custom.conf

#계정정보 설정
ENV POSTGRES_USER=gillilo
ENV POSTGRES_PASSWORD=gillilo
ENV POSTGRES_DB=workoutArchive

EXPOSE 5432

CMD ["postgres", "-c", "config_file=/etc/postgresql/custom.conf"]

# docker build -t gillilo/workout-archive-db:latest .
# docker run -d --name workout-archive-db --network workout-archive gillilo/workout-archive-db:latest