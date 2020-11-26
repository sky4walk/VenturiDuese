// Andre Betz
// github@AndreBetz.de

printBoden              = false;
//printBoden              = true;
WandDicke               = 5;
LuefterLaenge           = 120;
LuefterTiefe            = 20;
RohrDN75DInnen          = 70;
RohrDN75DAussen         = 75;
DueseDurchmesser        = 35;
DueseLaenge             = 35;
RohrDN75TStueckLange    = 300;
BohrlochM3              = 3;
AbstandLuefterRohr      = 50;

$fn=100;

module LuefterHalterung(
    WandDicke,
    LuefterLaenge,
    LuefterTiefe,
    Bohrloch) {
    difference()
    {        
        cube([LuefterLaenge+2*WandDicke,
            LuefterLaenge+2*WandDicke,
            LuefterTiefe+WandDicke],
            center = false);
        translate([WandDicke,WandDicke,-1])    
            cube([LuefterLaenge,
                LuefterLaenge,
                LuefterTiefe+1],
                center = false);
        translate([WandDicke*1.5,WandDicke*1.5,LuefterTiefe-1])
            cube([LuefterLaenge-WandDicke,
                LuefterLaenge-WandDicke,
                LuefterTiefe+1],
                center = false); 
    }   
}

module UebergangsRohrHuelle(
    Boden,
    LuefterLaenge,
    AbstandLuefterRohr,
    RohrDN75DInnen) 
{
    hull()
    {
        translate([LuefterLaenge/2,LuefterLaenge/2,AbstandLuefterRohr])
            cylinder(r=RohrDN75DInnen/2,Boden);
        cube([LuefterLaenge,LuefterLaenge,Boden],center = false);
    }    
}

module UebergangsRohr(
    WandDicke,
    LuefterLaenge,
    AbstandLuefterRohr,
    RohrDN75DInnen) 
{
    difference()
    {
        UebergangsRohrHuelle(WandDicke,LuefterLaenge+2*WandDicke,AbstandLuefterRohr,RohrDN75DInnen);
        translate([WandDicke,WandDicke,0])
            UebergangsRohrHuelle(WandDicke,LuefterLaenge,AbstandLuefterRohr,RohrDN75DInnen-2*WandDicke);
        translate([WandDicke,
                   WandDicke,
                   -1])    
            cube([LuefterLaenge,
                  LuefterLaenge,
                  WandDicke+2]);
        translate([LuefterLaenge/2+WandDicke,
                        LuefterLaenge/2+WandDicke,
                        AbstandLuefterRohr-2])    
                cylinder(r=RohrDN75DInnen/2-WandDicke,WandDicke+4);
    }
}

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

module Befestigung(
    WandDicke,
    LuefterLaenge,
    LuefterTiefe,
    BohrlochM3)
{
    difference()
    {
        cube([WandDicke*2,WandDicke*2,LuefterTiefe+WandDicke]);
        translate([WandDicke,WandDicke,-1])
            cylinder(r=BohrlochM3,LuefterTiefe+WandDicke+2);
    }
}

