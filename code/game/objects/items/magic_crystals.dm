/obj/item/clothing/accessory/magic_crystal
	w_class = ITEM_SIZE_TINY

	var/list/charge
	var/location
	var/mob/living/carbon/human/owner = "Неизвестно"

	name = "Кристалл"
	desc = "Странный камень, который дал нам всем веру в светлое будущее"
	icon = 'icons/obj/magic/magic.dmi'
	icon_state = "normal"
	throwforce = 0
	throw_range = 5
	overlay_state = "magic_crystal"

/obj/item/clothing/accessory/magic_crystal/New(datum/mind/owner)
	. = ..()
	charge = list(TRUE,TRUE,TRUE,TRUE,TRUE, FALSE,FALSE,FALSE,FALSE,FALSE)
	addtimer(new Callback(src, .proc/charge_crystal), 5 SECONDS, TIMER_LOOP)
	if(istype(owner, /mob/living/carbon/human))
		src.owner = owner

/obj/item/clothing/accessory/magic_crystal/examine(mob/user, distance)
	. = ..()
	examine_crystal(user)
	find()

/obj/item/clothing/accessory/magic_crystal/proc/examine_crystal(mob/user, area/locate)
	locate = get_area(src)
	var/text = ""

	for(var/point in charge)
		if(point)
			text += "[icon2html(src, user, "1")]"
		else
			text += "[icon2html(src, user, "0")]"

	to_chat(user, SPAN_NOTICE("[text]"))
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
			var/i = charge.Find(0)
			if(i)
				charge[i] = TRUE

/obj/item/clothing/accessory/magic_crystal/proc/find()
	location = loc
