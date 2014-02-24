README.txt

OSC Server and Client examples
==============================
This is an example of many clients to one server. Use 'c' to connect the client to the server and 'd' to disconnect.


How many computers do I need?
=============================
You can only test one client + one server on the same computer. For multiple clients, you'll need multiple computers

Only one computer is needed if you have...

- One server
- One client

At least two computers are needed if you have...

- One server
- Two clients (one client sharing same computer with server)

Three computers is ideal if you have...

- One server (server has own computer)
- Two clients (each client has own computer)


IP Addresses & Ports
====================
The IP Address set in the clients must be set to the server computer's IP Address and both incoming and outgoing ports.


OSC Message formatting
======================
The client sketches are set up to dynamically add a number to the address pattern any OSC message being sent to the server. This way you can have clients sharing the same code, if necessary. 


OTHER
=====
Don't worry if this is still a bit confusing at this point. Play with the examples and make sure you can get at least one client to connect and disconnect reliably. Modify the sketches to change the interaction on the client side and the result on the server side. Go through the code for both the client and server to see what's new.

We'll discuss everything in class next week.