
/datum/ai_holder/simple_animal/urist_humanoid
	hostile = TRUE
	intelligence_level = AI_SMART //Purportedly
	retaliate = TRUE //If attacked, attack back
	threaten = FALSE //Verbal threats
	firing_lanes = TRUE //Avoid shooting allies
	conserve_ammo = TRUE //Don't shoot when it can't hit target
	can_breakthrough = TRUE //Can break through doors
	violent_breakthrough = TRUE //Won't try to break through walls (humans can, but usually don't)
	speak_chance = 2 //Babble chance
	cooperative = TRUE //Assist each other
	wander = TRUE //Wander around
	returns_home = FALSE
	use_astar = TRUE //Path smartly
	home_low_priority = TRUE //Following/helping is more important
	pointblank = FALSE // Use your fancy melee
	can_flee = TRUE
	dying_threshold = 0.1
	flee_when_outmatched = FALSE // for now, 'cause it's buggy
	lose_target_timeout = 20 SECONDS
	var/run_if_this_close = 3


/datum/ai_holder/simple_animal/urist_humanoid/flee_from_target()
	// Patches fleeing so that fleeing AIs still fight back. Bay's currently don't.
	. = ..()

	if(target && can_attack(target))
		engage_target()

// Duplicated from /datum/ai_holder/simple_animal/humanoid/hostile
/datum/ai_holder/simple_animal/urist_humanoid/post_melee_attack(atom/A)
	holder.IMove(get_step(holder, pick(GLOB.alldirs)))
	holder.face_atom(A)

/datum/ai_holder/simple_animal/urist_humanoid/post_ranged_attack(atom/A)
	//Pick a random turf to step into
	var/turf/T = get_step(holder, pick(GLOB.alldirs))
	if(check_trajectory(A, T)) // Can we even hit them from there?
		holder.IMove(T)
		holder.face_atom(A)

	if(get_dist(holder, A) < run_if_this_close)
		holder.IMove(get_step_away(holder, A))
		holder.face_atom(A)


/datum/ai_holder/simple_animal/urist_humanoid/melee_generic
	run_if_this_close = 1


/datum/ai_holder/simple_animal/urist_humanoid/melee_slippery
	run_if_this_close = 1

/datum/ai_holder/simple_animal/urist_humanoid/melee_slippery/post_melee_attack(atom/A)
	if(holder.Adjacent(A))
		holder.IMove(get_step(holder, pick(GLOB.alldirs - get_dir(A, holder))))
		holder.face_atom(A)


/datum/ai_holder/simple_animal/urist_humanoid/ranged_generic
	run_if_this_close = 3


/mob/living/simple_animal/hostile/urist
	// Default template for a humanoid
	name = "gunman"
	desc = "Don't spawn me. Tell staff if you see me."
	status_flags = CANPUSH

	// Icons
	icon = 'icons/uristmob/simpleanimals.dmi'
	icon_state = "gunman"
	icon_living = "gunman"
	icon_dead = "gunman_dead"
	icon_gib = null

	// Speed
	movement_cooldown = 5
	move_to_delay = 4
	turns_per_move = 5
	speed = 12

	// Health
	maxHealth = 50
	health = 50

	// Defense
	harm_intent_damage = 5

	// Attack
	natural_weapon = /obj/item/natural_weapon/punch
	a_intent = "harm"
	attack_armor_pen = 0
	needs_reload = TRUE // most will
	casingtype = null // DO NOT CHANGE THIS - it spams the map with trash!

	// Capabilities
	can_pry = TRUE

	// Atmos
	min_gas = list("oxygen" = 5)
	max_gas = null
	unsuitable_atmos_damage = 15

	// Flavor
	attacktext = list("punched", "hit", "smacked")
	response_help = "pokes"
	response_disarm = "shoves"
	response_harm = "hits"

	// Sounds
	projectilesound = 'sound/weapons/gunshot/gunshot_pistol.ogg'
	attack_sound = 'sound/weapons/punch3.ogg'

	// AI
	faction = "gunman"
	ai_holder = /datum/ai_holder/simple_animal/humanoid/hostile

	// Custom
	var/shot_time = 1


