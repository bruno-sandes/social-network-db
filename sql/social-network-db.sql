CREATE TABLE "users" (
  "id" int PRIMARY KEY,
  "name" varchar(50),
  "email" varchar(45) UNIQUE,
  "password" varchar(50),
  "profile" varchar(50),
  "phone_number" varchar(20),
  "address" varchar(50),
  "posts" varchar(50),
  "birth" date,
  "profile_pic" varchar(50)
);

CREATE TABLE "posts" (
  "id" int PRIMARY KEY,
  "users_id" int,
  "text" text
);

CREATE TABLE "likes" (
  "id" int PRIMARY KEY,
  "users_id" int,
  "post_id" int,
  "coment_id" int
);

CREATE TABLE "coments" (
  "id" int PRIMARY KEY,
  "users_id" int,
  "post_id" int,
  "coment" text
);

CREATE TABLE "friends" (
  "id" int PRIMARY KEY,
  "follower_id" int,
  "followed_id" int
);

ALTER TABLE "posts" ADD FOREIGN KEY ("users_id") REFERENCES "users" ("id");

ALTER TABLE "likes" ADD FOREIGN KEY ("users_id") REFERENCES "users" ("id");

ALTER TABLE "likes" ADD FOREIGN KEY ("post_id") REFERENCES "posts" ("id");

ALTER TABLE "likes" ADD FOREIGN KEY ("coment_id") REFERENCES "coments" ("id");

ALTER TABLE "coments" ADD FOREIGN KEY ("users_id") REFERENCES "users" ("id");

ALTER TABLE "coments" ADD FOREIGN KEY ("post_id") REFERENCES "posts" ("id");

ALTER TABLE "friends" ADD FOREIGN KEY ("follower_id") REFERENCES "users" ("id");

ALTER TABLE "friends" ADD FOREIGN KEY ("followed_id") REFERENCES "users" ("id");

ALTER TABLE "users" ADD FOREIGN KEY ("id") REFERENCES "users" ("email");
