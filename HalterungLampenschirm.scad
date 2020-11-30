// Andre Betz
// github@AndreBetz.de

WandDicke               = 5;
KN50Innen               = 51;
KN50Laenge              = 42;
Uebergang50Laenge       = 20;
LampenschirmOeffnung    = 65;
LampenschirmHalterung   = 75;

$fn=100;

module Zylinder (
    RadiusInnen1,
    RadiusInnen2,
    WandDicke,
    Hoehe
)
{
    difference()
    {
       cylinder(r1=RadiusInnen1/2,r2=RadiusInnen2/2,Hoehe);
       translate([0,0,-1]) 
        cylinder(r1=RadiusInnen1/2-WandDicke,r2=RadiusInnen2/2-WandDicke,Hoehe+2); 
    }
}

Zylinder(KN50Innen,KN50Innen,WandDicke,KN50Laenge);
translate([0,0,-Uebergang50Laenge])
  Zylinder(LampenschirmOeffnung,KN50Innen,WandDicke,Uebergang50Laenge);
translate([0,0,-Uebergang50Laenge-10])
  Zylinder(LampenschirmOeffnung,LampenschirmOeffnung,WandDicke,10);
translate([0,0,-Uebergang50Laenge-10-10])
  Zylinder(LampenschirmHalterung,LampenschirmHalterung,LampenschirmHalterung-LampenschirmOeffnung,10);
