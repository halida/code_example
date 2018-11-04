#!/usr/bin/env python

# WS client example

import sys
import asyncio
import websockets

async def hello_client():
    async with websockets.connect('ws://localhost:8765') as websocket:
        name = input("What's your name? ")

        await websocket.send(name)
        print(f"client> {name}")

        greeting = await websocket.recv()
        print(f"client< {greeting}")

def main_client():
    asyncio.get_event_loop().run_until_complete(hello_client())


async def hello_server(websocket, path):
    name = await websocket.recv()
    print(f"server< {name}")

    greeting = f"Hello {name}!"

    await websocket.send(greeting)
    print(f"server> {greeting}")

def main_server():
    start_server = websockets.serve(hello_server, 'localhost', 8765)

    asyncio.get_event_loop().run_until_complete(start_server)
    asyncio.get_event_loop().run_forever()

def main():
    cmd = sys.argv[1]
    print("cmd: {}".format(cmd))
    if cmd == 'server': main_server()
    if cmd == 'client': main_client()
    
if __name__ == "__main__":
    main()
