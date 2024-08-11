
randomize();

switch (state) {

	case StateRuinedRobot.Cutscene:
	
		image_xscale = -1;
		
		if (sprite_index != sRuinedRobotCutscene)    { sprite_index = sRuinedRobotCutscene; image_index = 0; audio_play_sound(sndRuinedRobotCutscene,100,0); }
		if (image_index   >  image_number-1		)	 { state = StateRuinedRobot.Free; }
	
	break;
	
	case StateRuinedRobot.Free:
	
		sprite_index = sRuinedRobotIdle;
		mask_index   = sRuinedRobotIdle;
		attackcc	-= 1;
		buffcc		-= 1;
		image_speed  = im;
		
		if (attackcc     <= 0) {   
			attackcc = attackcooldown;
			stateattack = choose(StateAttackRuinedRobot.Chase,StateAttackRuinedRobot.Range,StateAttackRuinedRobot.Super,StateAttackRuinedRobot.Melee) 
			durattack = 360; 
			if (stateattack != lastattack) { state = StateRuinedRobot.Attack; }
		}
		if (buffcc	     <= 0) { state = StateRuinedRobot.Buff;		buffcc   = random_range(buffcooldown-20,buffcooldown+60);      }
		
		if (x < oPlayer.x) && (image_xscale = -1) { state = StateRuinedRobot.TurnStopped; side = -1; };
		if (x > oPlayer.x) && (image_xscale =  1) { state = StateRuinedRobot.TurnStopped; side =  1; };
		
		if (life <= 0) { state = StateRuinedRobot.Death; }
		
	break;
	
	case StateRuinedRobot.Buff:
	
		if (sprite_index != sRuinedRobotBuff)		 { sprite_index = sRuinedRobotBuff; image_index = 0 audio_play_sound(sndRuinedRobotBuff,100,0); }
		if (image_index   >  image_number-1 )		 { state = StateRuinedRobot.Free; if (attackcooldown != 10) { buffcooldown -= 30; attackcooldown -= 10; mspeed += .4; }}
		
		if (life <= 0) { state = StateRuinedRobot.Death; }
		
	break;
	
	case StateRuinedRobot.Turn:
	
	image_speed = 1;
	
	var dir = point_direction(x, y, oPlayer.x, 78);
	speed_[h_] += lengthdir_x(0.05, dir);
	speed_[v_] += lengthdir_y(0.05, dir);
	speed_[h_] = clamp(speed_[h_], -mspeed, mspeed);
	
	move(speed_, 0);
	
	switch (side) {

		case  1:
		if (sprite_index != sRuinedRobotTurnLeft)	 { sprite_index = sRuinedRobotTurnLeft; image_index = 0; }
		if (image_index   >  image_number-1 )		 { state = StateRuinedRobot.Attack; stateattack = StateAttackRuinedRobot.Chase; image_xscale = -1; x -= 11; side = 0; }
		break;
		
		case -1:
		if (sprite_index != sRuinedRobotTurnLeft)	 { sprite_index = sRuinedRobotTurnLeft; image_index = 0; }
		if (image_index   >  image_number-1 )		 { state = StateRuinedRobot.Attack; stateattack = StateAttackRuinedRobot.Chase; image_xscale =  1; x += 11; side = 0; }
		break;
		
	}
	
	break;
	
	case StateRuinedRobot.TurnStopped:
	
	attackcc	-= 1;
	buffcc		-= 1;
	image_speed = 1;
	
	switch (side) {

		case  1:
		if (sprite_index != sRuinedRobotTurnLeft)	 { sprite_index = sRuinedRobotTurnLeft; image_index = 0; }
		if (image_index   >  image_number-1 )		 { state = StateRuinedRobot.Free; image_xscale = -1; x -= 11; side = 0; }
		break;
		
		case -1:
		if (sprite_index != sRuinedRobotTurnLeft)	 { sprite_index = sRuinedRobotTurnLeft; image_index = 0; }
		if (image_index   >  image_number-1 )		 { state = StateRuinedRobot.Free; image_xscale =  1; x += 11; side = 0; }
		break;
		
	}
	
	break;
	
	case StateRuinedRobot.Attack:
	
		switch (stateattack) {
			
			case StateAttackRuinedRobot.Chase:
			
			sprite_index = sRuinedRobotMove;
			durattack   -= 1;
			
			var dir = point_direction(x, y, oPlayer.x, 78);
			speed_[h_] += lengthdir_x(0.05, dir);
			speed_[h_] = clamp(speed_[h_], -mspeed, mspeed);
			
			if (x < oPlayer.x) && (image_xscale = -1) { state = StateRuinedRobot.Turn; side = -1; };
			if (x > oPlayer.x) && (image_xscale =  1) { state = StateRuinedRobot.Turn; side =  1; };
			
			if (durattack <= 0)  { state = StateRedCol.Free; }
			
			if (life <= 0)		 { state = StateRuinedRobot.Death; lastattack = StateAttackRuinedRobot.Chase }
			
			move(speed_, 0);		
		
			break;
			
			case StateAttackRuinedRobot.Melee:
			
				if (sprite_index !=    sRuinedRobotMeleeAttack)  { sprite_index = sRuinedRobotMeleeAttack; image_index = 0; alarm_set(0,80/image_speed); alarm_set(1,81/image_speed)  audio_play_sound(sndRuinedRobotMeleeAttack,100,0); }
				if (image_index   >   image_number-1)  { state = StateRedCol.Free lastattack = StateAttackRuinedRobot.Melee }
		
				if (!ds_exists(hitbyattack, ds_type_list)) hitbyattack = ds_list_create();
				ds_list_clear(hitbyattack);
				calcattack(sRuinedRobotMeleeAttackHitbox,sRuinedRobotMeleeAttackHitbox,4);
				
			break;
			
			case StateAttackRuinedRobot.Range:
			
				if (sprite_index !=    sRuinedRobotRangeAttack)  { sprite_index = sRuinedRobotRangeAttack; image_index = 0; audio_play_sound(sndRuinedRobotRangeAttack,100,0); }
				if (image_index   >   image_number-1)  { state = StateRedCol.Free lastattack = StateAttackRuinedRobot.Range }
		
				if (!ds_exists(hitbyattack, ds_type_list)) hitbyattack = ds_list_create();
				ds_list_clear(hitbyattack);
				calcattack(sRuinedRobotRangeAttackHitbox,sRuinedRobotRangeAttackHitbox,3);
			
			break;
			
			case StateAttackRuinedRobot.Super:
			
				if (sprite_index !=    sRuinedRobotSuperAttack)  { sprite_index = sRuinedRobotSuperAttack; image_index = 0;  audio_play_sound(sndRuinedRobotSuperAttack,100,0); }
				if (image_index   >   image_number-1)  { state = StateRedCol.Free lastattack = StateAttackRuinedRobot.Super }
		
				if (!ds_exists(hitbyattack, ds_type_list)) hitbyattack = ds_list_create();
				ds_list_clear(hitbyattack);
				calcattack(sRuinedRobotSuperAttackHitbox,sRuinedRobotSuperAttackHitbox,6);
			
			break;
		}
	
	break;
	
	case StateRuinedRobot.Death:
	
		image_speed = 1;
	
		if (sprite_index != sRuinedRobotDeath)		 { sprite_index = sRuinedRobotDeath; image_index = 0;  audio_play_sound(sndRuinedRobotDeath,100,0); }
		if (image_index   >  image_number-1 )		 { image_speed = 0; }
	
	break;
	
}

if (flash > 0) //flash effect
{
	flash -= 0.05;
}

show_debug_message(life)