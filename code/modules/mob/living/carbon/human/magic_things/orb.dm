/area/town
	name = "Inside Town"
	icon_state = "town"
	var/have_magic = TRUE

/area/town/Entered(A)
	..()
	if(istype(A, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = A
		H.have_crystal()
		if(H.crystal)
			var/obj/item/clothing/accessory/magic_crystal/MC = H.crystal
			MC.inside_town = TRUE
			MC.charge_crystal(MC)
	if(istype(A, /obj/item/clothing/accessory/magic_crystal))
		var/obj/item/clothing/accessory/magic_crystal/MC = A
		MC.inside_town = TRUE

/area/town/Exited(A)
	..()
	if(istype(A, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = A
		if(H.crystal)
			var/obj/item/clothing/accessory/magic_crystal/MC = H.crystal
			MC.inside_town = FALSE
	if(istype(A, /obj/item/clothing/accessory/magic_crystal))
		var/obj/item/clothing/accessory/magic_crystal/MC = A
		MC.inside_town = FALSE
