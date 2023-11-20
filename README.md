# Events
A simple module made to replicate RBXScriptSignals without the use of Instances.

# Usage
> A short demonstration of how this module could be used.
```lua
local Event = require(path)

local event = Event.new()

event:Connect(function()
  print("Event fired.")
end)

event:Once(function(arg)
  print("recieved" .. tostring(arg))
end)

task.delay(3, function()
  event:_Fire(12)
end)

event:Wait()
```
