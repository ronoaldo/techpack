#tubelib_addons_0siribix

curFolder = minetest.get_modpath(minetest.get_current_modname())
if minetest.get_modpath("tubelib_addons1") and tubelib_addons1 then
	dofile(curFolder .. "/vacuum.lua")
end
