# HomeServer

This is a generalisation of a utility that I wrote for my work machine.
The initial version was an application that would send me a desktop notification popup should the VPN client fail.

This was my first experiment with mix release. I found it a bit awkward to shut down, but realised that I could add a simple
web gui to enable a clean shutdown.

This runs a cowboy http server on port 1066

It currently supports the endpoints /control and /shutdown

The idea is to have this running in the background and to perform tasks on a regular basis.
