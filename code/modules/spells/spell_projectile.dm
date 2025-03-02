/obj/item/projectile/spell_projectile
	name = "spell"
	icon = 'icons/obj/projectiles.dmi'

	nodamage = TRUE

	var/spell/targeted/projectile/carried

	penetrating = 0
	life_span = 10 //set by the duration of the spell

	var/proj_trail = 0 //if it leaves a trail
	var/proj_trail_lifespan = 0 //deciseconds
	var/proj_trail_icon = 'icons/obj/cult.dmi'
	var/proj_trail_icon_state = "trail"
	var/list/trails = new()

/spell/targeted/projectile/perform(mob/user = usr, skipcharge)
	user.put_in_active_hand(new proj_type)

/obj/item/projectile/spell_projectile/New()
	. = ..()
	src.carried.holder = usr

/obj/item/projectile/spell_projectile/Destroy()
	for(var/trail in trails)
		qdel(trail)
	carried = null
	return ..()

/obj/item/projectile/spell_projectile/ex_act()
	return

/obj/item/projectile/spell_projectile/before_move()
	if(proj_trail && src && src.loc) //pretty trails
		var/obj/overlay/trail = new /obj/overlay(loc)
		trails += trail
		trail.icon = proj_trail_icon
		trail.icon_state = proj_trail_icon_state
		trail.set_density(0)
		spawn(proj_trail_lifespan)
			trails -= trail
			qdel(trail)

/obj/item/projectile/spell_projectile/proc/prox_cast(list/targets) // Столкновение проджектайла с препятствием
	if(loc)
		carried.prox_cast(targets, src)
		qdel(src)
	return

/obj/item/projectile/spell_projectile/Bump(atom/A, forced=0)
	if(loc && carried)
		prox_cast(carried.choose_prox_targets(user = carried.holder, spell_holder = src))
	return 1

/obj/item/projectile/spell_projectile/on_impact()
	if(loc && carried)
		prox_cast(carried.choose_prox_targets(user = carried.holder, spell_holder = src))
	return 1

/obj/item/projectile/spell_projectile/dropped(mob/user)
	. = ..()
	Destroy()

/obj/item/projectile/spell_projectile/proc/Fire(atom/target, mob/living/user = usr, clickparams)
	if(!user || !target) return
	if(target.z != user.z) return

	var/obj/projectile = src

	process_projectile(projectile, user, target, user.zone_sel?.selecting, clickparams)

/obj/item/projectile/spell_projectile/proc/process_projectile(obj/projectile, mob/user, atom/target, target_zone, params=null)
	var/obj/item/projectile/P = projectile
	if(!istype(P))
		return 0 //default behaviour only applies to true projectiles

	if(params)
		P.set_clickpoint(params)

	//shooting while in shock
	var/x_offset = 0
	var/y_offset = 0
	if(istype(user, /mob/living/carbon/human))
		var/mob/living/carbon/human/mob = user
		if(mob.shock_stage > 120)
			y_offset = rand(-2,2)
			x_offset = rand(-2,2)
		else if(mob.shock_stage > 70)
			y_offset = rand(-1,1)
			x_offset = rand(-1,1)

	var/launched = !P.launch_from_gun(target, user, src, target_zone, x_offset, y_offset)

	return launched

/obj/item/projectile/spell_projectile/seeking
	name = "seeking spell"
