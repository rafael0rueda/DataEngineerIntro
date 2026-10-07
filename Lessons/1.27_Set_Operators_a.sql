-- Returns all rows from A and B. Duplicates removed
SELECT UNNEST([1, 1, 1, 2])
UNION
SELECT UNNEST([1, 1, 3]);

-- Returns all rows from A and B. Duplicates preserved
SELECT UNNEST([1, 1, 1, 2])
UNION ALL
SELECT UNNEST([1, 1, 3]);

-- Returns rows common to A and B. Duplicates removed
SELECT UNNEST([1, 1, 1, 2])
INTERSECT
SELECT UNNEST([1, 1, 3]);

-- Returns rows common to A and B. Duplicates preserved
SELECT UNNEST([1, 1, 1, 2])
INTERSECT ALL
SELECT UNNEST([1, 1, 3]);

-- Returns rows in A but not in B. Duplicates removed
SELECT UNNEST([1, 1, 1, 2])
EXCEPT
SELECT UNNEST([1, 1, 3]);

-- Returns rows in A minus rows in B. Duplicates removed one-for-one
SELECT UNNEST([1, 1, 1, 2])
EXCEPT ALL
SELECT UNNEST([1, 1, 3]);
