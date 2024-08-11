
randomize();

switch (state){

	case StateRedCol.Cutscene:
	
		image_xscale = -1;
		
		if (sprite_index != sRedColCutScene)    { sprite_index = sRedColCutScene; image_index = 0;  audio_play_sound(sndRedColCutscene,100,0); }
		if (image_index   >  image_number-1)    { state = StateRedCol.Free; }
	
	break;
	
	case StateRedCol.Free:
		
		sprite_index     = sRedColRun;
		mask_index       = sRedColRun;
		attackcc		-= 1;
		teleportcc		-= 1;
		
		if (x < oPlayer.x) { speed_[h_] += .4; image_xscale =  1; }
		if (x > oPlayer.x) { speed_[h_] -= .4; image_xscale = -1; }
		speed_[h_] = clamp(speed_[h_], -1.8, 1.8);
		
		if (distance_to_object(oPlayer) < 5) attackcc = 3;
		if (distance_to_object(oPlayer) < 3) {
			state		= StateRedCol.Attack; 
			stateattack = StateAttackRedCol.Double
		}
		
		if (attackcc     <= 0) { state = StateRedCol.Charge;   attackcc   = random_range(20,120);    }
		if (teleportcc	 <= 0) { state = StateRedCol.Teleport; teleportcc = random_range(120,180); }

		if (life <= 0) state = StateRedCol.Death;
		
		if speed_[h_] != 0 && cDust = true && place_meeting(x,y+13,oColision) { //dust particles
	
		cDust = false;
	
		var randomtime = irandom_range(-1,2);
		alarm_set(1, 4 + randomtime);
	
		part_particles_create(oParticles.particle_system,x,y+9,oParticles.particle_dust, 8);
	
		}
		
		if (!place_meeting(x,y+1,oColision)) speed_[v_] += eGravity;
		move(speed_,0);
	
	break;
	
	
	case StateRedCol.Charge:
	
		if (sprite_index !=  sRedColCharge)  { sprite_index = sRedColCharge; image_index = 0; }
		if (image_index   > image_number-1)  { 
			
			if (!place_meeting(x+56*image_xscale,y,oColision)) && (place_meeting(x+56*image_xscale,y+1,oColision)) && (!place_meeting(x+58*image_xscale,y,oColision)) && (!place_meeting(x+54*image_xscale,y,oColision)) && (!place_meeting(x+60*image_xscale,y,oColision)) && (!place_meeting(x+52*image_xscale,y,oColision)) && (!place_meeting(x+45*image_xscale,y,oColision)) && (place_meeting(x+45*image_xscale,y+1,oColision)) && (!place_meeting(x+47*image_xscale,y,oColision)) && (!place_meeting(x+43*image_xscale,y,oColision)) && (!place_meeting(x+49*image_xscale,y,oColision)) && (!place_meeting(x+41*image_xscale,y,oColision))
			{
				if (distance_to_object(oPlayer) < 10)
				{
				state = StateRedCol.Attack; 
				stateattack = choose(StateAttackRedCol.Charge,
				StateAttackRedCol.Double,StateAttackRedCol.Dash)
				}
				else 
				{
				state = StateRedCol.Attack; 
				stateattack = choose(StateAttackRedCol.Normal,StateAttackRedCol.Charge,
				StateAttackRedCol.Dash)	
				}
			}
			else
			{	
				state = StateRedCol.Attack; 
				stateattack = choose(StateAttackRedCol.Normal,StateAttackRedCol.Double)
			}
		}
		
		if (life <= 0) state = StateRedCol.Death;
	
	break;
	
	
	case StateRedCol.Attack:
	
	soundattack = choose(sndRedColAttack1,sndRedColAttack2,sndRedColAttack3,sndRedColAttack4);
	
		switch (stateattack){
			
		case StateAttackRedCol.Normal:
		
		if (sprite_index !=    sRedColAttack)  { sprite_index = sRedColAttack; image_index = 0; alarm_set(2,1) }
		if (image_index   >   image_number-1)  { state = StateRedCol.Free }
		
		if (!ds_exists(hitbyattack, ds_type_list)) hitbyattack = ds_list_create();
		ds_list_clear(hitbyattack);
		calcattack(sRedColAttackHitbox,sRedColAttackHitbox,2);
		
		break;
		
		case StateAttackRedCol.Charge:
		
		if (sprite_index !=    sRedColChargeAttack)  { sprite_index = sRedColChargeAttack; image_index = 0; audio_play_sound(sndRedColChargeAttack,100,0); }
		if (image_index   >   image_number-1)  { x += 45 * image_xscale; state = StateRedCol.Free }
		
		if (!ds_exists(hitbyattack, ds_type_list)) hitbyattack = ds_list_create();
		ds_list_clear(hitbyattack);
		calcattack(sRedColChargeAttackHitbox,sRedColChargeAttackHitbox,6);
	
		break;
		
		case StateAttackRedCol.Double:
		
		if (sprite_index !=    sRedColDoubleAttack)  { sprite_index = sRedColDoubleAttack; image_index = 0;  audio_play_sound(sndRedColDoubleAttack,100,0); }
		if (image_index   >   image_number-1)  { state = StateRedCol.Free }
		
		if (!ds_exists(hitbyattack, ds_type_list)) hitbyattack = ds_list_create();
		ds_list_clear(hitbyattack);
		calcattack(sRedColDoubleAttackHitbox,sRedColDoubleAttackHitbox,4);
	
		break;
		
		case StateAttackRedCol.Jump:
		
		if (sprite_index !=    sRedColJumpAttack)  { sprite_index = sRedColJumpAttack; image_index = 0; audio_play_sound(soundattack,100,0); }
		if (image_index   >   image_number-1)  { state = StateRedCol.Free }
		
		if (!ds_exists(hitbyattack, ds_type_list)) hitbyattack = ds_list_create();
		ds_list_clear(hitbyattack);
		calcattack(sRedColJumpAttackHitbox,sRedColJumpAttackHitbox,4);
		
		break;
		
		case StateAttackRedCol.Dash:
		
		if (sprite_index !=    sRedColDashAttack)  { sprite_index = sRedColDashAttack; image_index = 0; audio_play_sound(sndRedColDashAttack,100,0);  }
		if (image_index   >   image_number-1)  { x += 56 * image_xscale; state = StateRedCol.Free }
		
		if (!ds_exists(hitbyattack, ds_type_list)) hitbyattack = ds_list_create();
		ds_list_clear(hitbyattack);
		calcattack(sRedColDashAttackHitbox,sRedColDashAttackHitbox,4);
		
		break;
		
		}
	
	break;
	
	
	case StateRedCol.Teleport:
	
		speed_[h_] = 0;
	
		if (sprite_index !=  sRedColTeleport)  { sprite_index = sRedColTeleport; image_index = 0; alarm_set(0,80); audio_play_sound(sndRedColTeleportIn,100,0); }
		if (image_index   >   image_number-4)  {
			state = StateRedCol.Attack; 
			stateattack = StateAttackRedCol.Jump
		}
		
		if (!place_meeting(x,y+1,oColision))   { speed_[v_] += eGravity;   }
		move(speed_,0);
	
	break;
	
	case StateRedCol.Death:
	
		speed_[h_] = 0;
	
		if (sprite_index  !=     sRedColDeath)  { sprite_index = sRedColDeath; image_index = 0; }
		if (image_index    >   image_number-1)  { instance_destroy(); }
		
		if (!place_meeting(x,y+1,oColision))    { speed_[v_] += eGravity; }
		move(speed_,0);
	
	break;
	
}

if (flash > 0) //flash effect
{
	flash -= 0.05;
}
