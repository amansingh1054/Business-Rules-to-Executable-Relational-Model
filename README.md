# Business Rules to Executable Relational Model

A MySQL internship-management database that enforces core business rules through keys, constraints, and a trigger.

## Project objectives
- Model students, companies, internships, applications, and offers.
- Enforce data integrity at database level.
- Provide seed fixtures and negative SQL tests.

## Requirements
- MySQL 8.0.16+ recommended (for enforced `CHECK` constraints).
- MySQL Command Line Client or MySQL Workbench.

## Setup
Run these files in order in MySQL:
1. `001_create_schema.sql`
2. `002_business_rules.sql`
3. `003_seed_data.sql`

Run `004_negative_tests.sql` one statement at a time. Every statement in that file is intentionally invalid and should return an error. Do not run the whole test file as one batch if your client stops after the first error.

## Five core business rules

| # | Rule | Enforcement |
|---|---|---|
| 1 | Student email must be unique | `UNIQUE` on `Students.email` |
| 2 | Company email must be unique | `UNIQUE` on `Companies.email` |
| 3 | Application must reference an existing student and internship | Foreign keys |
| 4 | A student may apply to an internship only once | `UNIQUE(student_id, internship_id)` |
| 5 | Only selected applications may receive offers | `BEFORE INSERT` trigger |

Additional rule: internship seats must be greater than zero (`CHECK (seats > 0)`).

## ER diagram

```mermaid
erDiagram
    STUDENTS ||--o{ APPLICATIONS : submits
    INTERNSHIPS ||--o{ APPLICATIONS : receives
    COMPANIES ||--o{ INTERNSHIPS : offers
    APPLICATIONS ||--o| OFFERS : may_receive

    STUDENTS {
        int student_id PK
        varchar name
        varchar email UK
        varchar department
    }
    COMPANIES {
        int company_id PK
        varchar name
        varchar email UK
    }
    INTERNSHIPS {
        int internship_id PK
        int company_id FK
        varchar title
        int seats
        enum status
    }
    APPLICATIONS {
        int application_id PK
        int student_id FK
        int internship_id FK
        enum status
        timestamp applied_at
    }
    OFFERS {
        int offer_id PK
        int application_id FK_UK
        timestamp offered_at
        enum status
    }
```

## Rule-to-constraint matrix

| Business rule | SQL object | Negative test |
|---|---|---|
| Unique student email | `Students.email UNIQUE` | Test 1 |
| Unique company email | `Companies.email UNIQUE` | Test 2 |
| Existing student/internship required | Foreign keys on `Applications` | Test 3 |
| No duplicate application | Composite unique key | Test 4 |
| Offer only for selected application | `validate_offer_before_insert` trigger | Test 5 |
| Positive internship seats | `CHECK (seats > 0)` | Test 6 |

## Verification queries

```sql
USE InternshipDB;
SHOW TABLES;
SELECT * FROM Students;
SELECT * FROM Companies;
SELECT * FROM Internships;
SELECT * FROM Applications;
SELECT * FROM Offers;
```

## Notes
- The seed script is intended for a fresh database. If you run it repeatedly, unique email constraints will reject duplicate fixture rows.
- The offer trigger validates the application status when an offer is inserted. Any production workflow should also manage selection and offer issuance within appropriate transactions.
- The example data is fictional.
