-- ˵���� --��ʾע��
--�������ݿ�

create database bbs;

use bbs;

--������
--ʹ��

--��������˵����id ���µ�id��pid ���µĸ���id(ע�⣬root�ڵ�� pid = 0 ��Ϊ���������������û�и��׽ڵ��ˣ���Ϊ0),rootid ��������ϵ�id�������˼������⣬˭�����,���rootid = root�ڵ��id�������ݿ��Զ����ɵ�id����isleaf �ǲ���Ҷ�ӽڵ�
CREATE TABLE article (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pid INT,
    rootid INT,
    title VARCHAR(255),
    cont TEXT,
    pdate DATETIME,
    isleaf INT
);

--0 ����leaf�� 1 �����leaf

insert into article values (null, 0, 1, '���ϴ�ս����', '���ϴ�ս����', now(), 1);
insert into article values (null, 1, 1, '���󱻴�ſ����', '���󱻴�ſ����',now(), 1);
insert into article values (null, 2, 1, '����Ҳ���ù�','����Ҳ���ù�', now(), 0);
insert into article values (null, 2, 1, 'Ϲ˵', 'Ϲ˵', now(), 1);
insert into article values (null, 4, 1, 'û��Ϲ˵', 'û��Ϲ˵', now(), 0);
insert into article values (null, 1, 1, '��ô����', '��ô����', now(), 1);
insert into article values (null, 6, 1, '��ôû�п���', '��ôû�п���', now(), 0);
insert into article values (null, 6, 1, '�������Ǻܴ��', '�������Ǻܴ��', now(), 0);
insert into article values (null, 2, 1, '�����ҽԺ��', '�����ҽԺ��', now(), 1);
insert into article values (null, 9, 1, '��ʿ������', '��ʿ������', now(), 0);