/mob/living/simple_animal/hostile/urist/shoot_target(atom/A)
	/* This is an override of Bay logic with an extra loop to support burst-firing.
	// Aside from the indicated change, this should be kept in sync with Baycode.
	*/
	set waitfor = FALSE
	setClickCooldown(get_attack_speed())

	face_atom(A)

	if(ranged_attack_delay)
		ranged_pre_animation(A)
		handle_attack_delay(A, ranged_attack_delay) // This will sleep this proc for a bit, which is why waitfor is false.

	// The next two lines are Urist - just wrapping the original with a loop
	var/shotsleft = max(0, (src.rapid || 0)) + 1  // if we're calling this, the mob can shoot, so we should do a minimum of one shot.
	var/shottime = max(1, (src.shot_time || 1))

	while (shotsleft --> 0)
		// Everything below is Bay's, just indented
		if(needs_reload)
			if(reload_count >= reload_max)
				try_reload()
				return FALSE

		visible_message("<span class='danger'><b>\The [src]</b> fires at \the [A]!</span>")
		shoot(A)
		if(casingtype)
			new casingtype(loc)

		sleep(shottime)

	if(ranged_attack_delay)
		ranged_post_animation(A)

	return TRUE


/mob/living/simple_animal/hostile/urist/gunman //mostly redundant, for ease of spawning
	desc = "A bad guy with a gun."
	faction = "syndicate"

	// AI spec
	ai_holder = /datum/ai_holder/simple_animal/urist_humanoid/ranged_generic
	say_list_type = /datum/say_list/gunman

	// Gun stuff
	projectiletype = /obj/item/projectile/bullet/pistol

	// Reloads
	reload_max = 6  // classic six-shooter

	// It's a mook - attended Imperial Stormtroopers Marksmanship Academy
	projectile_accuracy = -5
	projectile_dispersion  = 2

	natural_armor = list(
		bullet = ARMOR_BALLISTIC_MINOR,
		melee = ARMOR_MELEE_MINOR
	)


/mob/living/simple_animal/hostile/urist/commando //literally a clone of syndies with my speed tweaks and NT faction, adminfuckery purposes
	faction = "NTIS"
	name = "\improper NTIS Commando"
	desc = "A henchman of the Internal Security department. You suddenly get an unpleasant sensation that you <I>'know too much'</I>."
	ranged = 1
	rapid = 2

	icon = 'icons/mob/simple_animal/animal.dmi'
	icon_state = "syndicateranged"
	icon_living = "syndicateranged"
	icon_gib = "syndicate_gib"

	projectilesound = 'sound/weapons/gunshot/gunshot_smg.ogg'
	projectiletype = /obj/item/projectile/bullet/pistol

	maxHealth = 100
	health = 100

	// Reloads
	reload_max = 30  // generic SMG

	// Accurate, but sprays a bit
	projectile_accuracy = 0
	projectile_dispersion  = 1

	// AI spec
	ai_holder = /datum/ai_holder/simple_animal/urist_humanoid/ranged_generic
	say_list_type = /datum/say_list/professional

	natural_armor = list(
		bullet = ARMOR_BALLISTIC_PISTOL,
		laser = ARMOR_LASER_HANDGUNS,
		melee = ARMOR_MELEE_SMALL
	)


/mob/living/simple_animal/hostile/urist/ntagent
	faction = "NTIS" //NTIS is intended as NT Deathsquad affiliation
	icon_state = "agent"
	icon_living = "agent"
	icon_dead = "agentdead"
	name = "\improper NTIS Agent"
	desc = "A spook from the Internal Security department. You suddenly get an unpleasant sensation that you <I>'know too much'</I>."

	ranged = 1
	rapid = 2
	movement_cooldown = 3

	maxHealth = 150
	health = 150

	projectiletype = /obj/item/projectile/bullet/pistol/holdout/silenced
	natural_weapon = /obj/item/natural_weapon/punch

	// Reloads
	reload_max = 15  // modelled after beretta m9

	// AI spec
	ai_holder = /datum/ai_holder/simple_animal/urist_humanoid/ranged_generic
	say_list_type = /datum/say_list/professional

	natural_armor = list(
		bullet = ARMOR_BALLISTIC_PISTOL,
		melee = ARMOR_MELEE_SMALL
	)


