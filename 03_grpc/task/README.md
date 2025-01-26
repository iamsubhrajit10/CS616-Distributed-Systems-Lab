# Problem Statement: Build a Banking Debit-Credit Application Using Go gRPC

## Objective
Implement a gRPC-based banking application that allows multiple clients to interact with a server to:
- View their account balance.
- Credit an amount to their account.
- Debit an amount from their account (with insufficient funds check).

## Functional Requirements

### Account Management
- Each user has an account with a unique `account_id`.
- The account holds a balance, which starts at ₹10,000 for all users.

### Operations
- **View Balance**: Fetch the current balance for a given `account_id`.
- **Credit**: Add a specified amount to the account.
- **Debit**: Subtract a specified amount from the account. The server must return an error if the balance is insufficient.
## Diagram: System Architecture

```plaintext
+--------------------+
|    gRPC Client     |
|--------------------|
| - View Balance     |
| - Credit Amount    |
| - Debit Amount     |
+--------------------+
         |
    gRPC Request
         v
+--------------------+
|    gRPC Server     |
|--------------------|
| - BankService      |
| - GetBalance()     |
| - CreditAmount()   |
| - DebitAmount()    |
+--------------------+
         |
   Account Lookup
         v
+--------------------+
| Account Database   |
|--------------------|
| - Account ID       |
| - Balance          |
+--------------------+
```

## gRPC Service
Define a gRPC service with the following methods:
- `GetBalance(AccountRequest) -> BalanceResponse`
- `CreditAmount(CreditRequest) -> TransactionResponse`
- `DebitAmount(DebitRequest) -> TransactionResponse`

## Technical Specifications

### Proto File
Define the `BankService` in a `.proto` file, which includes:

#### Messages
- `AccountRequest`: Includes `account_id`.
- `BalanceResponse`: Includes `account_id` and `balance`.
- `CreditRequest`/`DebitRequest`: Includes `account_id` and `amount`.
- `TransactionResponse`: Includes `account_id`, `new_balance`, and a success/failure message.

#### Service
- `BankService`: Defines the three gRPC methods.

### Server Implementation
- Implement the server logic to handle debit, credit, and balance retrieval.
- Use a simple in-memory data structure (e.g., a map) to store account balances.

### Client Implementation
- Write a client program that provides a menu-based interface:
  - View balance.
  - Credit account.
  - Debit account.

## Expected Workflow

### Server Startup
- Starts the gRPC server on a specific port (e.g., `localhost:50052`).
- Initializes a few accounts for testing (e.g., `Account-101`, `Account-102`).

### Client Interaction
The client connects to the server and allows users to interact using a menu system:

```text
Menu:
1. View Balance
2. Credit Amount
3. Debit Amount
4. Exit
Choose an option:
```

### Sample Interaction
- Client sends a `GetBalance` request for `Account-101`.
- Client sends a `CreditAmount` request to add ₹5,000 to `Account-101`.
- Client sends a `DebitAmount` request to withdraw ₹2,000 from `Account-101`.
- Server responds with appropriate balance updates or error messages.



## Probable Directory Structure
```
grpc-banking/
  ├── proto/
  │   └── banking.proto
  ├── server/
  │   └── main.go
  ├── client/
  │   └── main.go
  └── README.md
```
