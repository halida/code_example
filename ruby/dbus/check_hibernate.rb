require "dbus"
sysbus = DBus.system_bus
upower_service   = sysbus["org.freedesktop.UPower"]
upower_object    = upower_service["/org/freedesktop/UPower"]
upower_object.introspect
upower_interface = upower_object["org.freedesktop.UPower"]
on_battery       = upower_interface["OnBattery"]


login_service = sysbus["org.freedesktop.login1"]
login_object = login_service["/org/freedesktop/login1"]

login_object.introspect

li = login_object["org.freedesktop.login1.Manager"]
li.CanSuspend
li.CanHibernate # no
