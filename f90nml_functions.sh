###############################################################################
function get_namelist_value {
###############################################################################
### returns parameter value from Fortran namelist file
### usage: get_namelist_value <namelist file> <parameter>
###############################################################################

  NMLFILE=$1
  NMLPARAM=$2

  if [ ! -f $NMLFILE ]; then
    echo
    echo "ERROR in function get_namelist_value: Namelist file $NMLFILE not found!"
    exit
  fi

  msg1=$(grep "$NMLPARAM" $NMLFILE )

  if [ ! x"$msg1" == "x"  ]; then
    awk -v nmlparam=$NMLPARAM \
    'BEGIN{FS=" *= *|,";OFS="="} { if ($1==nmlparam) \
    { print $2 } }' $NMLFILE
  else
    echo
    echo "ERROR in function get_namelist_value:"
    echo "Parameter $NMLPARAM not found in namelist file ${NMLFILE}!"
    exit;
  fi

  return;
}
###############################################################################


###############################################################################
function replace_namelist_value {
###############################################################################
### replaces parameter value in Fortran namelist file with new value
### usage: replace_namelist_value <namelist file> <parameter> <value>
###############################################################################

  NMLFILE=$1
  NMLPARAM=$2
  NMLVALUE=$3

if [ ! -f $NMLFILE ]; then
  echo
  echo "ERROR in function replace_namelist_value: Namelist file $NMLFILE not found!"
  exit
fi

msg1=$(grep "$NMLPARAM" $NMLFILE )

if [ ! x"$msg1" == "x"  ]; then
  NMLTMP=$(mktemp nml.XXXXXX)

  awk -F' *= *' -v nmlparam="$NMLPARAM" -v nmlvalue="$NMLVALUE" \
  'BEGIN{OFS="="} { if ($1==nmlparam) \
  { $2='nmlvalue'"," } print }' $NMLFILE > $NMLTMP

  msg2=$(grep "$NMLPARAM" $NMLTMP )

  txtwht='\033[0;37m'  # White
  bakred='\033[41m'    # Red
  bakgrn='\033[42m'    # Green
  txtrst='\033[0m'     # Text Reset
 
  echo "${txtwht}${bakred}< ${msg1}${txtrst}"
  echo "${txtwht}${bakgrn}> ${msg2}${txtrst}"

  mv $NMLTMP $NMLFILE
else
  echo
  echo "ERROR in function replace_namelist_value:"
  echo "Parameter $NMLPARAM not found in namelist file ${NMLFILE}!"
  exit;
fi

return;
}
###############################################################################



