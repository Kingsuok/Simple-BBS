-- 说明： --表示注释
--创建数据库

create database bbs;

use bbs;

--创建表
--使用

--表中数据说明：id 文章的id，pid 文章的父亲id(注意，root节点的 pid = 0 因为主题是他发表的他没有父亲节点了，故为0),rootid 文章最根上的id（发表了几个话题，谁发表的,这个rootid = root节点的id，即数据库自动生成的id），isleaf 是不是叶子节点
CREATE TABLE article (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pid INT,
    rootid INT,
    title VARCHAR(255),
    cont TEXT,
    pdate DATETIME,
    isleaf INT
);

--0 代表leaf， 1 代表非leaf

insert into article values (null, 0, 1, '蚂蚁大战大象', '蚂蚁大战大象', now(), 1);
insert into article values (null, 1, 1, '大象被打趴下了', '大象被打趴下了',now(), 1);
insert into article values (null, 2, 1, '蚂蚁也不好过','蚂蚁也不好过', now(), 0);
insert into article values (null, 2, 1, '瞎说', '瞎说', now(), 1);
insert into article values (null, 4, 1, '没有瞎说', '没有瞎说', now(), 0);
insert into article values (null, 1, 1, '怎么可能', '怎么可能', now(), 1);
insert into article values (null, 6, 1, '怎么没有可能', '怎么没有可能', now(), 0);
insert into article values (null, 6, 1, '可能性是很大的', '可能性是很大的', now(), 0);
insert into article values (null, 2, 1, '大象进医院了', '大象进医院了', now(), 1);
insert into article values (null, 9, 1, '护士是蚂蚁', '护士是蚂蚁', now(), 0);