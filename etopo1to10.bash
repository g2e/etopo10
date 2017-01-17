#!/bin/bash
#ETOPO1TO10.BASH    Create ETOPO10 binaries from ETOPO1 binaries
#
# Because there are no grids between 1arc-min & 1deg resolution.
#
# Requires: GMT, RM

# check for gmt
command -v gmt >/dev/null 2>&1 || { echo "gmt not installed. Aborting!" >&2; exit 1; }

# Explaination of GMT flags
# -I1m  == 1 arc-minute resolution input
# -Rg   == global grid
# -ZTLh == grid of int16 starting at Top Left
# -V    == verbose output
# -Fm20 == median of all values within 10km (~5 arc-minutes)
# -D4   == spherical filtering
# -I10m == 10 arc-minute resolution output

# bedrock map
xyz2grd etopo1_bed_g_i2.bin -Getopo1_bed.grd -I1m -Rg -ZTLh -V
grdfilter etopo1_bed.grd -Getopo10_bed.grd -Fm20 -D4 -I10m -V
grd2xyz etopo10_bed.grd -ZTLh > etopo10_bed_g_i2.bin
rm etopo1_bed.grd etopo10_bed.grd

# ice surface map
xyz2grd etopo1_ice_g_i2.bin -Getopo1_ice.grd -I1m -Rg -ZTLh -V
grdfilter etopo1_ice.grd -Getopo10_ice.grd -Fm20 -D4 -I10m -V
grd2xyz etopo10_ice.grd -ZTLh > etopo10_ice_g_i2.bin
rm etopo1_ice.grd etopo10_ice.grd
rm gmt.history
