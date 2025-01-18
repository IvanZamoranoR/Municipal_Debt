*-------------------------------------------------------------------------------
* Replication file for Municipal Debt 
* Authors: Rafael Ch Durán, Iván Zamorano
* Date: 
*-------------------------------------------------------------------------------

clear all

*==============================================================================*
*                                                                              *
*                                   Code                                       *
*                                                                              *
*==============================================================================*

* Reelection Data

use  "/Users/ivanzamorano/Dropbox/Debt/Data/ConstructionDatabase/municipalities_id_2004_2022_wtreatment_ivan.dta"


* Merging reelection data base and municipal debt using INEGI ID and year 

merge 1:1 inegi year using "/Users/ivanzamorano/Desktop/Municipal_Debt/Registro_Deuda_Municipal_FM_Panel.dta"

* Considering that unmatchet data is set to missing. We will keep only matched data

keep if _merge==3
drop _merge

gen log_debt = log(monto_original_contratado+1)

*Logarithm of debt
xtset inegi year

ssc install reghdfe

est clear 

eststo: xi: reghdfe log_debt reform, a(inegi year) vce(cluster estado)

esttab est*, keep(reform) se star(* 0.10 ** 0.05 *** 0.01)


*Create groups (0,1,2,3,4)

tostring estado, replace


gen Group = " "


*replace Group = "-1" if (inlist(nombre_estado, "BAJA CALIFORNIA SUR", "CAMPECHE", "CHIAPAS", "COLIMA", "GUANAJUATO") ///
*    | inlist(nombre_estado, "GUERRERO", "JALISCO", "MEXICO", "MICHOACAN", "MORELOS", "NUEVO LEON", "QUERETARO") ///
*    | inlist(nombre_estado, "SAN LUIS POTOSI", "TABASCO", "YUCATAN", "AGUASCALIENTES", "BAJA CALIFORNIA", "CHIHUAHUA", "DURANGO") ///
*    | inlist(nombre_estado, "OAXACA", "QUINTANA ROO", "SINALOA", "TAMAULIPAS", "ZACATECAS", "COAHUILA", "DISTRITO FEDERAL", "CHIHUAHUA", "DURANGO") ///
*    | inlist(nombre_estado, "PUEBLA", "SONORA")) & year == 2014

*replace Group = "-2" if (inlist(nombre_estado, "BAJA CALIFORNIA SUR", "CAMPECHE", "CHIAPAS", "COLIMA", "GUANAJUATO") ///
*    | inlist(nombre_estado, "GUERRERO", "JALISCO", "MEXICO", "MICHOACAN", "MORELOS", "NUEVO LEON", "QUERETARO") ///
*    | inlist(nombre_estado, "SAN LUIS POTOSI", "TABASCO", "YUCATAN", "AGUASCALIENTES", "BAJA CALIFORNIA", "CHIHUAHUA", "DURANGO") ///
*    | inlist(nombre_estado, "OAXACA", "QUINTANA ROO", "SINALOA", "TAMAULIPAS", "ZACATECAS", "COAHUILA", "DISTRITO FEDERAL", "CHIHUAHUA", "DURANGO") ///
*    | inlist(nombre_estado, "PUEBLA", "SONORA", "HIDALGO", "NAYARIT", "TLAXCALA", "VERACRUZ")) & year == 2013

*replace Group = "-3" if (inlist(nombre_estado, "BAJA CALIFORNIA SUR", "CAMPECHE", "CHIAPAS", "COLIMA", "GUANAJUATO") ///
*    | inlist(nombre_estado, "GUERRERO", "JALISCO", "MEXICO", "MICHOACAN", "MORELOS", "NUEVO LEON", "QUERETARO") ///
*    | inlist(nombre_estado, "SAN LUIS POTOSI", "TABASCO", "YUCATAN", "AGUASCALIENTES", "BAJA CALIFORNIA", "CHIHUAHUA", "DURANGO") ///
*    | inlist(nombre_estado, "OAXACA", "QUINTANA ROO", "SINALOA", "TAMAULIPAS", "ZACATECAS", "COAHUILA", "DISTRITO FEDERAL", "CHIHUAHUA", "DURANGO") ///
*    | inlist(nombre_estado, "PUEBLA", "SONORA", "HIDALGO", "NAYARIT", "TLAXCALA", "VERACRUZ")) & year == 2012

