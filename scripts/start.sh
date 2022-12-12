#!/usr/bin/env bash
screen -d -m /home/quake3esrv/quake3e/quake3e.ded.arm +exec server.cfg
tail -f /dev/null
