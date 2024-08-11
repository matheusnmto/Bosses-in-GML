
if (state != StateRedCol.Cutscene) && (state != StateRedCol.Teleport)
{
	if (state != StateRedCol.Death) flash = 1;

	if (oGunPlayer.sprite_index = sGunPlayer) life -= 1;
	if (oGunPlayer.sprite_index = sGun2Player) life -= 2;
}