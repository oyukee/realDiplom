
CREATE TABLE "Product" (
  "ProductID" BIGSERIAL PRIMARY KEY,
  "User_ID" varchar,
  "prodcut_title" varchar,
  "metaTitle" varchar,
  "summary" text,
  "product_price" float,
  "discount" float,
  "quantity" int,
  "group_qty" int, 
  "current_order_qty" int,  
  "status" int,
  "createdAt" timestamp,
  "updatedAt" timestamp,
  "publishedAt" timestamp,
  "startsAt" timestamp,
  "endsAt" timestamp,
  "content" text,
  "serial_no" text
);

ALTER TABLE IF EXISTS public."Product"
    ADD COLUMN "current_order_group_ID" bigint;

ALTER TABLE IF EXISTS public."Product"
    ADD COLUMN "image_url" text;
	
ALTER TABLE IF EXISTS public."Product"
    ADD COLUMN "rating" float;
	
ALTER TABLE IF EXISTS public."Product"
    ADD COLUMN "current_order_group_ID" bigint;


CREATE TABLE "Product_Category" (
  "ProductID" int,
  "CategoryID" int
);

CREATE TABLE "Category" (
  "CategoryID" BIGSERIAL  PRIMARY KEY,
  "parentID" int,
  "title" varchar,
  "metaTitle" varchar,
  "slug" varchar,
  "content" text
);

ALTER TABLE IF EXISTS "Category"
    ADD COLUMN image_url text;
	
CREATE TABLE "Product_Review" (
  "reviewID" BIGSERIAL PRIMARY KEY,
  "ProductID" int,
  "parentID" int,
  "title" varchar,
  "rating" int,
  "published" int,
  "createdAt" timestamp,
  "publishedAt" timestamp,
  "content" Text
);

CREATE TABLE "order_person" (
  "Order_person_ID" BIGSERIAL PRIMARY KEY,
  "ProductID" int,
  "User_ID" varchar,
  "order_status" int,
  "subTotal" float,
  "ItemDiscount" float,
  "tax" float,
  "sku" varchar,
  "shipping" float,
  "total" float,
  "promo" varchar,
  "discount" float,
  "grandTotal" float,
  "line1" varchar,
  "line2" varchar,
  "User_City" varchar,
  "province" varchar,
  "User_Country" varchar,
  "quantity" int,
  "createdAt" timestamp,
  "updatedAt" timestamp,
  "content" text,
  "image_url" text,
   "order_group_ID" int
);

ALTER TABLE IF EXISTS public."order_person"
    ADD COLUMN "order_group_ID" bigint;


CREATE TABLE "order_group" (
  "order_group_ID" BIGSERIAL PRIMARY KEY,
  "ProductID" int,
  "order_quantity" int
);

CREATE TABLE "Cart" (
  "Cart_ID" BIGSERIAL PRIMARY KEY,
  "User_ID" varchar,
  "status" int,
  "User_Fname" varchar,
  "User_Lname" varchar,
  "User_Phone1" varchar,
  "User_Email" varchar,
  "line1" varchar,
  "line2" varchar,
  "City" varchar,
  "province" varchar,
  "Country" varchar,
  "createdAt" timestamp,
  "updatedAt" timestamp,
  "content" text
);

CREATE TABLE "Cart_item" (
  "ID" BIGSERIAL PRIMARY KEY,
  "ProductID" int,
  "Cart_ID" int,
  "sku" varchar,
  "price" float,
  "discount" float,
  "quantity" int,
  "active" int,
  "createdAt" timestamp,
  "updatedAt" timestamp,
  "content" text
);


ALTER TABLE "Cart_item" ADD FOREIGN KEY ("Cart_ID") REFERENCES "Cart" ("Cart_ID");

ALTER TABLE "Cart_item" ADD FOREIGN KEY ("ProductID") REFERENCES "Product" ("ProductID");

ALTER TABLE "Product_Category" ADD FOREIGN KEY ("ProductID") REFERENCES "Product" ("ProductID");

ALTER TABLE "Product_Category" ADD FOREIGN KEY ("CategoryID") REFERENCES "Category" ("CategoryID");

ALTER TABLE "Product_Review" ADD FOREIGN KEY ("ProductID") REFERENCES "Product" ("ProductID");
 

ALTER TABLE "order_person" ADD FOREIGN KEY ("ProductID") REFERENCES "Product" ("ProductID");
