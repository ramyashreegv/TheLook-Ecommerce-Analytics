# TheLook E-Commerce Dataset Understanding

## 1. Users Table

### Purpose

Stores customer information and demographics.

### Primary Key

* id

### Foreign Keys

* Referenced by:

  * orders.user_id
  * order_items.user_id

### Important Columns

* id
* age
* gender
* city
* state
* country
* traffic_source
* created_at

### Business Usage

Used for:

* Customer segmentation
* Geographic analysis
* Customer acquisition analysis
* Traffic source performance analysis
* Customer lifetime value analysis
* New customer growth analysis

---

## 2. Orders Table

### Purpose

Stores order-level information.

Each record represents a customer order.

### Primary Key

* order_id

### Foreign Keys

* user_id → users.id

### Important Columns

* order_id
* user_id
* status
* created_at
* shipped_at
* delivered_at
* returned_at
* num_of_item

### Business Usage

Used for:

* Order trend analysis
* Order volume tracking
* Delivery performance analysis
* Return analysis
* Customer purchase behavior analysis

---

## 3. Order_Items Table

### Purpose

Stores product-level transaction details.

Each row represents a single product purchased within an order.

### Primary Key

* id

### Foreign Keys

* order_id → orders.order_id
* user_id → users.id
* product_id → products.id

### Important Columns

* id
* order_id
* user_id
* product_id
* sale_price
* status
* created_at
* delivered_at
* returned_at

### Business Usage

Used for:

* Revenue analysis
* Product performance analysis
* Customer purchasing analysis
* Sales trend analysis
* Return rate analysis

Note:
This is the most important fact table for the project because revenue is stored here.

---

## 4. Products Table

### Purpose

Stores product catalog information.

### Primary Key

* id

### Foreign Keys

* distribution_center_id → distribution_centers.id

### Important Columns

* id
* category
* name
* brand
* department
* retail_price
* cost

### Business Usage

Used for:

* Product performance analysis
* Category analysis
* Brand analysis
* Profitability analysis
* Product portfolio analysis

Profit Calculation:

Profit = Sale Price - Cost

```

Used together with Order_Items to determine profitability.
```
