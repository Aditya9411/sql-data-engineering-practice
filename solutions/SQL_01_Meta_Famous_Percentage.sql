/*
===========================================================
SQL Data Engineering Practice - Question 01
Company: Meta / Facebook
Difficulty: Hard
Topic: CTE, UNION, GROUP BY, COUNT, Percentage Calculation
===========================================================

QUESTION:

A table called "famous" contains two columns:

    user_id
    follower_id

Each row represents a relationship where follower_id follows user_id.

Both user_id and follower_id represent users on the platform.

Calculate the famous percentage for each user who has followers.

Formula:

Famous Percentage =
(Number of followers of the user / Total number of users) * 100

===========================================================
*/


-- ========================================================
-- CREATE TABLE
-- ========================================================

CREATE TABLE famous (
    user_id INT,
    follower_id INT
);


-- ========================================================
-- INSERT SAMPLE DATA
-- ========================================================

INSERT INTO famous (user_id, follower_id)
VALUES
    (1, 2),
    (1, 3),
    (2, 4),
    (5, 1),
    (5, 3),
    (11, 7),
    (12, 8),
    (13, 5),
    (13, 10),
    (14, 12),
    (14, 3),
    (15, 14),
    (15, 13);


-- ========================================================
-- SOLUTION
-- ========================================================

WITH distinct_users AS
(
    SELECT user_id
    FROM famous

    UNION

    SELECT follower_id
    FROM famous
),

follower_count AS
(
    SELECT
        user_id,
        COUNT(follower_id) AS followers
    FROM famous
    GROUP BY user_id
)

SELECT
    user_id,
    followers,
    ROUND(
        followers * 100.0 /
        (SELECT COUNT(*) FROM distinct_users),
        2
    ) AS famous_percentage
FROM follower_count
ORDER BY user_id;


/*
===========================================================
EXPLANATION
===========================================================

STEP 1: Find all users

A person can appear either as a user_id or follower_id.

Therefore, we combine both columns:

    SELECT user_id FROM famous

    UNION

    SELECT follower_id FROM famous

UNION automatically removes duplicates.

This gives us all unique users on the platform.


STEP 2: Count followers

We GROUP BY user_id and count follower_id.

Example:

User 1 has followers 2 and 3.

Therefore:

    user_id = 1
    followers = 2


STEP 3: Calculate famous percentage

Formula:

    followers / total_users * 100

100.0 is used instead of 100 so that SQL performs
decimal calculation instead of integer calculation.


STEP 4: ROUND()

ROUND(..., 2) displays the percentage with two
decimal places.


===========================================================
KEY SQL CONCEPTS
===========================================================

1. Common Table Expressions (CTEs)
2. UNION
3. COUNT()
4. GROUP BY
5. Subquery
6. ROUND()
7. Percentage calculations

===========================================================
*/
