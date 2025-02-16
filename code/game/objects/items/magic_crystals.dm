/obj/item/clothing/accessory/magic_crystal
	w_class = ITEM_SIZE_TINY

	var/max_charge = 10000
	var/charge = 5000
	var/location
	var/mob/living/carbon/human/owner = "Неизвестно"

	name = "Кристалл"
	desc = "Странный камень, который дал нам всем веру в светлое будущее"
	icon = 'icons/obj/magic/magic.dmi'
	icon_state = "normal"
	throwforce = 0
	throw_range = 5
	force = 0
	overlay_state = "magic_crystal"

/obj/item/clothing/accessory/magic_crystal/New(datum/mind/owner)
	. = ..()
	addtimer(new Callback(src, .proc/charge_crystal), 5 SECONDS, TIMER_LOOP)
	if(istype(owner, /mob/living/carbon/human))
		src.owner = owner

/obj/item/clothing/accessory/magic_crystal/examine(mob/user, distance)
	. = ..()
	examine_crystal(user)
	find()

/obj/item/clothing/accessory/magic_crystal/proc/examine_crystal(mob/user, area/locate)
	locate = get_area(src)

	to_chat(user, SPAN_NOTICE("В кристалле осталось [round(charge)] заряда."))
	to_chat(user, SPAN_NOTICE("Этот кристалл принадлежит [owner]"))

	if(locate.type == /area/town)
		var/area/town/T = locate
		if(T.have_magic)
			to_chat(user, SPAN_NOTICE("Кристалл пульсирует"))
			return
	to_chat(user, SPAN_NOTICE("Кристалл затухает"))


/obj/item/clothing/accessory/magic_crystal/proc/charge_crystal()
	var/area/location = get_area(src)

	if(location.type == /area/town)
		var/area/town/T = location
		if(T.have_magic)
			charge += rand(5, 10)
			return

	charge -= rand(5, 10)

/obj/item/clothing/accessory/magic_crystal/proc/find()
	location = loc
