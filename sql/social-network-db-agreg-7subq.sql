CREATE TABLE "users" (
  "id" INT PRIMARY KEY,
  "name" VARCHAR(50) NOT NULL,
  "email" VARCHAR(45) UNIQUE NOT NULL,
  "password" VARCHAR(50) NOT NULL
);

CREATE TABLE "posts" (
  "id" INT PRIMARY KEY,
  "user_id" INT,
  "text" TEXT NOT NULL,
  "image_url" VARCHAR(255),
  FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE
);

CREATE TABLE "likes" (
  "user_id" INT,
  "post_id" INT,
  PRIMARY KEY ("user_id", "post_id"),
  FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE,
  FOREIGN KEY ("post_id") REFERENCES "posts"("id") ON DELETE CASCADE
);

INSERT INTO "users" ("id", "name", "email", "password") VALUES 
(1, 'Marcos', 'marquinhos@gmail.com', '1234'),
(2, 'Bruno', 'bruno@gmail.com', '54321'),
(3, 'Lucas', 'lucas@gmail.com', 'senha');

INSERT INTO "posts" ("id", "user_id", "text", "image_url", "likes") VALUES 
(1, 1, 'tbt', 'https://imagem.com/img1.jpg', 1001),
(2, 2, '#tapaggo', NULL, 90),
(3, 3, 'emoji', NULL, 10);


INSERT INTO "likes" ("user_id", "post_id") VALUES 
(2, 1),
(1, 2),
(3, 2);

-- wheres
-- quem tem gmail
SELECT * FROM "users" WHERE "email" LIKE '%gmail.com';

-- tem +1000 curtidas
SELECT * FROM "posts" WHERE "likes" > 1000;

-- tds do user id 1
SELECT * FROM "posts" WHERE "user_id" = 1;


-- agreg
-- total de users
SELECT COUNT(*) AS total_users FROM "users";

-- media like
SELECT AVG("likes") AS media_likes FROM "posts";

-- total curtidas por post 
SELECT "post_id", COUNT(*) AS total_likes 
FROM "likes" 
GROUP BY "post_id";


-- relaci
-- quem já postou 
SELECT DISTINCT "users"."name" 
FROM "users" 
JOIN "posts" ON "users"."id" = "posts"."user_id";

-- posts e nome
SELECT "posts"."text", "users"."name" 
FROM "posts" 
JOIN "users" ON "posts"."user_id" = "users"."id";

-- quem likou qual post 
SELECT "users"."name", "posts"."text"
FROM "likes"
JOIN "users" ON "likes"."user_id" = "users"."id"
JOIN "posts" ON "likes"."post_id" = "posts"."id";


-- subquerry
-- quem num posto - ghost
SELECT * FROM "users" 
WHERE "id" NOT IN (SELECT DISTINCT "user_id" FROM "posts");

-- posts com mais curtidas que a media (?)
SELECT * FROM "posts" 
WHERE "likes" > (SELECT AVG("likes") FROM "posts");

-- quem curtiu o mais curtido
SELECT "users".*
FROM "users"
WHERE "id" IN (
    SELECT "user_id" FROM "likes" 
    WHERE "post_id" = (SELECT "id" FROM "posts" ORDER BY "likes" DESC LIMIT 1)
);
