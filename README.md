# HomeServer

This is a generalisation of a utility that I wrote for my work machine.
The initial version was an application that would send me a desktop notification popup should the VPN client fail.

This was my first experiment with mix release. I found it a bit awkward to shut down, but realised that I could add a simple
web gui to enable a clean shutdown.

This runs a cowboy http server on port 1066

It currently supports the endpoints /control and /shutdown

The idea is to have this running in the background and to perform tasks on a regular basis.

This is the utility that needs to be installed for the notifications to work.

```
brew install terminal-notifier
```

There is an optional control file called `.home-server.yml` that need to live in the users home directory

```
bbc:
  test_url: https://bbc.co.uk
  interval_seconds: 60
  title: BBC
  message: Internet connection is down  
```

You can have multiple of these block (but the names must be unique).

To test a vpn find an http get url that is only visible when the vpn is up!

I am working on getting the process names to be defined so that :observer.start displays name processes.