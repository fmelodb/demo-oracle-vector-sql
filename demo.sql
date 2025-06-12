
set lines 150
set pages 500
set long 999999
set define off
col model_name      format a20
col algorithm       format a20
col mining_function format a20
col text_data       format a50
col chunk_text      format a30

-- sample data
drop table if exists sample_data;

create table sample_data (id        int generated always as identity primary key, 
                          text_data varchar2(100));

insert into sample_data (text_data)
values  ('New York is in New York'),
        ('Los Angeles is in California'),
        ('Chicago is in Illinois'),
        ('Houston is in Texas'),
        ('Phoenix is in Arizona'),
        ('Philadelphia is in Pennsylvania'),
        ('San Antonio is in Texas'),
        ('San Diego is in California'),
        ('Dallas is in Texas'),
        ('San Jose is in California'),
        ('Austin is in Texas'),
        ('Jacksonville is in Florida'),
        ('Fort Worth is in Texas'),
        ('Charlotte is in North Carolina'),
        ('San Francisco is in California'),
        ('Denver is in Colorado'),
        ('Boston is in Massachusetts'),
        ('El Paso is in Texas'),
        ('Nashville is in Tennessee'),
        ('Detroit is in Michigan'),
        ('Oklahoma City is in Oklahoma'),
        ('Portland is in Oregon'),
        ('Las Vegas is in Nevada'),
        ('Memphis is in Tennessee'),
        ('Louisville is in Kentucky'),
        ('Baltimore is in Maryland'),
        ('Milwaukee is in Wisconsin'),
        ('Tucson is in Arizona'),
        ('Atlanta is in Georgia'),
        ('Kansas City is in Missouri'),
        ('Colorado Springs is in Colorado'),
        ('Miami is in Florida'),
        ('Oakland is in California'),
        ('Minneapolis is in Minnesota'),
        ('Tampa is in Florida'),
        ('New Orleans is in Louisiana'),
        ('Cleveland is in Ohio'),
        ('Anaheim is in California'),
        ('Honolulu is in Hawaii'),
        ('Pittsburgh is in Pennsylvania'),
        ('Orlando is in Florida'),
        ('Ferraris are often red'),
        ('Teslas are electric'),
        ('Fiat 500 are small'),
        ('Jeeps are good for off-road'),
        ('Volvos are known for safety'),
        ('BMWs are sporty'),
        ('Mercedes-Benz cars are luxurious'),
        ('Toyotas are reliable'),
        ('Subarus have all-wheel drive'),
        ('Mazdas are fun to drive'),
        ('Chevrolets are American'),
        ('Fords are popular in the USA'),
        ('Lamborghinis are exotic'),
        ('Porsches are fast'),
        ('Hondas are fuel efficient'),
        ('Kias are affordable'),
        ('Hyundais have long warranties'),
        ('Audis have quattro technology'),
        ('Nissans are practical'),
        ('Cadillacs are premium'),
        ('Buicks are comfortable'),
        ('Acuras are sporty and reliable'),
        ('Infinitis are luxury Nissans'),
        ('Mini Coopers are compact'),
        ('Land Rovers are good for off-road'),
        ('Maseratis are Italian luxury cars'),
        ('Alfa Romeos are stylish'),
        ('Dodge Chargers are powerful'),
        ('Chevy Corvettes are iconic sports cars'),
        ('Volkswagens are German engineered'),
        ('Peugeots are French'),
        ('Citroëns are innovative'),
        ('Renaults are popular in Europe'),
        ('Suzukis are compact'),
        ('Mitsubishis are versatile'),
        ('Saabs are Swedish'),
        ('Skodas are practical'),
        ('Seat cars are Spanish'),
        ('Bugattis are extremely fast'),
        ('Rolls-Royces are ultra-luxurious'),
        ('Bentleys are handcrafted luxury cars'),
        ('Bananas are yellow'),
        ('Kiwis are green inside'),
        ('Oranges are orange'),
        ('Apples can be red or green'),
        ('Strawberries are sweet and red'),
        ('Blueberries are small and blue'),
        ('Lemons are sour and yellow'),
        ('Pineapples have spiky skin'),
        ('Watermelons are juicy and red inside'),
        ('Cherries are small and red'),
        ('Grapes can be green or purple'),
        ('Mangoes are tropical and sweet'),
        ('Peaches are fuzzy and sweet'),
        ('Coconuts have hard shells'),
        ('Papayas are orange inside'),
        ('Avocados are creamy and green'),
        ('Blackberries are dark and sweet'),
        ('Raspberries are red and tart'),
        ('Pomegranates have many seeds'),
        ('Passion fruits are tangy'),
        ('Cranberries are tart and red'),
        ('Dragon fruits are exotic and pink'),
        ('Tangerines are easy to peel'),
        ('Dogs are loyal'),
        ('Cats are independent'),
        ('Horses have four legs'),
        ('Mice are small'),
        ('Elephants have trunks'),
        ('Lions are called the king of the jungle'),
        ('Tigers have stripes'),
        ('Bears hibernate in winter'),
        ('Foxes are clever'),
        ('Rabbits have long ears'),
        ('Kangaroos carry babies in pouches'),
        ('Giraffes have long necks'),
        ('Zebras have black and white stripes'),
        ('Monkeys are playful'),
        ('Gorillas are strong'),
        ('Chimpanzees use tools'),
        ('Dolphins are intelligent'),
        ('Whales are the largest animals'),
        ('Sharks have sharp teeth'),
        ('Eagles have sharp vision'),
        ('Parrots can mimic sounds'),
        ('Cows give milk'),
        ('Pigs are intelligent'),
        ('Chickens lay eggs'),
        ('Ducks can swim'),
        ('Frogs can jump far'),
        ('Crocodiles live in rivers'),
        ('Alligators are similar to crocodiles'),
        ('Bats are the only flying mammals'),
        ('Bees make honey'),
        ('Mumbai is in India'),
        ('Mumbai is the financial capital of India'),
        ('Mumbai is famous for Bollywood'),
        ('Mumbai is known for its street food'),
        ('Dubai is in the United Arab Emirates'),
        ('Dubai is famous for its skyscrapers'),
        ('Dubai has the Burj Khalifa'),
        ('Dubai has artificial islands'),
        ('Oracle CloudWorld is an annual conference'),
        ('Oracle CloudWorld is hosted by Oracle'),
        ('Oracle CloudWorld focuses on cloud technology'),
        ('Oracle CloudWorld features keynote sessions'),
        ('Oracle CloudWorld offers hands-on labs'),
        ('Oracle CloudWorld brings together IT professionals'),
        ('Oracle CloudWorld showcases Oracle innovations'),
        ('Oracle CloudWorld is held in Las Vegas'),
        ('Oracle CloudWorld covers database advancements'),
        ('Oracle CloudWorld includes networking opportunities'),
        ('Oracle CloudWorld presents customer success stories'),
        ('Mercury is the closest planet to the Sun'),
        ('Venus is the hottest planet'),
        ('Earth is the only planet with life'),
        ('Mars is known as the red planet'),
        ('Jupiter is the largest planet'),
        ('Saturn has beautiful rings'),
        ('Uranus rotates on its side'),
        ('Neptune is blue and windy'),
        ('Pluto is a dwarf planet'),
        ('Mercury has no moons'),
        ('Venus is similar in size to Earth'),
        ('Earth has one moon'),
        ('Mars has two moons'),
        ('Jupiter has a giant red spot'),
        ('Saturn has many moons'),
        ('Uranus is an ice giant'),
        ('Neptune has strong storms'),
        ('Pluto was reclassified as a dwarf planet'),
        ('Jupiter has the most moons'),
        ('Saturn is less dense than water');

