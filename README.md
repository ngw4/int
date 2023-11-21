# Events
A simple module made to replicate RBXScriptSignals without the use of Instances.

# Usage
> A short demonstration of how this module could be used.
```lua
-- Require the module.
local Event = require(path)

-- Create a new event.
local event = Event.new()

-- Connect a function to run when the event is fired.
event:Connect(function()
  print("Event fired.")
end)

-- Temporarily connect a function to the event.
event:Once(function(arg)
  print("recieved" .. tostring(arg))
end)

-- Create a new thread to fire the event after 3 seconds. (task.spawn is exclusive to the Roblox game engine.)
task.delay(3, function()
  -- Fire the event with number 12 as the first argument.
  event:_Fire(12)
end)

-- Yields the script until the event has fired.
event:Wait()
```
