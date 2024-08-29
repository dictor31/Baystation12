/obj/item/clothing/accessory/magic_crystal
	w_class = ITEM_SIZE_TINY

	var/max_charge = 10000
	var/charge = 5000

	name = "Моё сокровище"
	icon = 'icons/obj/magic/magic.dmi'
	icon_state = "normal"
	throwforce = 0
	throw_speed = 4
	throw_range = 6
	force = 0
	overlay_state = "magic_crystal"


/obj/item/clothing/accessory/magic_crystal/examine(mob/user, distance)
	. = ..()
	if(distance <= 3)
		examine_charge(user)

/obj/item/clothing/accessory/magic_crystal/proc/examine_charge(mob/user)
	to_chat(user, SPAN_NOTICE("У меня осталось [round(charge)] заряда."))
