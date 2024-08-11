
if (flash != 0)	//flash effect
{
	shader_set(shdHitflash);
	shader_set_uniform_f(uflash,flash);
}

draw_sprite_ext(
	sprite_index,
	image_index,
	x,
	y,
	image_xscale,
	image_yscale,
	image_angle,
	image_blend,
	image_alpha)

if (shader_current() != -1) shader_reset();