// Andre Betz
// github@AndreBetz.de

RohrKN50Aussen          = 50;
RohrKN50Innen           = 45;
RohrKN50Laenge          = 50;
HalterungsRingD         = 15;
HalterungsRingH         =  5;

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

InnenRohr(WandDicke,RohrKN50Aussen,RohrKN50Laenge+HalterungsRingH);
InnenRohr(HalterungsRingD,RohrKN50Aussen+HalterungsRingD*2,HalterungsRingH);

