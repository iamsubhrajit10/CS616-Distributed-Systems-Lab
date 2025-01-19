import requests

def send_message(message):
    server_url = "http://server:5000/message"
    response = requests.post(server_url, json={'message': message})
    print(f"Sent: {message} - Received: {response.json().get('response')}")

def main():
    while True:
        print("\nMenu:")
        print("1. Send 'HELLO CS 616'")
        print("2. Send 'How are you?'")
        print("3. Send 'What's up?'")
        print("4. Send custom message")
        print("9. Exit")
        
        choice = input("Enter your choice: ")
        
        if choice == '1':
            send_message("HELLO CS 616")
        elif choice == '2':
            send_message("How are you?")
        elif choice == '3':
            send_message("What's up?")
        elif choice == '4':
            custom_message = input("Enter your custom message: ")
            send_message(custom_message)
        elif choice == '9':
            print("Exiting...")
            break
        else:
            print("Invalid choice. Please try again.")

if __name__ == "__main__":
    main()