commit;

-- Vector Data
select vector('[0,0]') as my_vector;


select vector('[1,2,3,4,5,6,7,8]') as my_vector;




-- Vector dimensions and Formats
select vector('[7,2]', 2, int8)    as int8_format, 
       vector('[6,3]', 2, float32) as float32_format, 
       vector('[1,7]', 2, float64) as float64_format;





-- Vector Distance:
select to_number(
        vector_distance(
            vector('[3,1]'),
            vector('[1,1]'),
            euclidean
        )) as euclidean_distance;





-- Load embedding models (ONNX) into the database
select model_name, algorithm, mining_function from user_mining_models;





-- Generating embeddings
select vector_embedding(all_MiniLM_L12 using 'the book is on the table' as data) as embedding;




-- Sample Data
select * from sample_data fetch first 20 rows only;




-- Vector Datatype
alter table sample_data add text_vector vector;


update sample_data
set text_vector = vector_embedding(all_MiniLM_L12 
                                   using text_data as data);


select * from sample_data fetch first 5 rows only;




-- Similarity Search
select id, text_data
from sample_data
order by vector_distance(text_vector, 
                         vector_embedding(all_MiniLM_L12 using 'vehicle' as data), 
                         cosine)
fetch first 4 rows only;


select id, text_data
from sample_data
order by vector_distance(text_vector, 
                         vector_embedding(all_MiniLM_L12 using 'astronomy' as data), 
                         cosine)
fetch first 4 rows only;


select id, text_data
from sample_data
order by vector_distance(text_vector, 
                         vector_embedding(all_MiniLM_L12 using 'places' as data), 
                         cosine)
fetch first 4 rows only;





-- IVF Index
drop index if exists ivf_text_vector;


create vector index ivf_text_vector on sample_data (text_vector) organization neighbor partitions
distance cosine with target accuracy 95;


