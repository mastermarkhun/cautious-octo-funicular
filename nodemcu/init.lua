--This file is init.lua
print("Setting up wifi...")
wifi.setmode(wifi.STATION)
wifi.sta.config("SSID","PASSWORD")
wifi.sta.sethostname("NodeMCU-DenonSerialPort")
wifi.sta.connect()

local IDLE_AT_STARTUP_MS = 10000;

tmr.alarm(1,IDLE_AT_STARTUP_MS,0,function()
    dofile("servertry.lua")
end)
