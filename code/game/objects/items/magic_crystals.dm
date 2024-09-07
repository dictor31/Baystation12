/obj/item/clothing/accessory/magic_crystal
	w_class = ITEM_SIZE_TINY

	var/max_charge = 10000
	var/charge = 5000
	var/mob/living/carbon/human/owner = "Неизвестно"
	var/inside_town = FALSE

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
	addtimer(new Callback(src, .proc/charge_crystal), 15 SECONDS, TIMER_LOOP)
	if(istype(owner, /mob/living/carbon/human))
		src.owner = owner

/obj/item/clothing/accessory/magic_crystal/examine(mob/user, distance)
	. = ..()
	examine_crystal(user)

/obj/item/clothing/accessory/magic_crystal/proc/examine_crystal(mob/user)
	to_chat(user, SPAN_NOTICE("В кристалле осталось [round(charge)] заряда."))
	to_chat(user, SPAN_NOTICE("Этот кристалл принадлежит [owner]"))
	if(inside_town)
		to_chat(user, SPAN_NOTICE("Кристалл пульсирует"))
	else
		to_chat(user, SPAN_NOTICE("Кристалл затухает"))

/obj/item/clothing/accessory/magic_crystal/proc/charge_crystal(obj/item/clothing/accessory/magic_crystal = src)
	var/obj/item/clothing/accessory/magic_crystal/MC = magic_crystal

	if(charge >= max_charge || charge <= 0)
		return

	if(!inside_town && charge > 0)
		while(!inside_town && charge > 0)
			sleep(50)
			MC.charge -= rand(1, 10)

	while(inside_town && charge < max_charge)
		sleep(50)
		MC.charge += rand(1, 10)
