drop table if exists oracle_books;

create table oracle_books
   (id           number,
    title        varchar2(30), 
    summary      varchar2(500), 
    release_date date,
    pdf_file     blob);


CREATE OR REPLACE DIRECTORY pdf_dir AS '/home/oracle';


DECLARE
  v_bfile    BFILE;
  v_blob     BLOB;
BEGIN
  -- Inicializa o BFILE apontando para o arquivo PDF
  v_bfile := BFILENAME('PDF_DIR', 'database-security-guide.pdf');

  -- Inserir linha com BLOB vazio (temporário)
  INSERT INTO oracle_books
  VALUES (1, 
       'Security Guide',
       'This guide outlines key practices for protecting databases, including access control, encryption, secure configuration, and monitoring. It highlights threats like SQL injection and stresses backups, updates, and user training. Aimed at IT professionals, it offers practical steps to ensure data integrity, confidentiality, and compliance.',    
       to_date('01/01/2023', 'dd/mm/yyyy'),
       EMPTY_BLOB())
  RETURNING pdf_file INTO v_blob;

  -- Abrir e carregar o conteúdo do BFILE no BLOB
  DBMS_LOB.OPEN(v_bfile, DBMS_LOB.LOB_READONLY);
  DBMS_LOB.LoadFromFile(dest_lob => v_blob,
                        src_lob  => v_bfile,
                        amount   => DBMS_LOB.GETLENGTH(v_bfile));
  DBMS_LOB.CLOSE(v_bfile);
END;
/


DECLARE
  v_bfile    BFILE;
  v_blob     BLOB;
BEGIN
  -- Inicializa o BFILE apontando para o arquivo PDF
  v_bfile := BFILENAME('PDF_DIR', 'database-development-guide.pdf');

  -- Inserir linha com BLOB vazio (temporário)
  INSERT INTO oracle_books
  VALUES (2, 
       'Development Guide',
       'This guide introduces practical development using SQL and PL/SQL for database logic, along with JavaScript and Java for application layers. It covers data manipulation, stored procedures, backend integration, and front-end scripting. Emphasis is placed on performance, modular code, and real-world examples. Ideal for full-stack and database developers.',
       to_date('02/01/2023', 'dd/mm/yyyy'),
       EMPTY_BLOB())
  RETURNING pdf_file INTO v_blob;

  -- Abrir e carregar o conteúdo do BFILE no BLOB
  DBMS_LOB.OPEN(v_bfile, DBMS_LOB.LOB_READONLY);
  DBMS_LOB.LoadFromFile(dest_lob => v_blob,
                        src_lob  => v_bfile,
                        amount   => DBMS_LOB.GETLENGTH(v_bfile));
  DBMS_LOB.CLOSE(v_bfile);
END;
/