module VenturiAdapter(
    WandDicke,
    LuefterLaenge,
    LuefterTiefe,
    AbstandLuefterRohr,
    RohrDN75DInnen,
    BohrlochM3,
    RohrDN75TStueckLange,
    AbstandLuefterRohr,
    DueseDurchmesser,
    DueseLaenge)
{
    difference()
    {
        union()
        {
            UebergangsRohr(WandDicke,LuefterLaenge,AbstandLuefterRohr,RohrDN75DInnen);    
            translate([0,0,-LuefterTiefe+WandDicke])
                LuefterHalterung(WandDicke,LuefterLaenge,LuefterTiefe,BohrlochM3);    
            translate([LuefterLaenge/2+WandDicke,LuefterLaenge/2+WandDicke,AbstandLuefterRohr+WandDicke])
                InnenRohr(WandDicke,RohrDN75DInnen,RohrDN75TStueckLange/2);
            translate([LuefterLaenge/2+WandDicke,LuefterLaenge/2+WandDicke,AbstandLuefterRohr+WandDicke+RohrDN75TStueckLange/2])
                Duese(WandDicke,RohrDN75DInnen,DueseDurchmesser,DueseLaenge);
            translate([-WandDicke,-WandDicke,-LuefterTiefe+WandDicke])
                cube([WandDicke*2,WandDicke*2,LuefterTiefe+WandDicke]);
            translate([+WandDicke+LuefterLaenge,-WandDicke,-LuefterTiefe+WandDicke])
                cube([WandDicke*2,WandDicke*2,LuefterTiefe+WandDicke]);
            translate([+WandDicke+LuefterLaenge,+WandDicke+LuefterLaenge,-LuefterTiefe+WandDicke])
                cube([WandDicke*2,WandDicke*2,LuefterTiefe+WandDicke]);
            translate([-WandDicke,+WandDicke+LuefterLaenge,-LuefterTiefe+WandDicke])
                cube([WandDicke*2,WandDicke*2,LuefterTiefe+WandDicke]);    
        }
        translate([0,0,-LuefterTiefe+WandDicke-1])
            cylinder(r=BohrlochM3,LuefterTiefe+WandDicke+2);
        translate([LuefterLaenge+WandDicke*2,0,-LuefterTiefe+WandDicke-1])
            cylinder(r=BohrlochM3,LuefterTiefe+WandDicke+2);
        translate([WandDicke*2+LuefterLaenge,+WandDicke*2+LuefterLaenge,-LuefterTiefe+WandDicke-1])
            cylinder(r=BohrlochM3,LuefterTiefe+WandDicke+2);
        translate([0,WandDicke*2+LuefterLaenge,-LuefterTiefe+WandDicke-1])
            cylinder(r=BohrlochM3,LuefterTiefe+WandDicke+2);
    }
}

module Deckel(
    WandDicke,
    LuefterLaenge,
    BohrlochM3)
{
    difference()
    {
        union()
        {
            cube([LuefterLaenge+WandDicke*2,LuefterLaenge+WandDicke*2,WandDicke]);
            translate([-WandDicke,-WandDicke,0])
                cube([WandDicke*2,WandDicke*2,WandDicke]);
            translate([+WandDicke+LuefterLaenge,-WandDicke,0])
                cube([WandDicke*2,WandDicke*2,WandDicke]);
            translate([+WandDicke+LuefterLaenge,+WandDicke+LuefterLaenge,0])
                cube([WandDicke*2,WandDicke*2,WandDicke]);
            translate([-WandDicke,+WandDicke+LuefterLaenge,0])
                cube([WandDicke*2,WandDicke*2,WandDicke]);
        }
        translate([LuefterLaenge/2+WandDicke,LuefterLaenge/2+WandDicke,-1])
            cylinder(r=LuefterLaenge/2,WandDicke+2);

        translate([0,0,-1])
            cylinder(r=BohrlochM3,LuefterTiefe+WandDicke+2);
        translate([LuefterLaenge+WandDicke*2,0,-1])
            cylinder(r=BohrlochM3,LuefterTiefe+WandDicke+2);
        translate([WandDicke*2+LuefterLaenge,+WandDicke*2+LuefterLaenge,-1])
            cylinder(r=BohrlochM3,LuefterTiefe+WandDicke+2);
        translate([0,WandDicke*2+LuefterLaenge,-1])
            cylinder(r=BohrlochM3,LuefterTiefe+WandDicke+2);
    }
}

/*
difference()
{
    VenturiAdapter(WandDicke,LuefterLaenge,LuefterTiefe,AbstandLuefterRohr,RohrDN75DInnen,BohrlochM3,RohrDN75TStueckLange,       AbstandLuefterRohr,DueseDurchmesser,DueseLaenge);
    translate([LuefterLaenge/2,-1,-LuefterTiefe-1])        cube([LuefterLaenge+2*WandDicke,LuefterLaenge+2*WandDicke+2,AbstandLuefterRohr+DueseLaenge+RohrDN75TStueckLange],                center = false);
}
*/
if ( printBoden ) {
    translate([0,0,-LuefterTiefe])
        Deckel(WandDicke,LuefterLaenge,BohrlochM3);
} else {
    VenturiAdapter(WandDicke,LuefterLaenge,LuefterTiefe,AbstandLuefterRohr,RohrDN75DInnen,BohrlochM3,RohrDN75TStueckLange,       AbstandLuefterRohr,DueseDurchmesser,DueseLaenge);
}