/mob/living/simple_animal/hostile/urist/ANTAG
	icon_state = "ANTAG"
	icon_living = "ANTAG"
	icon_dead = "ANTAG_dead"
	name = "\improper ANTAG Operative"
	desc = "A member of a covert cell of a terrorist paramilitary collaborating with aliens to further their own goals, and a snappy dresser."
	faction = "alien"
	ranged = 1
	rapid = 0
	maxHealth = 100
	health = 100
	projectilesound = 'sound/weapons/gunshot/gunshot3.ogg'
	projectiletype = /obj/item/projectile/bullet/rifle

	// AI spec
	ai_holder = /datum/ai_holder/simple_animal/urist_humanoid/ranged_generic
	say_list_type = /datum/say_list/professional

	// Reloads
	reload_max = 30  // modelled after H&K G36C because XCOM

	natural_armor = list(
		bullet = ARMOR_BALLISTIC_PISTOL,
		laser = ARMOR_LASER_HANDGUNS,
		melee = ARMOR_MELEE_SMALL
	)

/mob/living/simple_animal/hostile/urist/skrellterrorist
	icon_state = "skrellorist"
	icon_living = "skrellorist"
	icon_dead = "skrelloristdead"
	name = "\improper Skrellian terrorist"
	desc = "An anti-human, Skrell-isolationist insurgent."
	ranged = 1
	faction = "skrellt"
	rapid = 3
	maxHealth = 100
	health = 100
	projectilesound = 'sound/weapons/gunshot/gunshot3.ogg'
	projectiletype = /obj/item/projectile/bullet/pistol

	// AI spec
	ai_holder = /datum/ai_holder/simple_animal/urist_humanoid/ranged_generic
	say_list_type = /datum/say_list/fanatic

	// Reloads
	reload_max = 20  // modelled after FN FAL arbitrarily and for variety

	// Fairly unprofessional - spray and pray
	projectile_accuracy = -1
	projectile_dispersion  = 2
	shot_time = 1

	natural_armor = list(
		bullet = ARMOR_BALLISTIC_MINOR,
		laser = ARMOR_LASER_MINOR,
		melee = ARMOR_MELEE_SMALL
	)


/mob/living/simple_animal/hostile/urist/riotcop
	icon_state = "riotcop"
	icon_living = "riotcop"
	icon_dead = "riotcop_dead"
	name = "\improper Riot Response Unit"
	desc = "An officer equipped for dealing with riots."
	ranged = 0
	attacktext = "beat"
	move_to_delay = 9 //this armor is *heavy*
	movement_cooldown = 8
	maxHealth = 100 //but it offers some serious protection
	health = 100
	resistance = 4 //including padding
	faction = "NTIS"
	natural_weapon = /obj/item/melee/baton
	natural_armor = list(
		bullet = ARMOR_BALLISTIC_PISTOL,
		laser = ARMOR_LASER_SMALL,
		melee = ARMOR_MELEE_RESISTANT
	)

	// AI spec
	ai_holder = /datum/ai_holder/simple_animal/urist_humanoid/melee_generic
	say_list_type = /datum/say_list/redshirt


/mob/living/simple_animal/hostile/urist/ntis_merc
	// An NTIS-affiliated clone of plain gunman
	// Meant as a low-level mook variant of Agents that would be NT-friendly
	faction = "NTIS"
	say_list_type = /datum/say_list/redshirt

	// Gun stuff
	projectiletype = /obj/item/projectile/bullet/pistol/holdout

	// Reloads
	reload_max = 6  // classic six-shooter

	// It's a mook - attended Imperial Stormtroopers Marksmanship Academy
	projectile_accuracy = -5
	projectile_dispersion  = 2

	natural_armor = list(
		bullet = ARMOR_BALLISTIC_MINOR,
		melee = ARMOR_MELEE_MINOR
	)


