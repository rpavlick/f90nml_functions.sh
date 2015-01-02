#!/bin/sh
source f90nml_functions.sh

cat > testnml<<EOF
&testnml
TREAL =  1.,
TINTEGER = 2,
TCOMPLEX = (3.,4.),
TCHAR = 'namelist',
TBOOL = T,
&end
EOF

echo "usage: replace_namelist_value <namelist file> <parameter> <new value>"
echo "example: replace_namelist_value \"testnml\" \"TREAL\" \"2.\""
echo
replace_namelist_value  "testnml" "TREAL" "2."
replace_namelist_value  "testnml" "TINTEGER" "4 3 2 1"
replace_namelist_value  "testnml" "TCOMPLEX" "(4.,3.)"
replace_namelist_value  "testnml" "TCHAR" "\'listname\'"
replace_namelist_value  "testnml" "TBOOL" "F"

echo
echo "usage: get_namelist_value <namelist file> <parameter>"
echo "example: get_namelist_value  \"testnml\" \"TBOOL\""
echo
get_namelist_value "testnml" "TBOOL"
