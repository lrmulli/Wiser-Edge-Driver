local capabilities = require "st.capabilities"
local Driver = require "st.driver"
local log = require "log"

local hbactivity_command_handlers = require "hbactivity_command_handlers"


local room_handler = {
NAME = "RoomHandler",
  capability_handlers = {
    [capabilities.switch.ID] = {
        [capabilities.switch.commands.on.NAME] = hbactivity_command_handlers.switch_on,
        [capabilities.switch.commands.off.NAME] = hbactivity_command_handlers.switch_off,
        }
    },
  can_handle = function(opts, driver, device, ...)
    return device:component_exists("roomlogger")
  end,
}

return room_handler