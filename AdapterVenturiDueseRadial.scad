// Andre Betz
// github@AndreBetz.de

RohrDN75DInnen          = 70;
RohrDN75DAussen         = 75;
DueseDurchmesser        = 35;
EndeLaenge              = 15;
RohrDN75TStueckLange    = 160;
RohrDN50TStueckAussen   = 50;
RadialLang              = 57;
RadialBreit             = 32;
RadialTiefe             = 10;
SupportBreite           = 5;

$fn=100;

// Title: Wedge Triangle Module
// Author: Carlo Wood
// Date: 19/8/2016
// License: Creative Commons - Share Alike - Attribution

// Usage: Include in your other .scad projects and call wedge with arguments for the height
//        of the wedge, two of the legs of the wedge, and the angle between those legs.
//        The resulting wedge will be placed with the point at the origin, `leg1' along the x-axis
//        and extending `height' into the z axis, with the angle starting at the x axis and
//        extending counter-clockwise as per the right-hand rule towards `leg2`.


//           Y-axis
//           |
//           |  /\
//      leg2 --/  \
//           |/    \
//           /)_____\_______X-axis
//     angle--'  \__ leg1
//
module wedge(angle, leg1, leg2, height = 0.5)
{
  // Store the length of all three sides in an array.
  side = [sqrt(leg1 * leg1 + leg2 * leg2 - 2 * leg1 * leg2 * cos(angle)),	// Law of Cosines.
          leg1,
          leg2];

  i = (leg2 > leg1) ? 2 : 1;
  longest_leg = side[i];
  longest_side = (side[0] > longest_leg) ? side[0] : longest_leg;

  // The corner opposite of the shortest leg must be less than 90 degrees.
  sa = asin(side[3 - i] * sin(angle) / side[0]);		// Law of Sines.
  sb = 180 - angle - sa;					// Sum of all angles is 180 degrees.

  // Store the size of all three angles in an array.
  a = [angle, (i == 1) ? sb : sa, (i == 1) ? sa : sb];

  // Is there anything to draw at all?
  if (angle > 0 && angle < 180)
  {
    intersection()
    {
      if (angle <= 90)
	intersection()
	{
	  cube([longest_leg, longest_leg, height]);
	  rotate([0, 0, angle - 90])
	    cube([longest_leg, longest_leg, height]);
	}
      else
	union()
	{
	  cube([longest_leg, longest_leg, height]);
	  rotate([0, 0, angle - 90])
	    cube([longest_leg, longest_leg, height]);
	}
      if (a[2] < 90)
      {
	translate([leg1, 0, 0])
	  rotate([0, 0, 90 - a[2]])
	    translate([-longest_side, 0, 0])
	      cube([longest_side, longest_side, height]);
      }
      else
      {
        rotate([0, 0, angle])
	  translate([leg2, 0, 0])
	    rotate([0, 0, a[1]])
	      translate([-longest_side, 0, 0])
	        cube([longest_side, longest_side, height]);
      }
    }
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
        translate([RohrDN75DAussen/2,0,RohrDN75TStueckLange/2])
            rotate([0,90,0])
                InnenRohr(WandDicke,RohrDN50TStueckAussen+WandDicke*2,EndeLaenge);
            
        translate([RohrDN75DAussen/2,SupportBreite/2,RohrDN75TStueckLange/2-RohrDN50TStueckAussen/2])
            rotate([90,90,0])
                wedge(90, EndeLaenge+WandDicke, EndeLaenge+WandDicke, SupportBreite);
    }

    //translate([-50,-0,0]) cube([200,100,200],center = false);
}

