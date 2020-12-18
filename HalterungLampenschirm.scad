// Andre Betz
// github@AndreBetz.de

RohrKN50Aussen          = 50;
RohrKN50Innen           = 45;
RohrKN50Laenge          = 20;
Uebergang50Laenge       = 20;
LampenschirmOeffnung    = 42;
LampenschirmHalterung   = 10;

$fn=100;

WandDicke = (RohrKN50Aussen - RohrKN50Innen)/2;

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

InnenRohr(WandDicke,RohrKN50Aussen+WandDicke*2,RohrKN50Laenge);
translate([0,0,RohrKN50Laenge])
    Duese(WandDicke,RohrKN50Aussen+WandDicke*2,LampenschirmOeffnung,Uebergang50Laenge);
translate([0,0,RohrKN50Laenge+Uebergang50Laenge])
    InnenRohr(WandDicke,LampenschirmOeffnung,LampenschirmHalterung);
translate([LampenschirmOeffnung*1.5,0,0])
//translate([0,0,RohrKN50Laenge+Uebergang50Laenge])
    InnenRohr(WandDicke,LampenschirmOeffnung+WandDicke*2,LampenschirmHalterung/2);

