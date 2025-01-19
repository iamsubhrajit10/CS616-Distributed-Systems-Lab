# Docker Compose Setup for Python Server and Client

This project sets up a simple client-server architecture using Docker and Flask. The server responds to specific messages, while the client allows manual interaction to send messages to the server.

## Project Structure

```plaintext
/.../02_docker_client-server/docker-compose-setup/
├── client/
│   ├── Dockerfile
│   └── app.py
├── server/
│   ├── Dockerfile
│   └── app.py
├── docker-compose.yml
└── README.md
```


## Requirements

- Docker
- Docker Compose

## How to Run

1. **Build the Docker images**: Run the following command in the project root directory:
   ```sh
   docker-compose build
   ```

2. **Run the server**: Start the server service using Docker Compose:
   ```sh
   docker-compose up server
   ```
3. **Run the client manually**: Open a new terminal window or tab, navigate to the project directory, and run the client container:
   ```sh
   docker-compose run client /bin/bash
   ```
4. **Inside the client container, run the client application**: Run the following command to start the client application:
   ```sh
   python app.py
   ```
5. **Interact with the client**: Use the menu options to send messages to the server:
   - Menu:
     - 1. Send 'HELLO CS 616'
     - 2. Send 'How are you?'
     - 3. Send 'What's up?'
     - 4. Send custom message
     - 5. Exit

## Stop the Application
To stop the application, press `Ctrl+C` in the terminal where the server is running. Then, run the following command to stop and remove the Docker containers:
```sh
docker-compose down
```   

## Additional Notes

- The server listens for HTTP POST requests at the /message endpoint and responds based on the message received. It listens on port 5000. And only accepts messages in the format 'HELLO CS 616'. Any other message will return 'That's does not look legitimate!'.
- The client provides a menu for manually sending messages to the server and prints the responses in the console.

Feel free to modify the server and client applications to add more functionality or customize the behavior as needed.
