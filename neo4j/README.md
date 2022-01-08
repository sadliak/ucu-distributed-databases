# Neo4j

**Neo4j** is the world's leading graph database. The architecture is designed for optimal management, storage, and
traversal of nodes and relationships. The graph database takes a property graph approach, which is beneficial for both
traversal performance and operations runtime.

* [Get started with Neo4j](https://neo4j.com/docs/getting-started/current/get-started-with-neo4j/)
* [Graph database concepts](https://neo4j.com/docs/getting-started/current/graphdb-concepts/)

## Prerequisites

* [Docker](https://www.docker.com/) - 20.x.x+
    * Follow instructions to install [Docker](https://www.docker.com/get-started)

## Running

* Start Neo4j database
    ```shell
    $ sh scripts/run_local_neo4j.sh start
    ```
* Stop Neo4j database
    ```shell
    $ sh scripts/run_local_neo4j.sh stop
    ```
* Open Neo4j Cypher shell
    ```shell
    $ sh scripts/run_local_neo4j.sh cypher_shell
    ```
    * To run Cypher script inside the Cypher shell
        ```shell
        $ CALL apoc.cypher.runFile("code/example.cyp");
        ```

## Task Description

Model an ecommerce store domain, answer the questions via queries.

### Domain

#### Entities

* **Item** (id, name, price)
* **Customer** (id, name)
* **Order** (id, date)

#### Relationships

* **Bought** (Customer --> Order)
* **Contains** (Order --> Item)
* **View** (Customer --> Item)

### Queries

* Find all items of an order (by order ID)
* Calculate total price of an order
* Find all order of a customer
* Find all items bought by a customer (via their orders)
* Find a total count of items bought by a customer (via their orders)
* Find an amount of money spent by a customer (via their orders)
* Calculate how many times each item has been bought (sort by this number)
* Find all items viewed by a customer
* Find all other items that have been bought with a specific item (via orders with that item)
* Find all customers who have bought an item
* Find items that have been viewed but haven't been bought by a specific customer