*replace Group = "-4" if (inlist(nombre_estado, "BAJA CALIFORNIA SUR", "CAMPECHE", "CHIAPAS", "COLIMA", "GUANAJUATO") ///
*    | inlist(nombre_estado, "GUERRERO", "JALISCO", "MEXICO", "MICHOACAN", "MORELOS", "NUEVO LEON", "QUERETARO") ///
*    | inlist(nombre_estado, "SAN LUIS POTOSI", "TABASCO", "YUCATAN", "AGUASCALIENTES", "BAJA CALIFORNIA", "CHIHUAHUA", "DURANGO") ///
*    | inlist(nombre_estado, "OAXACA", "QUINTANA ROO", "SINALOA", "TAMAULIPAS", "ZACATECAS", "COAHUILA", "DISTRITO FEDERAL", "CHIHUAHUA", "DURANGO") ///
*    | inlist(nombre_estado, "PUEBLA", "SONORA", "HIDALGO", "NAYARIT", "TLAXCALA", "VERACRUZ")) & year == 2011

*replace Group = "-5" if (inlist(nombre_estado, "BAJA CALIFORNIA SUR", "CAMPECHE", "CHIAPAS", "COLIMA", "GUANAJUATO") ///
*    | inlist(nombre_estado, "GUERRERO", "JALISCO", "MEXICO", "MICHOACAN", "MORELOS", "NUEVO LEON", "QUERETARO") ///
*    | inlist(nombre_estado, "SAN LUIS POTOSI", "TABASCO", "YUCATAN", "AGUASCALIENTES", "BAJA CALIFORNIA", "CHIHUAHUA", "DURANGO") ///
*    | inlist(nombre_estado, "OAXACA", "QUINTANA ROO", "SINALOA", "TAMAULIPAS", "ZACATECAS", "COAHUILA", "DISTRITO FEDERAL", "CHIHUAHUA", "DURANGO") ///
*    | inlist(nombre_estado, "PUEBLA", "SONORA", "HIDALGO", "NAYARIT", "TLAXCALA", "VERACRUZ")) & year == 2010

*replace Group = "-6" if (inlist(nombre_estado, "BAJA CALIFORNIA SUR", "CAMPECHE", "CHIAPAS", "COLIMA", "GUANAJUATO") ///
*    | inlist(nombre_estado, "GUERRERO", "JALISCO", "MEXICO", "MICHOACAN", "MORELOS", "NUEVO LEON", "QUERETARO") ///
*    | inlist(nombre_estado, "SAN LUIS POTOSI", "TABASCO", "YUCATAN", "AGUASCALIENTES", "BAJA CALIFORNIA", "CHIHUAHUA", "DURANGO") ///
*    | inlist(nombre_estado, "OAXACA", "QUINTANA ROO", "SINALOA", "TAMAULIPAS", "ZACATECAS", "COAHUILA", "DISTRITO FEDERAL", "CHIHUAHUA", "DURANGO") ///
*    | inlist(nombre_estado, "PUEBLA", "SONORA", "HIDALGO", "NAYARIT", "TLAXCALA", "VERACRUZ")) & year == 2009
  
*replace Group = "1" if (inlist(nombre_estado, "BAJA CALIFORNIA SUR", "CAMPECHE", "CHIAPAS", "COLIMA", "GUANAJUATO") ///
*	| inlist(nombre_estado, "GUERRERO", "JALISCO", "MEXICO", "MICHOACAN", "MORELOS") ///
*	| inlist(nombre_estado, "NUEVO LEON", "QUERETARO", "SAN LUIS POTOSI", "TABASCO", "YUCATAN")) & year >= 2015



