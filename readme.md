# Arrow Framework

## Components

 - **cli**: Connects and controls the C2 server
 - **server**: A server to catch implant callbacks
 - **implant**: Self explanatory
 - **payloads**: Can be loaded by the implant
 - **scanner**: Uses rustscan in the backend
 - **gui**: A frontend on the C2 library

### Functionality
 - Network scanning and host fingerprinting
 - Display hosts in a useful way
 - Run exploits against hosts
 - Display host sessions
 - Run post-exploitation against hosts

### Views
 - Network view (graph of network)
 - Host view (Show host details. Actions to exploit host. Etc)
 - Sessions view (all current sessions)
 - Command line

### Plugin system
 - Communicates by sending JSON over stdin/stdout
 - Functions:
   - initialize(json)
   - commands() -> json
   - run(command, callback)
