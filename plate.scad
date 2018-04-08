
include <config.scad>;

/*
 * Calculate derivative measurements
 */

back_holes_x = [
                    -back_holes_distance_x/2,
                    +back_holes_distance_x/2
                    ];
back_holes_y = back_holes_distance_y;

middle_holes_x = [
                    -middle_holes_distance_x/2,
                    +middle_holes_distance_x/2
                    ];
middle_holes_y = [
           back_holes_y + middle_to_back_holes_distance_y,
           back_holes_y + middle_to_back_holes_distance_y + middle_holes_distance_y
           ];

front_hole_x = 0;
front_hole_y = middle_holes_y[1] + front_to_middle_holes_distance_y;

module plate()
{
    difference()
    {
        // Base plate
        translate([
            -size_x/2,
            0,
            0
            ])
        cube([
            size_x,
            size_y,
            material_z
            ]);

        // Back holes
        for (x = back_holes_x)
        {
            translate([
                x,
                back_holes_y,
                -nothing
                ])
            cylinder(
                r=hole_radius,
                h=material_z + 2*nothing
                );
        }

        // Middle holes
        for (x = middle_holes_x)
        {
            for (y = middle_holes_y)
            {
                translate([
                    x,
                    y,
                    -nothing
                    ])
                cylinder(
                    r=hole_radius,
                    h=material_z + 2*nothing
                    );
            }
        }

        // Front hole
        translate([
            front_hole_x,
            front_hole_y,
            -nothing
            ])
        cylinder(
            r=hole_radius,
            h=material_z + 2*nothing
            );
    }
}

plate();
