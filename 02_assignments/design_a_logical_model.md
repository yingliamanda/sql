# Assignment 1: Design a Logical Model

## Question 1
Create a logical model for a small bookstore. 📚

At the minimum it should have employee, order, sales, customer, and book entities (tables). Determine sensible column and table design based on what you know about these concepts. Keep it simple, but work out sensible relationships to keep tables reasonably sized. Include a date table. There are several tools online you can use, I'd recommend [_Draw.io_](https://www.drawio.com/) or [_LucidChart_](https://www.lucidchart.com/pages/).



## Question 2
We want to create employee shifts, splitting up the day into morning and evening. Add this to the ERD.

## Question 3
The store wants to keep customer addresses. Propose two architectures for the CUSTOMER_ADDRESS table, one that will retain changes, and another that will overwrite. Which is type 1, which is type 2?

_Hint, search type 1 vs type 2 slowly changing dimensions._

Bonus: Are there privacy implications to this, why or why not?
```
Your answer...
Type 1 SCD: Overwrite Architecture

In a Type 1 SCD, changes to the customer's address are overwritten in the database. This means the current address is always updated and previous addresses are not retained.
CustomerAddress Table (Type 1)
CustomerAddress
CustomerID (Primary Key, Foreign Key referencing Customer.CustomerID)
Address
City
State
ZipCode
Country
LastUpdated (Timestamp of the last update)

Type 2 SCD: Retain Changes Architecture
In a Type 2 SCD, changes to the customer's address are retained in the database. This means that a history of address changes is kept, and each change creates a new record.

CustomerAddress Table (Type 2)

CustomerAddress
AddressID (Primary Key)
CustomerID (Foreign Key referencing Customer.CustomerID)
Address
City
State
ZipCode
Country
StartDate (Date when the address became effective)
EndDate (Date when the address was no longer effective, can be NULL for current address)
IsCurrent (Boolean flag indicating if this is the current address)


Type 1 SCD: Overwrites the existing data. The table keeps only the current address, with no history of previous addresses.
Type 2 SCD: Retains the historical data. The table keeps a record of all previous addresses along with the current address, allowing you to track changes over time.

Choosing between Type 1 and Type 2 SCDs depends on the business requirements and how important it is to retain historical data. Type 1 is simpler and has fewer privacy implications, while Type 2 provides a complete historical view but requires careful handling of privacy and regulatory concerns.
```

## Question 4
Review the AdventureWorks Schema [here](https://i.stack.imgur.com/LMu4W.gif)

Highlight at least two differences between it and your ERD. Would you change anything in yours?
```
Your answer...

Differences Highlighted
Normalization and Complexity:

AdventureWorks: The schema is highly normalized and contains many more tables to handle specific aspects of the business in detail. For instance, there are separate tables for addresses (Address), customers (Customer), sales orders (SalesOrderHeader, SalesOrderDetail), products, and even subcategories and categories for products.
Bookstore ERD: The proposed ERD for the bookstore is simpler, with fewer tables. It combines several aspects into fewer tables for simplicity and ease of understanding. For instance, customer addresses are part of the Customer table, and sales are directly tied to orders without intermediate detailed tables.
Address Management:

AdventureWorks: Manages addresses separately with a distinct Address table, which can be linked to multiple entities such as customers and vendors through junction tables like CustomerAddress.
Bookstore ERD: Initially, customer addresses were included directly in the Customer table. After the consideration of SCD, a CustomerAddress table was proposed with options for Type 1 and Type 2 implementations.

Changes to Consider in the Bookstore ERD
Based on the differences highlighted from the AdventureWorks schema, here are potential changes to the bookstore ERD:

Normalization of Addresses:

1 Proposal: Introduce a separate Address table and a junction table CustomerAddress to manage multiple addresses for customers and to keep the design normalized.
2 Detailed Order Management:

Proposal: Split the order management into more detailed tables, similar to how AdventureWorks handles it. Create separate OrderHeader and OrderDetail tables for better clarity and normalization.

Conclusion
Incorporating a separate Address table and detailed order management tables aligns the bookstore ERD more closely with the normalized and scalable design principles seen in the AdventureWorks schema. This change improves data organization and supports future scalability, although it adds some complexity to the initial design.

```

# Criteria

[Assignment Rubric](./assignment_rubric.md)

# Submission Information

🚨 **Please review our [Assignment Submission Guide](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md)** 🚨 for detailed instructions on how to format, branch, and submit your work. Following these guidelines is crucial for your submissions to be evaluated correctly.

### Submission Parameters:
* Submission Due Date: `HH:MM AM/PM - DD/MM/YYYY`
* The branch name for your repo should be: `model-design`
* What to submit for this assignment:
    * This markdown (design_a_logical_model.md) should be populated.
    * Two Entity-Relationship Diagrams (preferably in a pdf, jpeg, png format).
* What the pull request link should look like for this assignment: `https://github.com/<your_github_username>/sql/pull/<pr_id>`
    * Open a private window in your browser. Copy and paste the link to your pull request into the address bar. Make sure you can see your pull request properly. This helps the technical facilitator and learning support staff review your submission easily.

Checklist:
- [ ] Create a branch called `model-design`.
- [ ] Ensure that the repository is public.
- [ ] Review [the PR description guidelines](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md#guidelines-for-pull-request-descriptions) and adhere to them.
- [ ] Verify that the link is accessible in a private browser window.

If you encounter any difficulties or have questions, please don't hesitate to reach out to our team via our Slack at `#cohort-3-help`. Our Technical Facilitators and Learning Support staff are here to help you navigate any challenges.