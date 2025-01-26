# gRPC Example: Client-Server Communication
This example demonstrates how to implement a simple client-server communication using gRPC in Go.   
The client sends messages to the server using menu options, and the server responds accordingly.
## Directory Structure
```text
grpc-example/
├── client/
│   └── main.go
├── server/
│   └── main.go
└── proto/
    └── example.proto
```
## Pre-requisites
- Go 1.16 or higher
- Protocol Buffers v3 (for ubuntu: `sudo apt install -y protobuf-compiler`, for fedora: `sudo dnf install -y protobuf-compiler`)
- Add the Go Protocol Buffers plugin to your PATH: `export PATH="$PATH:$(go env GOPATH)/bin"`

## Build Instructions
### 1. Create the directory structure
```bash
mkdir -p grpc-example/{client,server,proto}
```
### 2. Install Required tools
```bash
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
```
### 3. Initialize Go Modules
From the root `grpc-example/` directory, run the following command:
```bash
go mod init grpc-example
```
### 4. Write the example.proto file
In the proto/ directory, create a file named `example.proto` with the following content:
```proto
syntax = "proto3";

package examplepb;

option go_package = "./examplepb";

service Greeter {
    rpc SayHello (HelloRequest) returns (HelloReply);
}

message HelloRequest {
    string name = 1;
}

message HelloReply {
    string message = 1;
}
```
### 5. Generate the Go code from Proto
From the root `grpc-example/` directory, run the following command:
```bash
protoc --go_out=. --go-grpc_out=. proto/example.proto
```
This generates:
- `grpc-example/examplepb/example.pb.go`
- `grpc-example/examplepb/example_grpc.pb.go`
### 6. Write Server Code
In the server/ directory, create a file named `main.go`with the following content:
```go
package main

import (
	"context"
	"log"
	"net"

	"grpc-example/examplepb"

	"google.golang.org/grpc"
)

type greeterServer struct {
	examplepb.UnimplementedGreeterServer
}

func (s *greeterServer) SayHello(ctx context.Context, req *examplepb.HelloRequest) (*examplepb.HelloReply, error) {
	log.Printf("Client: %v", req.GetName())
	var replyMessage string
	switch req.GetName() {
	case "HELLO CS 616":
		replyMessage = "Oh Hello! Hope you're enjoying CS 616"
	case "How are you?":
		replyMessage = "All good, wbu?"
	case "What's up?":
		replyMessage = "Nothing much, just chatting with you..."
	default:
		replyMessage = "Hmm, don't know what to reply..."
	}
	return &examplepb.HelloReply{Message: replyMessage}, nil
}

func main() {
	listener, err := net.Listen("tcp", ":50051")
	if err != nil {
		log.Fatalf("Failed to listen: %v", err)
	}

	grpcServer := grpc.NewServer()
	examplepb.RegisterGreeterServer(grpcServer, &greeterServer{})

	log.Println("Server is running on port 50051")
	if err := grpcServer.Serve(listener); err != nil {
		log.Fatalf("Failed to serve: %v", err)
	}
}
```
### 7. Write Client Code
In the client/ directory, create a file named `main.go` with the following content:
```go
package main

import (
	"bufio"
	"context"
	"fmt"
	"log"
	"os"
	"time"

	"grpc-example/examplepb"

	"google.golang.org/grpc"
)

func main() {
	conn, err := grpc.Dial("localhost:50051", grpc.WithInsecure())
	if err != nil {
		log.Fatalf("Failed to connect: %v", err)
	}
	defer conn.Close()

	client := examplepb.NewGreeterClient(conn)

	reader := bufio.NewReader(os.Stdin)

	for {
		fmt.Println("Menu:")
		fmt.Println("1. Send 'HELLO CS 616'")
		fmt.Println("2. Send 'How are you?'")
		fmt.Println("3. Send 'What's up?'")
		fmt.Println("4. Send custom message")
		fmt.Println("5. Exit")
		fmt.Print("Enter your choice: ")

		choice, _ := reader.ReadString('\n')
		choice = choice[:len(choice)-1] // Remove the newline character

		var message string
		switch choice {
		case "1":
			message = "HELLO CS 616"
		case "2":
			message = "How are you?"
		case "3":
			message = "What's up?"
		case "4":
			fmt.Print("Enter your custom message: ")
			message, _ = reader.ReadString('\n')
			message = message[:len(message)-1] // Remove the newline character
		case "5":
			fmt.Println("Exiting...")
			return
		default:
			fmt.Println("Invalid choice. Please try again.")
			continue
		}

		ctx, cancel := context.WithTimeout(context.Background(), time.Second)
		defer cancel()

		resp, err := client.SayHello(ctx, &examplepb.HelloRequest{Name: message})
		if err != nil {
			log.Fatalf("Could not greet: %v", err)
		}
		log.Printf("Client: %s", message)
		log.Printf("Server: %s", resp.GetMessage())
	}
}
```
### 8. Tidy Up Dependencies
From the root `grpc-example/` directory, run the following command:
```bash
go mod tidy
```
### 9. Run the Server
In one terminal, navigate to the server/ directory and run the following command:
```bash
go run main.go
```
### 10. Run the Client
In another terminal, navigate to the client/ directory and run the following command:
```bash
go run main.go
```
### Interact with the Client
When you run the client, you'll see the following menu:
```text
Menu:
1. Send 'HELLO CS 616'
2. Send 'How are you?'
3. Send 'What's up?'
4. Send custom message
5. Exit
Choose an option:
```
You can choose any of the options to send a message to the server. The server will respond accordingly.


## Example Output
### Server Console
```text
Server is running on port 50051
Received message: HELLO CS 616
Received message: What's up?
```
### Client Console
```text
Menu:
1. Send 'HELLO CS 616'
2. Send 'How are you?'
3. Send 'What's up?'
4. Send custom message
5. Exit
Enter your choice: 1
Client: HELLO CS 616
Server: Oh Hello! Hope you're enjoying CS 616
Menu:
1. Send 'HELLO CS 616'
2. Send 'How are you?'
3. Send 'What's up?'
4. Send custom message
5. Exit
Enter your choice: 3
Client: What's up?
Server: Nothing much, just chatting with you...
Menu:
1. Send 'HELLO CS 616'
2. Send 'How are you?'
3. Send 'What's up?'
4. Send custom message
5. Exit
Enter your choice: 
