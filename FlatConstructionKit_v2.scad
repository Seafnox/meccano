include <./threads_v2.scad>;

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//Inner Modules, draws the parts
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

module l_plate(
	xSize = 4,
	ySize = 1,
	zSize = 1,
	holeDiameter = 3,
	baseUnit = 9,
	thickness = 2,
	clearance = 0.5,
	needCorners = "yes"
)
{
	//module to draw flat plates and L beams.
	_w = baseUnit * xSize;
	_h = baseUnit * ySize;
	_z = (baseUnit * zSize)+ thickness;
	edgeOffset = thickness*2;
	cornerSize = baseUnit / 2;
	holeDistance = (baseUnit - holeDiameter - clearance) / 2;
	echo("build area required(x\y\z)",_w,_h,_z);

	union()
	{
		simple_plate(xSize = xSize, ySize = ySize, holeDiameter = holeDiameter, baseUnit = baseUnit,thickness = thickness,clearance = clearance, needCorners=needCorners);
		if( zSize > 0 )
		{
			translate([0,-thickness,edgeOffset])
			rotate([90,0,0])
				simple_plate(xSize = xSize, ySize = zSize, holeDiameter = holeDiameter, baseUnit = baseUnit,thickness = thickness,clearance = clearance, needCorners=needCorners);
			translate([0,-edgeOffset,0])
				cube([_w,edgeOffset,thickness]);
			translate([0,-edgeOffset,0])
				cube([_w,thickness,edgeOffset]);
			if( needCorners == "yes" )
			{
				translate([0,0,0])
					cube([holeDistance,cornerSize,thickness]);
				translate([0,0,0])
					cube([cornerSize,holeDistance,thickness]);
				translate([_w-holeDistance,0,0])
					cube([holeDistance,cornerSize,thickness]);
				translate([_w-cornerSize,0,0])
					cube([cornerSize,holeDistance,thickness]);
				translate([0,-thickness*2,thickness*2])
					cube([holeDistance,thickness,cornerSize]);
				translate([0,-thickness*2,thickness*2])
					cube([cornerSize,thickness,holeDistance]);
				translate([_w-holeDistance,-thickness*2,thickness*2])
					cube([holeDistance,thickness,cornerSize]);
				translate([_w-cornerSize,-thickness*2,thickness*2])
					cube([cornerSize,thickness,holeDistance]);
			}
		}
	}
}

module angle_plate(
	xSize = 4,
	ySize = 1,
	zSize=1,
	angle=90,
	holeDiameter = 3,
	baseUnit = 9,
	thickness = 2,
	clearance = 0.5,
	needCorners="yes"
)
{
	//module to draw flat plates and L beams.
	_w = baseUnit * zSize;
	_h = baseUnit * ySize;
	_z = (baseUnit * zSize) + thickness;
	edgeOffset = thickness*2;
	cornerSize = baseUnit / 2;
	holeDistance = (baseUnit - holeDiameter - clearance) / 2;

	echo("build area required(x\y\z)",_w,_h,_z);

	union()
	{	
		rotate([0,270,-angle/2])
		translate([0,0,-thickness])
			union() {
				simple_plate(xSize = zSize, ySize = xSize, holeDiameter = holeDiameter, baseUnit = baseUnit,thickness = thickness,clearance = clearance, needCorners=needCorners);
				translate([0,0,0])
					cube([holeDistance,cornerSize,thickness]);
				translate([0,0,0])
					cube([cornerSize,holeDistance,thickness]);
				translate([_w-holeDistance,0,0])
					cube([holeDistance,cornerSize,thickness]);
				translate([_w-cornerSize,0,0])
					cube([cornerSize,holeDistance,thickness]);
			}
		rotate([0,270,angle/2])
		translate([0,0,0])
			union() {
				simple_plate(xSize = zSize, ySize = ySize, holeDiameter = holeDiameter, baseUnit = baseUnit,thickness = thickness,clearance = clearance, needCorners=needCorners);
				translate([0,0,0])
					cube([holeDistance,cornerSize,thickness]);
				translate([0,0,0])
					cube([cornerSize,holeDistance,thickness]);
				translate([_w-holeDistance,0,0])
					cube([holeDistance,cornerSize,thickness]);
				translate([_w-cornerSize,0,0])
					cube([cornerSize,holeDistance,thickness]);
			}
		translate([0,-clearance*2,0])
			cylinder(r = thickness-clearance, h=_w);
	}

}


