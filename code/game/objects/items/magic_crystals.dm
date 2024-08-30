/obj/item/clothing/accessory/magic_crystal
	w_class = ITEM_SIZE_TINY

	var/max_charge = 10000
	var/charge = 5000
	var/mob/living/carbon/human/owner = "Неизвестно"

	name = "Кристалл"
	desc = "Странный камень, который дал нам всем веру в светлое будущее"
	icon = 'icons/obj/magic/magic.dmi'
	icon_state = "normal"
	throwforce = 0
	throw_speed = 4
	throw_range = 6
	force = 0
	overlay_state = "magic_crystal"

/obj/item/clothing/accessory/magic_crystal/New(datum/mind/owner)
	. = ..()
	if(istype(owner, /mob/living/carbon/human))
		src.owner = owner

/obj/item/clothing/accessory/magic_crystal/examine(mob/user, distance)
	. = ..()
	examine_charge(user)
	examine_owner(user)

/obj/item/clothing/accessory/magic_crystal/proc/examine_charge(mob/user)
	to_chat(user, SPAN_NOTICE("В кристалле осталось [round(charge)] заряда."))

/obj/item/clothing/accessory/magic_crystal/proc/examine_owner(mob/user)
	to_chat(user, SPAN_NOTICE("Этот кристалл принадлежит [owner]"))
