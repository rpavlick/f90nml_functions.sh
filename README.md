f90nml_functions.sh
===================

bash functions for retrieving and replacing Fortran namelist parameter values

example fortran 90 namelist file

```
&testnml
TREAL =  1.,
TINTEGER = 2,
TCOMPLEX = (3.,4.),
TCHAR = 'namelist',
TBOOL = T,
&end
```

replace_namelist_value \<namelist file\> \<parameter\> \<new value\>

```bash
> replace_namelist_value "testnml" "TREAL" "2."
 < TREAL =  1.,
 > TREAL=2.,

> cat testnml 
 &testnml
 TREAL=2.,
 TINTEGER = 2,
 TCOMPLEX = (3.,4.),
 TCHAR = 'namelist',
 TBOOL = T,
 &end
```

get_namelist_value \<namelist file\> \<parameter\>

```bash
> get_namelist_value  "testnml" "TBOOL"
 T
```


