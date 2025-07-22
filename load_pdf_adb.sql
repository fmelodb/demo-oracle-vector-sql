drop table if exists oracle_books;

create table oracle_books
   (id           number,
    title        varchar2(30), 
    summary      varchar2(500), 
    release_date date,
    pdf_file     blob);


insert into oracle_books 
values(1, 
       'Security Guide',
       'This guide outlines key practices for protecting databases, including access control, encryption, secure configuration, and monitoring. It highlights threats like SQL injection and stresses backups, updates, and user training. Aimed at IT professionals, it offers practical steps to ensure data integrity, confidentiality, and compliance.',    
       to_date('01/01/2023', 'dd/mm/yyyy'),
       dbms_cloud.get_object('oss_credential', 'https://objectstorage.sa-vinhedo-1.oraclecloud.com/p/OWrgzRRdznvbAYLWZJ8E96HJS9-PjeJx1jrEcf1d_u5P3RGC7A7LxLDHJ035Q_Af/n/idi1o0a010nx/b/data/o/database-security-guide.pdf'));


insert into oracle_books 
values(2, 
       'Development Guide',
       'This guide introduces practical development using SQL and PL/SQL for database logic, along with JavaScript and Java for application layers. It covers data manipulation, stored procedures, backend integration, and front-end scripting. Emphasis is placed on performance, modular code, and real-world examples. Ideal for full-stack and database developers.',
       to_date('02/01/2023', 'dd/mm/yyyy'),
       dbms_cloud.get_object('oss_credential', 'https://objectstorage.sa-vinhedo-1.oraclecloud.com/p/my-xi5JPzIGpxf7EY3DgWWNgs2dvsceivj4WLjxJF_EnpFogEEbh5WG1qgL0xK_7/n/idi1o0a010nx/b/data/o/database-development-guide.pdf'));

