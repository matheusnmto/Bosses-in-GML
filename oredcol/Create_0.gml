
speed_		    = [0, 0];		//Velocidade h_ e v_	
life		    = 100;			//Vida
attackcc		= 180;			//cooldown attack
cDust			= true;		
teleportcc		= 240;
eGravity		=.6;
depth = -3;
image_speed		= 1;

enum StateRedCol {						//state machine 
	Cutscene,
	Free,
	Charge,
	Attack,
	Teleport,
	Death,
}

enum StateAttackRedCol {				//state machine (attacks)
	Normal,
	Charge,
	Double,
	Jump,
	Dash,
}

state = StateRedCol.Cutscene;			//estado inicial
stateattack = StateAttackRedCol.Normal;	//estado inicial

hitbyattack = -1;
soundattack =  0;

flash  = 0;
uflash = shader_get_uniform(shdHitflash, "flash");	//flash effect