module round_plate(
	xSize = 4,
	ySize = 1,
	angle = 90,
	holeDiameter = 3,
	baseUnit = 9,
	thickness = 2,
	clearance = 0.5,
	needCorners="yes"
)
{
	//module to make round plate with n holes at specified angle
	_w = baseUnit * xSize;
	_h = baseUnit * ySize;
	_eff_d = _w - (holeDiameter*2);
	_c = 3.142 *_eff_d;
	directionCount = 360 / angle;
	stepAngle = 360/directionCount;

	echo("Build area (xyz)", _w,_w,_eff_d,directionCount,_c);

	difference()
	{
		cylinder(r=_w/2, h=thickness);
		for(direction = [0:directionCount-1])
		{
			for( ri = [0:floor(xSize/2)])
			{
			rotate([0,0,direction*stepAngle])
			#translate([ri*baseUnit,0,-1])
				cylinder(r=(holeDiameter+clearance)/2, h = thickness+2);
			}
		}
	}
}


module wheel(
	xSize = 4,
	holeDiameter = 3,
	baseUnit = 2,
	thickness = 2,
	clearance = 0.5,
	pully=false,
	cordDiameter=1,
	quality = 10
)
{
	//module to make wheels and pulleys
	_w = baseUnit * xSize;
	_cr = thickness*1;


	echo("Build area (xyz)", _w+(2*_cr),_w+(2*_cr),2*_cr);

	difference()
	{
		union()
		{
			translate([0,0,-_cr])
				cylinder(r=_w/2, h=thickness);
			translate([0,0,-_cr])
				cylinder(r=(holeDiameter+clearance)*1.5, h = thickness +_cr);
			rotate_extrude(convexity = 10)
				translate([_w/2,0,_cr])
			//rotate([90,0,0])
					circle(r = _cr);
            if(pully == false)
                {
                    for(i=[1:1:(quality/2)]){
                         rotate([90,0,(360/(quality/2))*i])
                         translate([_w/2,0,-_cr/2]) linear_extrude(_cr/2)
                              circle(r = _cr*1.05);
                    }
                }
		}
			if(pully)
				{
					rotate_extrude(convexity = 10)
					#translate([(_w+_cr)/2,0,_cr])
						circle(r = (cordDiameter)/2);
					rotate_extrude(convexity = 10)
					#translate([(_w+_cr)/2,-cordDiameter/2,0])
						square([cordDiameter+_cr,cordDiameter]);
				}

			#translate([0,0,-_cr-1])
				cylinder(r=(holeDiameter+clearance)/2, h = thickness+2+_cr);
	}
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//Support Modules, draws bits of the parts
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
module simple_plate(
	xSize = 4,
	ySize = 1,
	holeDiameter = 3,
	baseUnit = 9,
	thickness = 2,
	clearance = 0.5,
	needCorners="yes"
)
{
	//module to draw flat plates and L beams.
	_w = baseUnit * xSize;
	_h = baseUnit * ySize;
	doubleOuterRadius = baseUnit * 0.95; // for minkowski support
	outerRadius = doubleOuterRadius / 2;

	difference()
	{
		if (needCorners=="yes")
		{
			minkowski()
			{
				cube([_w-doubleOuterRadius,_h-doubleOuterRadius,thickness/2]);
				translate([outerRadius,outerRadius,0])
					cylinder(r = outerRadius, h = thickness/2);
			}
		}
		if (needCorners=="no")
		{
			cube([_w,_h,thickness]);
		}
		for ( y = [0:ySize-1])
		{
			for( x = [0:xSize-1])
			{
				#translate([baseUnit/2+(x*baseUnit),baseUnit/2+(y*baseUnit),-1])
					cylinder(r = (holeDiameter + clearance)/2, h = thickness + 2);
			}
		}
	}

}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//Dev Modules, not working yet
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
module screw(
	ySize = 1,
	holeDiameter = 3,
	baseUnit = 9,
	thickness = 2,
	clearance = 0.5,
	quality = 10
)
{
    length = baseUnit * ySize / 2;

    metric_thread (diameter=holeDiameter - clearance/2, pitch=0.72, length=length, thread_size = 1, quality = quality);
}

module nut(
	ySize = 1,
	holeDiameter = 3,
	baseUnit = 9,
	thickness = 2,
	clearance = 0.5,
	quality = 10
)
{
    length = baseUnit * ySize;
	
	difference() {
		cylinder(r = (baseUnit - clearance) / 2, h = length, $fn = 6);
		metric_thread (diameter=holeDiameter + clearance/2, pitch=0.5, length=length, thread_size = 0.5, quality = quality);
	}
}
