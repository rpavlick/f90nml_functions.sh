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

  echo "Modifying namelist file $NMLFILE"
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

###############################################################################
function define_colors {
###############################################################################
### define color variables for colorized bash output
### example usage: echo -e "${txtred}Red ${txtgrn}Green ${txtrst}"
###############################################################################

  txtblk='\033[0;30m' # Black - Regular
  txtred='\033[0;31m' # Red
  txtgrn='\033[0;32m' # Green
  txtylw='\033[0;33m' # Yellow
  txtblu='\033[0;34m' # Blue
  txtpur='\033[0;35m' # Purple
  txtcyn='\033[0;36m' # Cyan
  txtwht='\033[0;37m' # White
  bldblk='\033[1;30m' # Black - Bold
  bldred='\033[1;31m' # Red
  bldgrn='\033[1;32m' # Green
  bldylw='\033[1;33m' # Yellow
  bldblu='\033[1;34m' # Blue
  bldpur='\033[1;35m' # Purple
  bldcyn='\033[1;36m' # Cyan
  bldwht='\033[1;37m' # White
  unkblk='\033[4;30m' # Black - Underline
  undred='\033[4;31m' # Red
  undgrn='\033[4;32m' # Green
  undylw='\033[4;33m' # Yellow
  undblu='\033[4;34m' # Blue
  undpur='\033[4;35m' # Purple
  undcyn='\033[4;36m' # Cyan
  undwht='\033[4;37m' # White
  bakblk='\033[40m'   # Black - Background
  bakred='\033[41m'   # Red
  bakgrn='\033[42m'   # Green
  bakylw='\033[43m'   # Yellow
  bakblu='\033[44m'   # Blue
  bakpur='\033[45m'   # Purple
  bakcyn='\033[46m'   # Cyan
  bakwht='\033[47m'   # White
  txtrst='\033[0m'    # Text Reset

return;
}
###############################################################################