/mob/living/simple_animal/hostile/urist/cultist
	icon_state = "cultist"
	icon_living = "cultist"
	name = "cult assassin"
	desc = "An assassin empowered by eldritch forces from beyond."
	ranged = 0
	attacktext = "stabbed"
	maxHealth = 75
	health = 75
	move_to_delay = 2 //gotta go fast!
	movement_cooldown = 2
	alpha = 200
	environment_smash = 2
	faction = "cult"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	natural_weapon = /obj/item/material/knife/ritual
	see_in_dark = 8
	see_invisible = SEE_INVISIBLE_LEVEL_TWO

	// AI spec
	ai_holder = /datum/ai_holder/simple_animal/urist_humanoid/melee_generic
	say_list_type = /datum/say_list/fanatic

	natural_armor = list(
		bullet = ARMOR_BALLISTIC_MINOR,
		melee = ARMOR_MELEE_MINOR
	)


/mob/living/simple_animal/hostile/urist/cultist/death()
	..()
	var/datum/effect/effect/system/smoke_spread/bad/deathsmoke = new
	deathsmoke.set_up(5,0,src.loc,null)
	deathsmoke.start()
	qdel(src)

//terran

/mob/living/simple_animal/hostile/urist/terran
	var/corpse = null //i really need to make this a generic var, but that's going to require going through all the old Bay simple mobs too so it'll have to wait for another day
	hiddenfaction = /datum/factions/terran
	ai_holder = /datum/ai_holder/simple_animal/urist_humanoid/ranged_generic

	natural_armor = list(
		bullet = ARMOR_BALLISTIC_SMALL,
		laser = ARMOR_LASER_SMALL,
		melee = ARMOR_MELEE_SMALL
	)


/mob/living/simple_animal/hostile/urist/terran/death(gibbed, deathmessage, show_dead_message)
	..(gibbed, deathmessage, show_dead_message)
	if(corpse)
		new corpse (src.loc)
	qdel(src)
	return


/mob/living/simple_animal/hostile/urist/terran/marine
	name = "\improper Terran Confederacy Marine"
	desc = "A Terran Confederacy Marine."
	ranged = 1
	rapid = 2
	icon_state = "terran_marine"
	icon_living = "terran_marine"
	icon_dead = "terran_marine_dead"
	icon_gib = "syndicate_gib"
	projectilesound = 'sound/weapons/gunshot/gunshot2.ogg'
	projectiletype = /obj/item/projectile/bullet/rifle/military
	maxHealth = 150
	health = 150
	corpse = /obj/effect/landmark/corpse/terran/marine

	// AI spec
	say_list_type = /datum/say_list/merc


/mob/living/simple_animal/hostile/urist/terran/marine/event
	faction = "terran"


/mob/living/simple_animal/hostile/urist/terran/marine/ground
	icon_state = "terran_g_marine"
	icon_living = "terran_g_marine"
	icon_dead = "terran_g_marine_dead"
	corpse = /obj/effect/landmark/corpse/terran/marine_ground
	projectilesound = 'sound/weapons/gunshot/gunshot2.ogg'
	projectiletype = /obj/item/projectile/bullet/rifle
	rapid = 0
	desc = "A Terran Confederacy Marine. This one is wearing gear worn by ground assault forces."


/mob/living/simple_animal/hostile/urist/terran/marine/ground/event
	faction = "terran"


/mob/living/simple_animal/hostile/urist/terran/marine_officer
	name = "\improper Terran Confederacy Marine Officer"
	desc = "A Terran Confederacy Marine Officer."
	ranged = 1
	rapid = 2
	icon_state = "terran_officer"
	icon_living = "terran_officer"
	icon_dead = "terran_officer_dead"
	icon_gib = "syndicate_gib"
	projectilesound = 'sound/weapons/gunshot/gunshot_smg.ogg'
	projectiletype = /obj/item/projectile/bullet/pistol
	maxHealth = 125
	health = 125
	corpse = /obj/effect/landmark/corpse/terran/officer

	// AI spec
	say_list_type = /datum/say_list/gunman


