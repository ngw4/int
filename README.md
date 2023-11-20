# Events
A simple module made to replicate RBXScriptSignals without the use of Instances.

# Usage
> A demonstration of how this module is used.
```lua
local Event = require(path)

local event = Event.new()

event:Connect(function()
  print("Event fired.")
end)

event:Once(function(arg)
  print("recieved" .. tostring(arg))
)

task.delay(3, function()
  event:_Fire(12)
end)

event:Wait()
```
