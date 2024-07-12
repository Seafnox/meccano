//OpenSCAD script for creating construction beams


//Number of BlockUnits in the X direction
    XSize=5;
//Number of BlockUnits in the Y direction
    YSize=1; 
    
//Universal values

//Universal block unit (mm)
    BaseUnit=15.84;
//Universal radius (mm) of the connection hole
    HoleRadius=2.5;
    Quality=64; //Universal tesselation value of curved surfaces
    ChamferHoleCoef=1.2; //Chamfer size adjustment value for connection holes

ChamferHoleRadius = HoleRadius*ChamferHoleCoef;
    
buildBeam(XSize, YSize, BaseUnit, HoleRadius, ChamferHoleRadius, Quality);


module buildBeam(XSize, YSize, BaseUnit, HoleRadius, ChamferHoleRadius, Quality) {
    Epsilon = 0.1;
    $fn=Quality;
    ZSize = 1;

    difference(){
        cube([BaseUnit*XSize, BaseUnit*YSize, BaseUnit*ZSize]);   
        for(i = [0:XSize-1]){
            translate([i*BaseUnit,0,0])
                XHoles(           
                    YSize = YSize,
                    BaseUnit = BaseUnit,
                    HoleRadius = HoleRadius,
                    ChamferHoleRadius = ChamferHoleRadius,
                    Epsilon = Epsilon
                );
        }
        for(i = [0:YSize-1]){
            translate([0,i*BaseUnit,0])
                YHoles(
                    XSize = XSize,
                    BaseUnit = BaseUnit,
                    HoleRadius = HoleRadius,
                    ChamferHoleRadius = ChamferHoleRadius,
                    Epsilon = Epsilon
                );
        }
        ZArray(
            XSize = XSize,
            YSize = YSize,
            BaseUnit = BaseUnit,
            HoleRadius = HoleRadius,
            ChamferHoleRadius = ChamferHoleRadius,
            Epsilon = Epsilon
        );
    }

}



//MODULES
module XHoles(YSize, BaseUnit, HoleRadius, ChamferHoleRadius, Epsilon){
    union(){
        translate([BaseUnit/2,-Epsilon,BaseUnit/2])
            rotate([270,0,0])
                cylinder(h=ChamferHoleRadius, r1=ChamferHoleRadius, r2=0);
        translate([BaseUnit/2,Epsilon+YSize*BaseUnit,BaseUnit/2])
            rotate([90,0,0])
                cylinder(h=ChamferHoleRadius, r1=ChamferHoleRadius, r2=0);
        translate([BaseUnit/2,0,BaseUnit/2])
            rotate([270,0,0])
                cylinder(r=HoleRadius, h=YSize*BaseUnit);
    }
}

module YHoles(XSize, BaseUnit, HoleRadius, ChamferHoleRadius, Epsilon){
    union(){
        translate([-Epsilon,BaseUnit/2,BaseUnit/2])
            rotate([0,90,0])
                cylinder(h=ChamferHoleRadius, r1=ChamferHoleRadius, r2=0);
        translate([Epsilon+XSize*BaseUnit,BaseUnit/2,BaseUnit/2])
            rotate([0,270,0])
                cylinder(h=ChamferHoleRadius, r1=ChamferHoleRadius, r2=0);
        translate([0,BaseUnit/2,BaseUnit/2])
            rotate([0,90,0])
                cylinder(r=HoleRadius, h=XSize*BaseUnit);
    }
}
module ZHoles(BaseUnit, HoleRadius, ChamferHoleRadius, Epsilon){
    union(){
        translate([BaseUnit/2,BaseUnit/2,-Epsilon])
            rotate([0,0,0])
                cylinder(h=ChamferHoleRadius, r1=ChamferHoleRadius, r2=0);
        translate([BaseUnit/2,BaseUnit/2,Epsilon+BaseUnit])
            rotate([180,0,0])
                cylinder(h=ChamferHoleRadius, r1=ChamferHoleRadius, r2=0);
        translate([BaseUnit/2,BaseUnit/2,0])
            rotate([0,0,0])
                cylinder(r=HoleRadius, h=BaseUnit);
    }
}

module ZArray(XSize, YSize, BaseUnit, HoleRadius, ChamferHoleRadius, Epsilon){
    for(a = [0:XSize-1]){
        translate([a*BaseUnit,0,0]){
            for(i = [0:YSize-1]){
                translate([0,i*BaseUnit,0])
                    ZHoles(BaseUnit, HoleRadius, ChamferHoleRadius, Epsilon);
            }
        }
    }
}