select id, text_data
from sample_data
order by vector_distance(text_vector, 
                         vector_embedding(all_MiniLM_L12 using 'vehicle' as data), 
                         cosine)
fetch approx next 4 rows only;





-- HNSW Index
drop index if exists ivf_text_vector;


drop index if exists hnsw_text_vector;


create vector index hnsw_text_vector on sample_data (text_vector) organization inmemory neighbor graph
distance cosine with target accuracy 95;


-- Hybrid Index (Vector Index + Keyword)
drop index if exists hybrid_idx_text_vector;

create hybrid vector index hybrid_idx_text_vector on
    sample_data (text_data)
    parameters ('model all_MiniLM_L12');

-- simple text query
select json_query(
        dbms_hybrid_vector.search(
            json('{ "hybrid_index_name" : "hybrid_idx_text_vector",
                    "search_fusion" : "INTERSECT",
                    "vector": { "search_text"  : "places" },
                    "text": { "contains" : "$California"},
                    "return": { "topN" : 3 }}')),
            '$' pretty) as json_output;





-- Working with PDF files
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


select 
    id, 
    title, 
    substr(summary, 1, 30) as summary, 
    round(DBMS_LOB.GETLENGTH(pdf_file)/1024/1024) as pdf_size_mbytes
from oracle_books;

-- Vectorize title and summary
drop table if exists oracle_books_vector;


create table oracle_books_vector as
select 
    id, 
    title, 
    summary,
    vector_embedding(all_MiniLM_L12 using title as data)   as title_vector,
    vector_embedding(all_MiniLM_L12 using summary as data) as summary_vector,
    pdf_file
from oracle_books;


select 
    id, 
    title, 
    substr(summary, 1, 30) as summary, 
    round(DBMS_LOB.GETLENGTH(pdf_file)/1024/1024) as pdf_size_mbytes,
    title_vector,
    summary_vector    
from oracle_books_vector;



select 
    id, 
    title, 
    substr(summary, 1, 30) as summary      
from oracle_books_vector
order by vector_distance(summary_vector, 
                         vector_embedding(all_MiniLM_L12 using 'protect and secure' as data), 
                         cosine)
fetch exact next 1 row only;

select 
    id, 
    title, 
    substr(summary, 1, 30) as summary     
from oracle_books_vector
order by vector_distance(title_vector, 
                         vector_embedding(all_MiniLM_L12 using 'coding' as data), 
                         cosine)
fetch exact next 1 row only;






-- Vectorize the pdf file (DO NOT DROP)
drop table if exists file_chunks;


create table file_chunks
   (doc_id          number,
    chunk_id        number, 
    chunk_data      varchar2(4000), 
    chunk_embedding vector);


insert into file_chunks
select
    books.id,
    et.embed_id, 
    et.embed_data, 
    to_vector(et.embed_vector)
from
    oracle_books_vector books,
    dbms_vector_chain.utl_to_embeddings(
        dbms_vector_chain.utl_to_chunks(
            dbms_vector_chain.utl_to_text(books.pdf_file), 
            json('{"normalize":"all"}')),
            json('{"provider":"database", "model":"all_MiniLM_L12"}')) chunks,
    json_table(chunks.column_value, '$[*]' 
        columns (embed_id     number         PATH '$.embed_id', 
                 embed_data   varchar2(4000) PATH '$.embed_data', 
                 embed_vector clob           PATH '$.embed_vector')) et;

commit;

select * from file_chunks fetch first 3 rows only

-- HNSW Index (chunk_embedding)
create vector index hnsw_chunk_idx on file_chunks (chunk_embedding) organization inmemory neighbor graph
distance cosine with target accuracy 95;

-- similarity search
SELECT doc_id, chunk_id, substr(chunk_data, 1, 80) as chunk_data_substr
FROM file_chunks
ORDER BY vector_distance(chunk_embedding, 
                         vector_embedding(all_MiniLM_L12 using 'audit policy' as data),
                         cosine)
fetch approx next 5 rows only;



-- similarity search
SELECT doc_id, chunk_id, substr(chunk_data, 1, 80) as chunk_data_substr
FROM file_chunks
ORDER BY vector_distance(chunk_embedding, 
                         vector_embedding(all_MiniLM_L12 using 'SQL hints' as data),
                         cosine)
fetch approx next 5 rows only;



-- multi-vector search
SELECT doc_id, chunk_id, substr(chunk_data, 1, 80) as chunk_data_substr
FROM file_chunks
ORDER BY vector_distance(chunk_embedding, 
                         vector_embedding(all_MiniLM_L12 using 'blockchain' as data),
                         cosine)
fetch approx
 first 2 partitions by doc_id, 
 3 rows only
 with target accuracy 90;

