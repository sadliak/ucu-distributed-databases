// Delete all existing entities and relationships.
MATCH (n)
DETACH DELETE n;

// Create Customer entities.
CREATE (n:Customer {id:1, name:'Oleksii'});
CREATE (n:Customer {id:2, name:'Mary'});
CREATE (n:Customer {id:3, name:'Andrii'});
CREATE (n:Customer {id:4, name:'Sola'});

// Create Item entities.
CREATE (n:Item {id:101, name: 'Jungle Book', price: 10});
CREATE (n:Item {id:102, name: 'Wizard of Oz', price: 4.5});
CREATE (n:Item {id:103, name: 'Alice in Wonderland', price: 12});
CREATE (n:Item {id:104, name: 'Winnie the Pooh', price: 25});

// Create Order entities.
CREATE (n:Order {id:1001, date: date('2022-01-01')});
CREATE (n:Order {id:1002, date: date('2022-01-01')});
CREATE (n:Order {id:1003, date: date('2022-01-01')});
CREATE (n:Order {id:1004, date: date('2022-01-03')});
CREATE (n:Order {id:1005, date: date('2022-01-04')});
CREATE (n:Order {id:1006, date: date('2022-01-04')});
CREATE (n:Order {id:1007, date: date('2022-01-07')});
CREATE (n:Order {id:1008, date: date('2022-01-07')});

// Create Bought relationships.
MATCH (customer:Customer), (order:Order)
  WHERE customer.id = 1 AND order.id = 1001
CREATE (customer)-[r:Bought]->(order);
MATCH (customer:Customer), (order:Order)
  WHERE customer.id = 1 AND order.id = 1002
CREATE (customer)-[r:Bought]->(order);
MATCH (customer:Customer), (order:Order)
  WHERE customer.id = 1 AND order.id = 1004
CREATE (customer)-[r:Bought]->(order);
MATCH (customer:Customer), (order:Order)
  WHERE customer.id = 2 AND order.id = 1005
CREATE (customer)-[r:Bought]->(order);
MATCH (customer:Customer), (order:Order)
  WHERE customer.id = 3 AND order.id = 1003
CREATE (customer)-[r:Bought]->(order);
MATCH (customer:Customer), (order:Order)
  WHERE customer.id = 4 AND order.id = 1006
CREATE (customer)-[r:Bought]->(order);
MATCH (customer:Customer), (order:Order)
  WHERE customer.id = 4 AND order.id = 1007
CREATE (customer)-[r:Bought]->(order);
MATCH (customer:Customer), (order:Order)
  WHERE customer.id = 4 AND order.id = 1008
CREATE (customer)-[r:Bought]->(order);

// Create Contains relationships.
MATCH (order:Order), (item:Item)
  WHERE order.id = 1001 AND item.id = 101
CREATE (order)-[r:Contains]->(item);
MATCH (order:Order), (item:Item)
  WHERE order.id = 1002 AND item.id = 101
CREATE (order)-[r:Contains]->(item);
MATCH (order:Order), (item:Item)
  WHERE order.id = 1002 AND item.id = 102
CREATE (order)-[r:Contains]->(item);
MATCH (order:Order), (item:Item)
  WHERE order.id = 1003 AND item.id = 102
CREATE (order)-[r:Contains]->(item);
MATCH (order:Order), (item:Item)
  WHERE order.id = 1003 AND item.id = 103
CREATE (order)-[r:Contains]->(item);
MATCH (order:Order), (item:Item)
  WHERE order.id = 1004 AND item.id = 104
CREATE (order)-[r:Contains]->(item);
MATCH (order:Order), (item:Item)
  WHERE order.id = 1005 AND item.id = 101
CREATE (order)-[r:Contains]->(item);
MATCH (order:Order), (item:Item)
  WHERE order.id = 1005 AND item.id = 104
CREATE (order)-[r:Contains]->(item);
MATCH (order:Order), (item:Item)
  WHERE order.id = 1006 AND item.id = 102
CREATE (order)-[r:Contains]->(item);
MATCH (order:Order), (item:Item)
  WHERE order.id = 1007 AND item.id = 101
CREATE (order)-[r:Contains]->(item);
MATCH (order:Order), (item:Item)
  WHERE order.id = 1007 AND item.id = 103
CREATE (order)-[r:Contains]->(item);
MATCH (order:Order), (item:Item)
  WHERE order.id = 1008 AND item.id = 104
CREATE (order)-[r:Contains]->(item);

// Create View relationships.
MATCH (customer:Customer), (item:Item)
  WHERE customer.id = 1 AND item.id = 101
CREATE (customer)-[r:View]->(item);
MATCH (customer:Customer), (item:Item)
  WHERE customer.id = 1 AND item.id = 102
CREATE (customer)-[r:View]->(item);
MATCH (customer:Customer), (item:Item)
  WHERE customer.id = 1 AND item.id = 103
CREATE (customer)-[r:View]->(item);
MATCH (customer:Customer), (item:Item)
  WHERE customer.id = 1 AND item.id = 104
CREATE (customer)-[r:View]->(item);
MATCH (customer:Customer), (item:Item)
  WHERE customer.id = 2 AND item.id = 101
CREATE (customer)-[r:View]->(item);
MATCH (customer:Customer), (item:Item)
  WHERE customer.id = 2 AND item.id = 104
CREATE (customer)-[r:View]->(item);
MATCH (customer:Customer), (item:Item)
  WHERE customer.id = 3 AND item.id = 102
CREATE (customer)-[r:View]->(item);
MATCH (customer:Customer), (item:Item)
  WHERE customer.id = 3 AND item.id = 103
CREATE (customer)-[r:View]->(item);
MATCH (customer:Customer), (item:Item)
  WHERE customer.id = 4 AND item.id = 101
CREATE (customer)-[r:View]->(item);
MATCH (customer:Customer), (item:Item)
  WHERE customer.id = 4 AND item.id = 102
CREATE (customer)-[r:View]->(item);
MATCH (customer:Customer), (item:Item)
  WHERE customer.id = 4 AND item.id = 103
CREATE (customer)-[r:View]->(item);
MATCH (customer:Customer), (item:Item)
  WHERE customer.id = 4 AND item.id = 104
CREATE (customer)-[r:View]->(item);