*AGUASCALIENTES = 1 
*BAJA CALIFORNIA = 2 
*BAJA CALIFORNIA SUR = 3
*CAMPECHE  =  4 
*COAHUILA  =  5 
*COLIMA   = 6
*CHIAPAS   = 7 
*CHIHUAHUA  = 8
*DURANGO  =   10
*GUANAJUATO   = 11
*GUERRERO   =  12 
*HIDALGO  = 13
*JALISCO   = 14
*MEXICO     =15 
*MICHOACAN  =   16 
*MORELOS      = 17
*NAYARIT     =  18 
*NUEVO LEON    =   19
*OAXACA     = 20
*PUEBLA    =   21 
*QUERETARO   = 22 
*QUINTANA ROO  = 23 
*SAN LUIS POTOSI  = 24
*SINALOA  =  25 
*SONORA  =  26
*TABASCO   =  27 
*TAMAULIPAS  = 28
*TLAXCALA  =  29
*VERACRUZ  = 30
*YUCATAN   = 31
*ZACATECAS   =  32 
 
replace Group = "2014" if (inlist(estado, "3", "4", "6","7", "11") ///
    | inlist(estado, "12", "14", "15", "16", "17", "19", "22") ///
    | inlist(estado, "24", "27", "31")) & year <= 2014

replace Group = "2013" if (inlist(estado, "1", "2", "8", "10") ///
    | inlist(estado, "20", "23", "25", "28", "32")) & year <= 2015
	
replace Group = "2012" if (inlist(estado,  "5")) & year <= 2016
	
replace Group = "2011" if (inlist(estado, "21", "26")) & year <= 2017

replace Group = "2015" if (inlist(estado, "3", "4", "6","7", "11") ///
    | inlist(estado, "12", "14", "15", "16", "17", "19", "22") ///
    | inlist(estado, "24", "27", "31")) & year >= 2015
	
replace Group = "2016"  if (inlist(estado, "1", "2", "8", "10") ///
    | inlist(estado, "20", "23", "25", "28", "32")) & year >= 2016

replace Group = "2017" if (inlist(estado,  "5")) & year >= 2017

replace Group = "2018" if (inlist(estado, "21", "26")) & year >= 2018

replace Group = "0" if inlist(estado, "13", "18", "29", "30") ///
<
destring Group,  ignore(",") generate(Group_int)

xtset inegi year

 

export delimited using "/Users/ivanzamorano/Dropbox/Debt/Data/DS_Cohort_Debt.csv", replace


*  Let's first install drdid
ssc install drdid, all replace
* Now let's install csdid
ssc install csdid, all replace


csdid log_debt reform, ivar(inegi) time(year) gvar(Group_int) method(dripw)
estat event
csdid_plot
 
*Create groups (0,1)

*tostring estado, replace


*gen Group = " "

*replace Group = "1" if inlist(nombre_estado, "BAJA CALIFORNIA SUR", "CAMPECHE", "CHIAPAS", "COLIMA", "GUANAJUATO") ///
*| inlist(nombre_estado, "GUERRERO", "JALISCO", "MEXICO", "MICHOACAN", "MORELOS") ///
*| inlist(nombre_estado, "NUEVO LEON", "QUERETARO", "SAN LUIS POTOSI", "TABASCO", "YUCATAN") ///
*| inlist(nombre_estado, "AGUASCALIENTES", "BAJA CALIFORNIA", "CHIHUAHUA", "DURANGO", "OAXACA") ///
*| inlist(nombre_estado, "COAHUILA", "QUINTANA ROO", "SINALOA", "TAMAULIPAS", "ZACATECAS") ///
*| inlist(nombre_estado, "DISTRITO FEDERAL", "PUEBLA", "SONORA") ///

*replace Group = "0" if inlist(nombre_estado, "HIDALGO", "NAYARIT", "TLAXCALA", "VERACRUZ")


*export delimited using "/Users/ivanzamorano/Dropbox/Debt/Data/DS_Cohort_Debt.csv", replace

