--[[

    ###############################################################################
    ###############################################################################
    ####      #####    #######     #######    ####     ####    #####        #######
    ####       ####    ####           ####    ####     ####    ####         #######
    ####        ###    ###     ############    ##       ##    ####    ###   #######
    ####         ##    ##    ####       ###    ##       ##    ###    ####   #######
    ####    #     #    ##    #######    ####    #   ##   #   ###    #####      ####
    ####    ##         ###     ####    #####        ##       ##                ####
    ####    ###        ####           #######      ####     ###########     ####### 
    ####    #####      #######     ##########      ####     ###########     #######
    ###############################################################################
    ###############################################################################

    -------------------------------------------------------------------------------

    @   ngw4
    #   20.11.2023
    /   https://github.com/ngw4/Events

    -------------------------------------------------------------------------------
    
]]--

-- || TYPES

type Callback = (...any) -> any

export type Connection = {
    -- FUNCTIONS
    Disconnect: () -> (),

    -- PROPERTIES
    Connected: boolean,
    _Index: number,
    _Callbacks: Event
}

export type Event = {
    -- FUNCTIONS
    Connect: (self: Event, f: Callback) -> Connection,
    Once: (self: Event, f: Callback) -> Connection,
    Wait: (self: Event) -> (...any),
    _Fire: (self: Event, ...any) -> (), 
    _newConnection: (self: Event, f: Callback) -> Connection,

    -- PROPERTIES
    Connections: { Connection },
    Callbacks: { Callback },
    TemporaryCallbacks: { Callback }
}

-- || VARIABLES

local Event = {} :: Event
local Connection = {} :: Connection

-- || FUNCTIONS

--[[
    @return     Event

    creates a new Event.
]]--

function Event.new(): Event
    local self = setmetatable({}, {__index = Event})

    self.Connections = {}
    self.Callbacks = {}
    self.TemporaryCallbacks = {}

    return self
end

--[[
    @param      self         Event       | the event itself.
    @param      f            Callback    | the function to connect.
    @return     Connection

    connects a function to the Event.
]]

function Event:Connect(f: Callback): Connection
    table.insert(self.Callbacks, f)

    return self:_newConnection(f)
end

--[[
    @param      self         Event       | the event itself.
    @param      f            Callback    | the function to connect.
    @return     Connection

    temporarily connects a function to the Event.
]]

function Event:Once(f: Callback): Connection
    table.insert(self.TemporaryCallbacks, f)

    return self:_newConnection(f, true)
end

--[[
    @param      self         Event       | the event itself.
    @return     ...any

    waits for the event to be fired.
]]

function Event:Wait()
    local currentThread = coroutine.running()

    self:Once(function(...)
        coroutine.resume(currentThread, ...)
    end)

    return coroutine.yield()
end

function Event:_Fire(...: any): ()
    for _, callback in self.Callbacks do
        task.spawn(callback, ...)
    end

    for index, tempCallback in self.TemporaryCallbacks do
        task.spawn(tempCallback, ...)
        table.remove(self.TemporaryCallbacks, index)
    end
end

--[[
    @param      self         Event       | the event itself.
    @param      ...          any         | the arguments to fire the event with. 
    @return     void
]]

--[[
    @param      self         Event       | the event itself.
    @param      f            Callback    | the function which has been connected.
    @param      isTemporary  boolean     | a boolean to distinguish between temporary and normal connections.
    @return     Connection

    creates a new connection.
]]

function Event:_newConnection(f: Callback, isTemporary: boolean?): Connection
    local callbacks = if isTemporary then self.TemporaryCallbacks else self.Callbacks

    local self = setmetatable({
        Connected = true,
        _Index = table.find(callbacks, f),
        _Callbacks = callbacks
    }, {__index = Connection})

    return self
end


-- || MAIN

return Event
