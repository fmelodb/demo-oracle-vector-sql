

-- 1. Download the embedding model using the URL provided in README
-- 2. Unzip it, and move it to the podman container, example:

-- podman ps (check what is the container id)
-- podman cp .\all_MiniLM_L12_v2.onnx [container_id]:/home/oracle

-- create a directory
CREATE OR REPLACE DIRECTORY DM_DUMP AS '/home/oracle';

-- load the embedding model
BEGIN
   DBMS_VECTOR.LOAD_ONNX_MODEL(
        directory => 'DM_DUMP',
        file_name => 'all_MiniLM_L12_v2.onnx',
        model_name => 'ALL_MINILM_L12_V2');
END;
/

-- check if it is loaded
select model_name from user_mining_models;

