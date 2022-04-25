create database sampledb;
create role "userRUG"  WITH
LOGIN
SUPERUSER
INHERIT
CREATEDB
CREATEROLE
REPLICATION;
ALTER USER "userRUG" WITH PASSWORD 'QnBMbmZnRHNjMldEOEYy';
grant all privileges on database sampledb to "userRUG";

