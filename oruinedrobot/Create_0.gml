
depth = -4;

enum StateRuinedRobot {			//state machine 
	Cutscene,
	Free,
	Buff,
	Turn,
	TurnStopped,
	Attack,
	Death,
}

enum StateAttackRuinedRobot {	//state machine (attacks)
	Super,
	Chase,
	Melee,
	Range,
}

state = StateRuinedRobot.Cutscene;				//estado inicial
stateattack = StateAttackRuinedRobot.Super;		//estado inicial

attackcooldown = 60;
buffcooldown   = 200;
durattack      = 360;
lastattack     = StateAttackRuinedRobot.Chase;

attackcc	= attackcooldown;
buffcc		= buffcooldown;
speed_		= [0, 0];
mspeed		=  0.8;
side		=  0;
hitbyattack = -1;
im = 1;

life   = 200;
flash  = 0;
uflash = shader_get_uniform(shdHitflash, "flash");	//flash effect