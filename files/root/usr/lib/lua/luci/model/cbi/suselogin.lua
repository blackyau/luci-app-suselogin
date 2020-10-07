-- Copyright 2020 BlackYau <blackyau426@gmail.com>
-- GNU General Public License v3.0


require("luci.sys")

m = Map("suselogin", translate("轻化工校园网认证"), translate("自动连接网络,支持断线自动重连"))

s = m:section(TypedSection, "login", "")
s.addremove = false
s.anonymous = true

enable = s:option(Flag, "enable", translate("启用"), translate("启用后即会检测上网状态，并尝试自动拨号"))
enable.rmempty = false

name = s:option(Value, "username", translate("用户名(学号)"))
name.rmempty = false
pass = s:option(Value, "password", translate("密码(身份证后6位)"))
pass.password = true
pass.rmempty = false

isp = s:option(ListValue, "isp", translate("运营商"))
isp:value("%25E7%2594%25B5%25E4%25BF%25A1", translate("电信互联网"))
isp:value("%25E7%25A7%25BB%25E5%258A%25A8", translate("移动互联网"))
isp:value("%25E6%25A0%25A1%25E5%259B%25AD%25E7%25BD%2591", translate("校园网"))
isp:value("%25E8%2581%2594%25E9%2580%259A", translate("联通互联网"))

interval = s:option(Value, "interval", translate("间隔时间"), translate("每隔多少时间(≥5)检测一下网络是否连接正常，如果网络异常则会尝试连接(单位:分钟)"))
interval.default = 30
interval.datatype = "min(5)"

success = s:option(DummyValue,"opennewwindow",translate("认证页面"))
success.description = translate("<input type=\"button\" class=\"cbi-button cbi-button-save\" value=\"打开认证页\" onclick=\"window.open('http://10.23.2.4/eportal/success.jsp')\" /><input type=\"button\" class=\"cbi-button cbi-button-save\" value=\"打开自助服务\" onclick=\"window.open('http://10.23.2.6:8080/selfservice')\" /><br />可查看认证状态和管理在线设备")


local apply = luci.http.formvalue("cbi.apply")
if apply then
	io.popen("/etc/init.d/suselogin restart")
end

return m
