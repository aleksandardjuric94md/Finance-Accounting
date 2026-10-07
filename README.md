# Finance-Accounting Portfolio Mini Project

---

## 1. What's the business problem?
- A company stores invoices and customer payments in separate tables.
- However,there is no reliable report showing whether an invoice **has been paid**

<br>

The client requested a solution (stored procedure) that would help answer the following questions:
- Has the customer paid the invoice?
- Has the customer paid only part of the invoice?
- How much does the customer still owe?
- How does the customer's balance change over time?

### 1.1. What's the challenge?
- The main challenge is that payments are not always directly linked to a specific invoice.
- Therefore, payment status cannot always be determined by simply joining an invoice to a payment record.

### 1.2. How are the tables structured in the database?


---

## 2. Data Model

The project contains the following tables:

- `Customers` – customer master data;
- `InvoiceServices` – services that can appear on an invoice;
- `Invoices` – customer invoices and their amounts;
- `Payments` – customer payment transactions.

In other words, the main relationships are:

```text
Customers
   ├── Invoices
   │      └── InvoiceServices
   └── Payments

<br>

Picture bellow:
<img width="1020" height="812" alt="image" src="https://github.com/user-attachments/assets/fc475c04-3302-4629-b4a3-ba1c59d8eba9" />


<br>

---

## 3. How to solve the problem?
### 3.1. Stored procedure
The goal is to develop a reporting procedure (**spGetInvoicePayingDetails**) that:

- combines invoice and payment transactions
- orders transactions chronologically for each customer
- calculates a cumulative customer balance
- estimates whether an invoice has been paid by its due date
- supports filtering by a specific customer or returning results for all customers.

---

## 3. Conclusion



---
