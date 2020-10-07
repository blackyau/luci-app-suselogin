-- Copyright 2020 BlackYau <blackyau426@gmail.com>
-- GNU General Public License v3.0


local fs = require "nixio.fs"
local conffile = "/tmp/log/suselogin/suselogin.log"

f = SimpleForm("logview")

t = f:field(TextValue, "conf")
t.rmempty = true
t.rows = 20
function t.cfgvalue()
	return fs.readfile(conffile) or ""
end
t.readonly="readonly"

return f