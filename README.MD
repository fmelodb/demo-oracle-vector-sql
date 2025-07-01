# Oracle Vector - SQL Demo

It demonstrates how you can perform vector operations on Oracle AI Vector Search.

---

## 🚀 Getting Started

You can quickly get an image of Oracle Database 23ai Free (using Podman):

- [Oracle Container Registry](https://container-registry.oracle.com)  Go to **Database > free (23ai)**

```sh
podman run --name oracle32aifree -p 1521:1521 -e ORACLE_PWD=password container-registry.oracle.com/database/free:latest
```

I am using the all_MiniLM_L12_v2.onnx embedding model for generating vectors. You can download it [here](https://adwc4pm.objectstorage.us-ashburn-1.oci.customer-oci.com/p/VBRD9P8ZFWkKvnfhrWxkpPe8K03-JIoM5h_8EJyJcpE80c108fuUjg7R5L5O7mMZ/n/adwc4pm/b/OML-Resources/o/all_MiniLM_L12_v2_augmented.zip).

The load_embedding_model_adb.sql is used for loading external files (embedding model and pdfs). It works if you are using Autonomous Database.

Run load_embedding_model_podman.sql if you are running Oracle 23ai from a Podman container.


---

## 📋 Steps

Create sample_data table and load the rows using load_embedding_model_adb.sql file

Then, just run the demo.sql file (on sqlplus, sqlcl, SQL Developer Web or VS Code) one by one to understand how each command works.

```sh
demo.sql
```



