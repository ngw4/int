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
    #   25.11.2023 - 27.11.2023
    /   https://github.com/ngw4/int/

    -------------------------------------------------------------------------------
    
]]--

-- || MODULES

local Event = require(script.Parent.Event)

-- || TYPES

export type Value = {
	Value: any,
	Changed: Event.Event,

}

-- || VARIABLES

local Value = {}
local ValueClass = {} :: Value

-- || FUNCTIONS


--[[
    @param      value        any       | the data you want to initialize with.
    @return     Value

	Creates a new Value.
]]

function Value.new(value: any): Value
	local self = setmetatable({
		_ActualValue = value,
		Changed = Event.new(), 
	}, ValueClass)

	return self
end


--[[
    @param      self        Value       | The value itself.
    @return     any

	Retrieves the value.
]]

function ValueClass.__index(self: Value, key: string)
	if key ~= "Value" then return end
	return rawget(self, "_ActualValue")
end


--[[
    @param      self        Value       | The value itself.
    @param      key        	string      | What has been indexed.
    @param      value       any			| the value which is being set.
    @return     any

	Sets the value.
]]

function ValueClass.__newindex(self: Value, key: string, value: any)
	if key ~= "Value" then return end 
	rawset(self, "_ActualValue", value)
	self.Changed:_Fire(value)
end

-- || MAIN

return Value
