
speed_		    = [0, 0];		//Velocidade h_ e v_	
life		    = 60;			//Vida
attackcc		= 60;			//cooldown attack
cDust			= true;		
eGravity		=.6;
depth = -3;
image_speed		= 1;

enum StateAquaCol {						//state machine 
	Cutscene,
	Free,
	Attack,
	SpecialAttack,
	Death,
}

state = StateAquaCol.Free;			//estado inicial

hitbyattack = -1;

flash  = 0;
uflash = shader_get_uniform(shdHitflash, "flash");	//flash effect