/*
Meccano Construction Kit

>>>Parts to be implimented
Rectangle Plate n x m, v1.0
Circular Plate, v1.0
L_beam, v1.0
angle beam, v1.0 (scruffy a<90)
Free Shape Plate -- to follow
Wheel, v1.0
Pully, v1.0
Gears -- to follow
>>>tweakable Parameter
Hole Size
Hole ratio
Clearance
Pulley Cord diameter
>>>>Changes
v1.01, hole size now free entry
*/

include <./FlatConstructionKit_v2.scad>

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//Customiser Code
//For Library use comment this and the section bellow out
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
///*
//shape of part	
shape = "simple_plate";	// [simple_plate,flat_L_plate,L_plate,flat_U_plate,U_plate,flat_T_plate,flat_angle_plate,angle_plate,rotated_plate,round_plate,wheel,pully,screw,nut]
//holes across, also used to determine size of round plate and gear
x_holes=5;				//	
//holes in the up down direction
y_holes= 4;				//
//holes on L plate side
z_holes = 2;			//
//of angle beam, or between holes on circle
angle = 120;				// 
//thickness of part
thickness = 1.5;			//
//size of screws and rod used
hole_diameter = 4;	//
//tweak,distance between holes in diameters
base_unit = 10.10;		//
//cord diameter for pullys
cord_diameter = 1.5;  //
//tweak, clearance on holes //[0.1:1]
clearance = 0.3;		
//tweak, round or square corners
roundedCorners = "yes";	//[yes,no]
//tweak, corner quality, nuber of facets
quality = 64;  		//[24,32,48,64,128]

$fn = quality;
							
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//Test Section, draws the part. 
//For Library use follow this structure in your own code
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
construction_set_part();

//*/ 
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//Outer Module, does the selection work
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
module construction_set_part();
{
	echo(shape,x_holes,y_holes,z_holes);
	if	(shape=="simple_plate")
		{
			color("red")
			simple_plate(
				xSize = x_holes,
				ySize = y_holes,
				holeDiameter = hole_diameter,
				baseUnit = base_unit,
				thickness = thickness,
				clearance = clearance,
				needCorners=roundedCorners
			);
		}
	if	(shape=="flat_L_plate")
		{
			color("pink")
			flat_l_plate(
				xSize = x_holes,
				ySize = y_holes,
				holeDiameter = hole_diameter,
				baseUnit = base_unit,
				thickness = thickness,
				clearance = clearance,
				needCorners=roundedCorners
			);
		}
	if	(shape=="L_plate")
		{
			color("olive")
			l_plate(
				xSize = x_holes,
				ySize = y_holes,
				zSize = z_holes,
				holeDiameter = hole_diameter,
				baseUnit = base_unit,
				thickness = thickness,
				clearance = clearance,
				needCorners=roundedCorners
			);
		}
	if	(shape=="flat_U_plate")
		{
			color("orchid")
			flat_u_plate(
				xSize = x_holes,
				ySize = y_holes,
				angle = 90,
				holeDiameter = hole_diameter,
				baseUnit = base_unit,
				thickness = thickness,
				clearance = clearance,
				needCorners=roundedCorners
			);
		}
	if	(shape=="U_plate")
		{
			color("green")
			u_plate(
				xSize = x_holes,
				ySize = y_holes,
				zSize = z_holes,
				angle = 90,
				holeDiameter = hole_diameter,
				baseUnit = base_unit,
				thickness = thickness,
				clearance = clearance,
				needCorners=roundedCorners
			);
		}
	if	(shape=="flat_T_plate")
		{
			color("orchid")
			flat_t_plate(
				xSize = x_holes,
				ySize = y_holes,
				angle = 90,
				holeDiameter = hole_diameter,
				baseUnit = base_unit,
				thickness = thickness,
				clearance = clearance,
				needCorners=roundedCorners
			);
		}
	if	(shape=="flat_angle_plate")
		{
			color("coral")
			flat_angle_plate(
				xSize = x_holes,
				ySize = y_holes,
				zSize = z_holes,
				angle = angle,
				holeDiameter = hole_diameter,
				baseUnit = base_unit,
				thickness = thickness,
				clearance = clearance,
				needCorners=roundedCorners
			);
		}
	if	(shape=="angle_plate")
		{
			color("tomato")
			angle_plate(
				xSize = x_holes,
				ySize = y_holes,
				zSize = z_holes,
				angle = angle,
				holeDiameter = hole_diameter,
				baseUnit = base_unit,
				thickness = thickness,
				clearance = clearance,
				needCorners=roundedCorners
			);
		}
	if	(shape=="rotated_plate")
		{
			color("tomato")
			rotated_plate(
				xSize = x_holes,
				ySize = y_holes,
				zSize = z_holes,
				holeDiameter = hole_diameter,
				baseUnit = base_unit,
				thickness = thickness,
				clearance = clearance,
				needCorners=roundedCorners
			);
		}
	if	(shape=="round_plate")
		{
			color("steelblue")
			round_plate(
				xSize = x_holes,
				ySize = y_holes,
				zSize = z_holes,
				holeDiameter = hole_diameter,
				baseUnit = base_unit,
				thickness = thickness,
				clearance = clearance,
				needCorners=roundedCorners
			);
		}
	if	(shape=="wheel")
		{
			color("plum")
			wheel(
				xSize = x_holes,
				holeDiameter = hole_diameter,
				baseUnit = base_unit,
				thickness = thickness,
				clearance = clearance,
				pully = false,
				cordDiameter=0,
				quality = quality
			);
		}
	if	(shape=="pully")
		{
			color("pink")
			wheel(
				xSize = x_holes,
				holeDiameter = hole_diameter,
				baseUnit = base_unit,
				thickness = thickness,
				clearance = clearance,
				pully = true,
				cordDiameter=cord_diameter,
				quality = quality
			);
		}
	if	(shape=="screw")
		{
			color("goldenrod")
			screw(
				ySize = y_holes,
				holeDiameter = hole_diameter,
				baseUnit = base_unit,
				thickness = thickness,
				clearance = clearance,
				quality = quality
			);
		}
	if	(shape=="nut")
		{
			color("peru")
			nut(
				ySize = y_holes,
				holeDiameter = hole_diameter,
				baseUnit = base_unit,
				thickness = thickness,
				clearance = clearance,
				quality = quality
			);
		}
}
