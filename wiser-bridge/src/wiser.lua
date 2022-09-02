local log = require "log"
local capabilities = require "st.capabilities"

local wiser = {}

-- callback to handle an `on` capability command
function wiser.makeApiGetCall(driver,device,path)
  local url = "http://"..device.preferences.deviceaddr..path
  log.debug("Making API Call to ",url)
  local respbody = {} -- for the response body
  http.TIMEOUT = 50;
  log.info("Sending request...")

  local result, respcode, respheaders, respstatus = http.request {
    method = "GET",
    url = url,
    headers = {
        ["Secret"] = secret
    },
    sink = ltn12.sink.table(respbody)
    }
  -- get body as string by concatenating table filled by sink
  respbody = table.concat(respbody)
  log.debug("Response Body "..respbody)
  print(result,respcode,respstatus)
end

return wiser