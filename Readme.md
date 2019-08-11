# Chat API

This API utilizes Ruby on rails to create a chat system that lets you create and list applications, chats and messages, and the ability to search through messages

### Installation

- Lets setup and install the API. First, please make sure that you have Docker & Docker Compose installed on your machine. Then run `docker-compose build` to download necessary docker images and install dependencies.
- Run `docker-compose up` to run all services. If you choose not to run the build command it will download dependencies only when you run it for the first time. To utilize the machine scaling you may want to append "compatibility" flag `docker-compose up --compatibility`

### CLI APP

- To run the app through terminal, make sure that you have Golang installed on your machine.
- Run `go run chatapi.go --help` to know more about how to use it.
- Basically, you run `go run chatapi.go --action=action-model` where actions: [list | add | find] & models: [app | chat | message]. This flag is required for all operations.
- Examples:
    - `go run chatapi.go --action=add-app --name=firstapp` → creates new application.
    - `go run chatapi.go --action=list-app` → show list of all applications
    - `go run chatapi.go --action=list-chat --token=SampleToken` → list chats for a certain application.
    - `go run chatapi.go --action=find-message --token=SampleToken --chat=1 keyword=Hello` → find all messages in a chat with the keyword 'Hello'
