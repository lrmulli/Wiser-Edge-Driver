local log = require "log"
local capabilities = require "st.capabilities"
local socket = require'socket'
local json = require "dkjson"
local cosock = require "cosock"
local http = cosock.asyncify "socket.http"
ltn12 = require("ltn12")

local wiser = {}

-- callback to handle an `on` capability command
function wiser.makeApiGetCall(driver,device,path)
  local url = "http://"..device.preferences.deviceaddr..path
  local secret = device.preferences.secret
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
  return respbody
end
function wiser.createRooms(driver,device,payload)
  --make some rooms
  local dni = "WiserRoom_".."123"
  local roomname = "yard"
  local roomid = "1"
  local metadata = {
    type = "LAN",
    -- the DNI must be unique across your hub, using static ID here so that we
    -- only ever have a single instance of this "device"
    device_network_id = dni,
    label = "Wiser Room: "..roomname,
    profile = "wiser-bridge.room.v1",
    manufacturer = "Wiser",
    model = "Wiser Room",
    vendor_provided_label = roomid,
    parent_device_id = device.id
  }
  driver:try_create_device(metadata)
end
return wiser