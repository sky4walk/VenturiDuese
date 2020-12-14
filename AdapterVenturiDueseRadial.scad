// Andre Betz
// github@AndreBetz.de

RohrDN75DInnen          = 70;
RohrDN75DAussen         = 75;
DueseDurchmesser        = 35;
DueseLaenge             = 30;
EndeLaenge              = 30;
RohrDN75TStueckLange    = 50;
AnschlussDAussen        = 35;
RadialLang              = 30;
RadialBreit             = 20;

$fn=100;

module InnenRohr(
    WandDicke,
    RohrDN75DInnen,
    RohrDN75TStueckLange)
{
    difference()
    {
        cylinder(r=RohrDN75DInnen/2,RohrDN75TStueckLange);
        translate([0,0,-1])
            cylinder(r=RohrDN75DInnen/2-WandDicke,RohrDN75TStueckLange+2);
    }
}

module Duese(
    WandDicke,
    RohrDN75DInnen,
    DueseDurchmesser,
    DueseLaenge
)
{
    difference()
    {
        cylinder(r1=RohrDN75DInnen/2,r2=DueseDurchmesser/2,DueseLaenge);
        translate([0,0,-1])
            cylinder(r1=RohrDN75DInnen/2-WandDicke,r2=DueseDurchmesser/2-WandDicke,DueseLaenge+2);
    }
}

WandDicke = (RohrDN75DAussen - RohrDN75DInnen)/2;

difference()
{
    union()
    {
        difference()
        {
            union()
            {
                cylinder(r=RohrDN75DAussen/2,RohrDN75TStueckLange+DueseLaenge+EndeLaenge*2);
                translate([0,0,RohrDN75TStueckLange+DueseLaenge])
                    rotate([0,90,0])
                        cylinder(r=AnschlussDAussen/2,RohrDN75DAussen/2);
            }
            translate([0,0,-1])
                cylinder(r=RohrDN75DInnen/2,RohrDN75TStueckLange+DueseLaenge+EndeLaenge*2+2);
            translate([0,0,RohrDN75TStueckLange+DueseLaenge])
                    rotate([0,90,0])
                        cylinder(r=AnschlussDAussen/2-WandDicke,RohrDN75DAussen/2+2);
        }
        translate([0,0,WandDicke+RohrDN75TStueckLange])
                    Duese(WandDicke,RohrDN75DAussen,DueseDurchmesser,DueseLaenge);
        translate([0,0,WandDicke+RohrDN75TStueckLange+DueseLaenge])
                    InnenRohr(WandDicke,DueseDurchmesser,EndeLaenge);
        translate([0,0,-WandDicke*2])
        {
            difference()
            {
                cylinder(r1=RohrDN75DAussen/2,r2=RohrDN75DAussen/2,WandDicke*2);
                translate([-RadialLang/2,-RadialBreit/2,-1])
                    cube([RadialLang,RadialBreit,WandDicke*2+2],center = false);
            }    
        }
        // online for viewing
        translate([RohrDN75DAussen/2,0,RohrDN75TStueckLange+DueseLaenge])
            rotate([0,90,0])
                InnenRohr(WandDicke,DueseDurchmesser,EndeLaenge);
        
    }

    translate([-50,-0,0])
        cube([100,100,200],center = false);
}

