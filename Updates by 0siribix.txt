This will add refill capability to blocks which push stacks. If the receiving inventory has no empty slots but has less than a full stack, the pushing node will push a partial stack to refill the existing stack. This is especially useful for blocks that use fuel for example. This is fully backward compatible with receiving nodes but not with stack pushing nodes.

!!! WARNING !!!
If you have custom stack pushing nodes then they will need to be updated or you will gain duplicate blocks when refilling inventory. The outdated pushing node will receive a false return from the receiving node and will not subtract the partial node that was sent


Example of receiving node

tubelib.register_node("mymod:item", {"mymod:alias"}, {
...
	on_push_stack = function(pos, side, item)
		local meta = minetest.get_meta(pos)
		return tubelib.put_item(meta, "main", item, tubelib.refill)
	end,
...


If you use "tubelib.register_node" and define on_push_item but you don't use tubelib.put_item (see my modifications to Drawers) then you simply return false and set the itemcount to the leftover amount.
Previously you would do something like

		tubelib.register_node("drawers:controller", {}, {
			on_push_item = function(pos, side, item, player_name)
			-- Insert code here to check protection on this location
			if stack_accepted then
				return true
			else
				if
				return false
			end,


This would now change to something like this

		tubelib.register_node("drawers:controller", {}, {
			on_push_item = function(pos, side, item, player_name)
			-- Insert code here to check protection on this location
			if stack accepted then
				return true
			else
				leftover = my_insert_function(stack) -- leftover will be a stack to push back to the source
				if leftover:get_count() == 0 then
					return true
				else
					stack:set_count(leftover:get_count())
					return false
				end
			end,

The pushing node will check the count of the leftover to see if it has changed.