/mob/living/simple_animal/hostile/urist/terran/marine_officer/event
	faction = "terran"


/mob/living/simple_animal/hostile/urist/terran/marine_officer/ground
	icon_state = "terran_g_officer"
	icon_living = "terran_g_officer"
	icon_dead = "terran_g_officer_dead"
	desc = "A Terran Confederacy Marine Officer. This one is wearing gear worn by ground assault forces."
	corpse = /obj/effect/landmark/corpse/terran/marine_ground_officer


/mob/living/simple_animal/hostile/urist/terran/marine_officer/ground/event
	faction = "terran"


/mob/living/simple_animal/hostile/urist/terran/marine_space
	name = "\improper Terran Confederacy Marine"
	desc = "A Terran Confederacy Marine. This one is wearing a voidsuit."
	ranged = 1
	rapid = 2
	icon_state = "terran_heavy"
	icon_living = "terran_heavy"
	icon_dead = "terran_heavy_dead"
	icon_gib = "syndicate_gib"
	projectilesound = 'sound/weapons/gunshot/gunshot2.ogg'
	projectiletype = /obj/item/projectile/bullet/rifle/military
	maxHealth = 225
	health = 225
	min_gas = null
	max_gas = null
	minbodytemp = 0
	corpse = /obj/effect/landmark/corpse/terran/marinespace

	// AI spec
	say_list_type = /datum/say_list/merc


/mob/living/simple_animal/hostile/urist/terran/marine_space/event
	faction = "terran"


/mob/living/simple_animal/hostile/urist/terran/marine_space/ground
	desc = "A Terran Confederacy Marine. This one is wearing a voidsuit worn by ground assault forces."
	icon_state = "terran_g_space"
	icon_living = "terran_g_space"
	icon_dead = "terran_g_space_dead"
	corpse = /obj/effect/landmark/corpse/terran/marine_ground_space

/mob/living/simple_animal/hostile/urist/terran/marine_space/ground/event
	faction = "terran"


//rebels

/mob/living/simple_animal/hostile/urist/rebel
	icon_state = "ANTAG"
	icon_living = "ANTAG"
	icon_dead = "ANTAG_dead"
	name = "\improper Rebel"
	desc = "A member of a growing resistance movement to both NanoTrasen and the Terran Confederacy."
	hiddenfaction = /datum/factions/rebel
	rapid = 0
	maxHealth = 130
	health = 130
	ai_holder = /datum/ai_holder/simple_animal/humanoid/hostile
	projectilesound = 'sound/weapons/gunshot/gunshot3.ogg'
	projectiletype = /obj/item/projectile/bullet/rifle

	natural_armor = list(
		bullet = ARMOR_BALLISTIC_MINOR,
		laser = ARMOR_LASER_MINOR,
		melee = ARMOR_MELEE_SMALL
	)

	// AI spec
	say_list_type = /datum/say_list/fanatic


/mob/living/simple_animal/hostile/urist/rebel/event
	faction = "rebels"


//new pirates

/mob/living/simple_animal/hostile/urist/newpirate
	name = "Pirate"
	desc = "Does what they want 'cause a pirate is free."
	icon_state = "newpirate_melee"
	icon_living = "newpirate_melee"
	icon_dead = "newpirate_melee_dead"
	turns_per_move = 5
	response_help = "pushes"
	response_disarm = "shoves"
	response_harm = "hits"
	speed = 4
	maxHealth = 120
	health = 120
	can_escape = TRUE

	harm_intent_damage = 5
	natural_weapon = /obj/item/melee/energy/sword/pirate/activated

	unsuitable_atmos_damage = 15
	var/corpse = /obj/effect/landmark/corpse/newpirate/melee
	hiddenfaction = /datum/factions/pirate
	faction = "pirate"

	// AI spec
	ai_holder = /datum/ai_holder/simple_animal/urist_humanoid/melee_generic
	say_list_type = /datum/say_list/pirate


