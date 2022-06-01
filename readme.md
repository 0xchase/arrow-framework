# Arrow Framework

## Components

 - **cli**: Connects and controls the C2 server
 - **server**: A server to catch implant callbacks
 - **implant**: Self explanatory
 - **payloads**: Can be loaded by the implant
 - **scanner**: Uses rustscan in the backend
 - **gui**: A frontend on the C2 library

## Design
 - Cli is a cli interface to the control lib
 - Control is a library to control the C2 server. Communicates JSON back and forth.
 - Gui is a GUI library that loads the control library and uses JSON. 
   - Menu
     - Menu options for all hosts on the top
     - Right click on a host for other menu options
   - Menu options
     - Scan: ping hosts, fingerprint OS, fingerprint important ports, fingerprint all ports
   - Always show
     - System terminal
     - Arrow command line
   - Sidebar
     - Network: graph of all hosts, list of all hosts with attributes
     - Sessions: List of all sessions on hosts
 - Implant is an implant
   - Dynamic library payloads
   - Executable payloads
   - Webassembly payloads
 - Scanner is a network scanner that uses rustscan
 - Popup notification when a client connects

### Functionality
 - Network scanning and host fingerprinting
 - Display hosts in a useful way
 - Run exploits against hosts
 - Display host sessions
 - Run post-exploitation against hosts

### Views
 - Network view (graph of network)
 - Host view (host fingerprint, vuln scan, etc)
 - Sessions view (all current sessions)
