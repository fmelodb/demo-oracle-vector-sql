
-- sample data
@create_sample_data.sql


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

commit;

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

create vector index ivf_text_vector on sample_data (text_vector) 
organization neighbor partitions
distance cosine 
with target accuracy 95;

-- HNSW Index
drop index if exists ivf_text_vector;
drop index if exists hnsw_text_vector;


create vector index hnsw_text_vector on sample_data (text_vector) 
organization inmemory neighbor graph
distance cosine 
with target accuracy 95;


-- Hybrid Index (Vector Index + Keyword)
drop index if exists hybrid_idx_text_vector;

create hybrid vector index hybrid_idx_text_vector on
    sample_data (text_data)
    parameters ('model all_MiniLM_L12');





-- simple hybrid text/vector query
select json_query(
        dbms_hybrid_vector.search(
            json('{ "hybrid_index_name" : "hybrid_idx_text_vector",
                    "search_fusion" : "INTERSECT",
                    "vector": { "search_text"  : "places" },
                    "text": { "contains" : "$California"},
                    "return": { "topN" : 3 }}')),
            '$' pretty) as json_output;





-- Working with PDF files
create table if not exists oracle_books
   (id           number,
    title        varchar2(30), 
    summary      varchar2(500), 
    release_date date,
    pdf_file     blob);


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
create table if not exists file_chunks
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

-- HNSW Index (chunk_embedding)
create vector index hnsw_chunk_idx on file_chunks (chunk_embedding) 
organization inmemory neighbor graph
distance cosine 
with target accuracy 95;


-- query
select * from file_chunks
order by doc_id, chunk_id
fetch first 3 rows only;




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

