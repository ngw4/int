# Events
A simple module made to replicate RBXScriptSignals without the use of Instances.

# Usage
> A short demo on how to use this module.
```lua
-- Require the module.
local Event = require(path)

-- Create a new event.
local event = Event.new()

-- Connect a function to run when the event is fired.
event:Connect(function(arg: any)
  print("Recieved" .. tostring(arg))
end)

-- Temporarily connect a function to the event.
event:Once(function(arg: any)
  print("Recieved" .. tostring(arg))
end)

-- Create a new thread to fire the event after 3 seconds. (task.spawn is exclusive to the Roblox game engine.)
task.delay(3, function()
  -- Fire the event with number 12 as the first argument.
  event:_Fire(12)
end)

-- Yields the script until the event has fired.
local arg = event:Wait()

print("Event fired, finished yielding. \n Recieved:" .. arg)
```
