// Find all items of an order.
MATCH (order:Order {id: 1001})-[:Contains]->(item)
RETURN item;

// Calculate total price of an order.
MATCH (order:Order {id: 1003})-[:Contains]->(item)
RETURN sum(item.price);

// Find all orders of a customer.
MATCH (customer:Customer {id: 1})-[:Bought]->(order)
RETURN order;

// Find all items bought by a customer.
MATCH (customer:Customer {id: 1})-[:Bought]->(order), (order)-[:Contains]->(item)
RETURN item;

// Find a total count of items bought by a customer.
MATCH (customer:Customer {id: 1})-[:Bought]->(order), (order)-[:Contains]->(item)
RETURN count(item);

// Find an amount of money spent by a customer.
MATCH (customer:Customer {id: 1})-[:Bought]->(order), (order)-[:Contains]->(item)
RETURN sum(item.price);

// Calculate how many times each item has been bought (sort by this number).
MATCH (customer:Customer)-[:Bought]->(order:Order)-[:Contains]->(item:Item)
WITH item, count(order) as ct
RETURN item, ct
ORDER BY ct DESC;

// Find all items viewed by a customer.
MATCH (customer:Customer {id: 3})-[:View]->(item:Item)
RETURN item;

// Find all other items that have been bought with a specific item.
MATCH (order:Order)-[:Contains]->(item:Item),
      (specific_item:Item {id: 104})
  WHERE (order)-[:Contains]->(specific_item)
  AND item <> specific_item
RETURN item;

// Find all customers who have bought an item.
MATCH (customer:Customer)-[:Bought]->(order:Order)-[:Contains]->(item:Item {id: 103})
RETURN customer;

// Find items that have been viewed but haven't been bought by a specific customer.
MATCH (customer:Customer {id: 1})-[:View]->(item:Item)
  WHERE NOT EXISTS {
    MATCH (customer)-[:Bought]->(order:Order)-[:Contains]->(item)
  }
RETURN item;
