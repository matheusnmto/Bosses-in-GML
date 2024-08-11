
randomize();

switch(state){ //State Machine
	
	case StateAquaCol.Cutscene:
		
	break;
	
	case StateAquaCol.Free:

		sprite_index     = sAquaColWalk
		attackcc -= 1;
		var playerX      = oPlayer.x;
		
		if (oPlayer.state = PlayerState.Death) state = StateAquaCol.Free;
		
		if (x < playerX) { speed_[h_] += .02; image_xscale =  1; }
		if (x > playerX) { speed_[h_] -= .02; image_xscale = -1; }
		speed_[h_] = clamp(speed_[h_], -0.8, 0.8);
		
		if (distance_to_object(oPlayer) < 10) 
		{
			if (attackcc <= 0)  state = StateAquaCol.Attack;
			speed_[h_] = 0;		
			sprite_index = sAquaColIdle;	
		}	
		
		if (distance_to_object(oPlayer) < 40) 
		{
			random_ = random(64);
			if floor(random_) = 0 && (attackcc <= 3) state = StateAquaCol.SpecialAttack
		}	
		
		if (life <= 0) state = StateAquaCol.Death;
		
		if (!place_meeting(x,y+1,oColision)) speed_[v_] += eGravity;
		move(speed_,0);
	
	break;
	
	case StateAquaCol.Attack:
		
		speed_[h_] = 0;		
		if (sprite_index != sAquaColAttack) { sprite_index = sAquaColAttack; image_index = 0; attackcc = 20; }
		if (!ds_exists(hitbyattack, ds_type_list)) hitbyattack = ds_list_create();
		ds_list_clear(hitbyattack);
		calcattack(sAquaColAttackHitbox,sAquaColIdle,2);
		
		if (image_index > image_number -1)
		{
			state = StateAquaCol.Free;	
		}	
		if (life <= 0) state = StateAquaCol.Death;
		
		if (!place_meeting(x,y+1,oColision)) speed_[v_] += eGravity;
		move(speed_,0);
	
	break;
	
	case StateAquaCol.SpecialAttack:
	
		speed_[h_] = 0;		
		if (sprite_index != sAquaColSpecialAttack) { sprite_index = sAquaColSpecialAttack; image_index = 0; attackcc = 40; }
		if (!ds_exists(hitbyattack, ds_type_list)) hitbyattack = ds_list_create();
		ds_list_clear(hitbyattack);
		calcattack(sAquaColSpecialAttackHitbox,sAquaColIdle,4);
		
		if (image_index > image_number-1)
		{
			state = StateAquaCol.Free;	
		}	
	
		if (!place_meeting(x,y+1,oColision)) speed_[v_] += eGravity;
		move(speed_,0);
		
	break;
	
	case StateAquaCol.Death:
	
		speed_[h_] = 0;		
		if (sprite_index != sAquaColDeath) { sprite_index = sAquaColDeath; image_index = 0; }
		
		if (image_index > image_number-1)
		{
			instance_destroy();
		}	
		
		if (!place_meeting(x,y+1,oColision)) speed_[v_] += eGravity;
		move(speed_,0);
	
	break;
	
}

if speed_[h_] != 0 && cDust = true && place_meeting(x,y+1,oColision) { //dust particles
	
	cDust = false;
	
	var randomtime = irandom_range(-1,2);
	alarm_set(1, 4 + randomtime);
	
	part_particles_create(oParticles.particle_system,x,y+9,oParticles.particle_dust, 8);
	
}
	
if (flash > 0) //flash effect
{
	flash -= 0.05;
}

