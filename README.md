f90nml_functions.sh
===================

Bash functions for retrieving and replacing Fortran namelist parameter values

```
&testnml
TREAL =  1.,
TINTEGER = 2,
TCOMPLEX = (3.,4.),
TCHAR = 'namelist',
TBOOL = T,
&end
```

usage: replace_namelist_value <namelist file> <parameter> <new value>

```bash
> replace_namelist_value "testnml" "TREAL" "2."
 < TREAL =  1.,
 > TREAL=2.,
```

usage: get_namelist_value <namelist file> <parameter>

```bash
> get_namelist_value  "testnml" "TBOOL"
 T
```


