local log = require "log"
local capabilities = require "st.capabilities"

local wiser = {}

-- callback to handle an `on` capability command
function wiser.makeApiGetCall(driver,device,path)
  local url = "http://"..device.preferences.deviceaddr..path
  log.debug("Making API Call to ",url)
end

return wiser