// Constants
block_width = 20; // Width of the block in millimeters
block_length = 40; // Length of the block in millimeters
block_height = 10; // Height of the block in millimeters
block_bump_size = 4; // Size of the bumps on top of the block in millimeters
block_hole_size = 4; // Diameter of the holes in the bottom of the block in millimeters

// Block shape
module block(shape="basic") {
  if (shape == "basic") {
    cube([block_length, block_width, block_height]);
  } else if (shape == "slant") {
    difference() {
      cube([block_length, block_width, block_height]);
      translate([0, 0, block_height]) {
        cube([block_length - block_bump_size * 2, block_width - block_bump_size * 2, block_bump_size]);
        translate([block_bump_size, block_bump_size, 0]) {
          cube([block_length - block_bump_size * 2, block_width - block_bump_size * 2, block_bump_size]);
        }
      }
    }
    translate([block_length/2 - block_hole_size/2, block_width/2 - block_hole_size/2, 0]) {
      cylinder(r=block_hole_size/2, h=block_height);
    }
    translate([-(block_length/2 - block_hole_size/2), -(block_width/2 - block_hole_size/2), 0]) {
      cylinder(r=block_hole_size/2, h=block_height);
    }
  } else if (shape == "hole") {
    cube([block_length, block_width, block_height]);
    translate([block_length/2 - block_hole_size/2, block_width/2 - block_hole_size/2, 0]) {
      cylinder(r=block_hole_size/2, h=block_height);
    }
    translate([-(block_length/2 - block_hole_size/2), -(block_width/2 - block_hole_size/2), 0]) {
      cylinder(r=block_hole_size/2, h=block_height);
    }
  } else if (shape == "bump") {
    cube([block_length, block_width, block_height + block_bump_size]);
    translate([0, 0, block_height]) {
      cube([block_length - block_bump_size * 2, block_width - block_bump_size * 2, block_bump_size]);
      translate([block_bump_size, block_bump_size, 0]) {
        cube([block_length - block_bump_size * 2, block_width - block_bump_size * 2, block_bump_size]);
      }
    }
  }
}

// Example blocks
translate([-60, 0, 0]) {
  block("basic");
}
translate([-20, 0, 0]) {
  block("slant");
}
translate([20, 0, 0]) {
  block("hole");
}
translate([60, 0, 0]) {
  block("bump");
}
