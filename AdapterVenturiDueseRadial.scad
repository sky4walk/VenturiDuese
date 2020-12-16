// Andre Betz
// github@AndreBetz.de

RohrDN75DInnen          = 70;
RohrDN75DAussen         = 75;
DueseDurchmesser        = 35;
EndeLaenge              = 15;
RohrDN75TStueckLange    = 160;
RohrDN50TStueckAussen   = 50;
RadialLang              = 57;
RadialBreit             = 30;
RadialTiefe             = 10;

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
                cylinder(r=RohrDN75DAussen/2,RohrDN75TStueckLange);
                translate([0,0,RohrDN75TStueckLange/2])
                    rotate([0,90,0])
                        cylinder(r=RohrDN50TStueckAussen/2+WandDicke,RohrDN75DAussen/2);
            }

            translate([0,0,-1])
                cylinder(r=RohrDN75DInnen/2,RohrDN75TStueckLange+2);
            translate([0,0,RohrDN75TStueckLange/2])
                    rotate([0,90,0])
                        cylinder(r=RohrDN50TStueckAussen/2-WandDicke,RohrDN75DAussen/2+2);
            
        }
        translate([0,0,RohrDN75TStueckLange/2-RohrDN50TStueckAussen/2])
                    Duese(WandDicke,RohrDN75DAussen,DueseDurchmesser,RohrDN50TStueckAussen/2);
        translate([0,0,RohrDN75TStueckLange/2])
                    InnenRohr(WandDicke,DueseDurchmesser,RohrDN50TStueckAussen/2);
        translate([0,0,-RadialTiefe])
        {
            difference()
            {
                cylinder(r1=RohrDN75DAussen/2,r2=RohrDN75DAussen/2,RadialTiefe);
                translate([-RadialLang/2,-RadialBreit/2,-1])
                    cube([RadialLang,RadialBreit,RadialTiefe+2],center = false);
            }    
        }
        // online for viewing        
        translate([RohrDN75DAussen/2,0,RohrDN75TStueckLange/2])
            rotate([0,90,0])
                InnenRohr(WandDicke,RohrDN50TStueckAussen+WandDicke*2,EndeLaenge);
        
    }

    translate([-50,-0,0]) cube([200,100,200],center = false);
}