/mob/living/simple_animal/hostile/urist/newpirate/laser
	name = "Pirate Gunner"
	icon_state = "newpirate_laser"
	icon_living = "newpirate_laser"
	icon_dead = "newpirate_laser_dead"
	projectilesound = 'sound/weapons/laser.ogg'
	ranged = 1
	rapid = 0
	projectiletype = /obj/item/projectile/beam
	corpse = /obj/effect/landmark/corpse/newpirate/laser
	ai_holder = /datum/ai_holder/simple_animal/urist_humanoid/ranged_generic


/mob/living/simple_animal/hostile/urist/newpirate/ballistic
	name = "Pirate Gunner"
	icon_state = "newpirate_ballistic"
	icon_living = "newpirate_ballistic"
	icon_dead = "newpirate_ballistic_dead"
	projectilesound = 'sound/weapons/gunshot/gunshot3.ogg'
	ranged = 1
	rapid = 2
	projectiletype = /obj/item/projectile/bullet/rifle
	corpse = /obj/effect/landmark/corpse/newpirate/ballistic
	ai_holder = /datum/ai_holder/simple_animal/urist_humanoid/ranged_generic


/mob/living/simple_animal/hostile/urist/newpirate/death(gibbed, deathmessage, show_dead_message)
	..(gibbed, deathmessage, show_dead_message)
	if(corpse)
		new corpse (src.loc)
	qdel(src)
	return


// **  HOLONAUT MOBS ** //
/mob/living/simple_animal/hostile/urist/hololab
	name = "Holo Lab hostile mob"
	desc = "You shouldn't see me, report this to an admin if you do!"
	icon = 'icons/uristmob/simpleanimals.dmi'
	icon_dead = "holonaut_dead"
	faction = "holonaut"
	response_help = "holds tightly"
	response_disarm = "pulls down"
	response_harm = "grasps"
	ai_holder = /datum/ai_holder/simple_animal/hololab
	say_list_type = /datum/say_list/hololab

/datum/ai_holder/simple_animal/hololab
	speak_chance = 50
	aggro_sound = 'sound/urist/holonaut_chatter_02.ogg'

/datum/say_list/hololab
	speak = list("...?<>D-d-d-£$D<>Id it()<> work?", "I<> T-<>%$£I'm b-<C-cant feel <>ANYT-thing.</C-cant>", "?:PO$&<S-Someone...", "Three. Nine. ><><Seven-n-n-n.. One..$£% Five Nine.")
	emote_hear = list("gasps suddenly", "garbles something unintelligible", "jitters audibly", "garbles some sort of radio message.")
	emote_see = list("jitters uncontrollably", "stares at their palms")


/mob/living/simple_animal/hostile/urist/hololab/holonautgrunt  // Weakest Holonaut
	name = "\improper flickering figure"
	desc = "A once humanoid figure, flickering uncontrollably in and out of existence."
	icon_state = "holonaut_1"
	icon_dead = "holonaut_dead"
	health = 100 // Less strong, as he isn't wearing anything.
	ranged = 0
	attacktext = "contorts"
	natural_weapon = /obj/item/natural_weapon/punch

/mob/living/simple_animal/hostile/urist/hololab/holonautregular // More dangerous holonaut, with some resistance.
	name = "\improper distorted holonaut"
	desc = "A distorted flickering humanoid, wearing a spacesuit. The limbs inside the suit seem to struggle to move."
	icon_state = "holonaut_2"
	icon_dead = "holonaut_dead"
	health = 150
	resistance = 15 //
	ranged = 0
	attacktext = "tears"
	natural_weapon = /obj/item/natural_weapon/claws

/mob/living/simple_animal/hostile/urist/hololab/holonautsuit
	name = "\improper gesticulating Holonaut"
	desc = "A humanoid gesticulating wildly, wearing a orange spacesuit. The limbs inside seems to animate wildly, as if something were crawling inside it. It looks full of energy!"
	icon_state = "holonaut_3"
	icon_dead = "holonaut_dead"
	health = 50 // Weak, but dangerous up close.
	resistance = 20
	ranged = 0
	natural_weapon = /obj/item/natural_weapon/claws/strong
	attacktext = "rends"
