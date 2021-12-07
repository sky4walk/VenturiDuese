// Andre Betz
// github@AndreBetz.de

platteDicke = 2;
// Durchmesser Topf oben Rand 150L Topf
topfDurchmesser = 635;
// durchmesser der schuessel aussen
haubeDurchmesser = 480;
// rand auf dem die Haube aufliegt
auflageRand = 20;
// M5
schraubeBohrlochM5 = 5;
//tauchhuelse
sensorBohrloch = 22;

$fn=100;

module HaubeAdapter() {
    innenDurchmesser = haubeDurchmesser - 2*auflageRand;
    echo(innenDurchmesser);
    difference() {
        cylinder(platteDicke,topfDurchmesser/2,topfDurchmesser/2,false);
        translate([0,0,-1]) 
            cylinder(platteDicke+2,innenDurchmesser/2,innenDurchmesser/2,false);
        // Halterungsloecher
        translate([-haubeDurchmesser/2+auflageRand/2,0,-1]) 
            cylinder(platteDicke+2,schraubeBohrlochM5/2,schraubeBohrlochM5/2,false);    
        translate([+haubeDurchmesser/2-auflageRand/2,0,-1]) 
            cylinder(platteDicke+2,schraubeBohrlochM5/2,schraubeBohrlochM5/2,false);      
        translate([0,-haubeDurchmesser/2+auflageRand/2,-1]) 
            cylinder(platteDicke+2,schraubeBohrlochM5/2,schraubeBohrlochM5/2,false);    
        translate([0,+haubeDurchmesser/2-auflageRand/2,-1]) 
            cylinder(platteDicke+2,schraubeBohrlochM5/2,schraubeBohrlochM5/2,false);
        // Tauchhuelse
        randKomplett = topfDurchmesser - haubeDurchmesser;
        echo(randKomplett);
        translate([0,haubeDurchmesser/2+randKomplett/4,-1]) 
            cylinder(platteDicke+2,sensorBohrloch/2,sensorBohrloch/2,false);
    }
}

//projection() 
{ 
    HaubeAdapter();
}
