import pandas as pd
import pyreadstat


df, meta = pyreadstat.read_sav("defunciones2022.sav")

df.to_csv("defunciones2022.csv", index=False, encoding="utf-8")

print("Conversion realizada")

nombres_nuevos = {
    "Depreg": "Departamento_registro",
    "Mupreg": "Municipio_registro",
    "Mesreg": "Mes_registro",
    "Añoreg": "Año_registro",
    "Depocu": "Departamento_ocurrencia",
    "Mupocu": "Municipio_ocurrencia",
    "Sexo": "Sexo_difunto",
    "Diaocu": "Dia_ocurrencia",
    "Mesocu": "Mes_ocurrencia",
    "Añoocu": "Año_ocurrencia",
    "Edadif": "Edad_difunto",
    "Perdif": "Periodo_edad_difunto",
    "Puedif": "Pueblo_pertenencia",
    "Ecidif": "Estado_civil",
    "Escodif": "Escolaridad",
    "Ciuodif": "Ocupacion_CIUO08",
    "Pnadif": "Pais_nacimiento",
    "Dnadif": "Departamento_nacimiento",
    "Mnadif": "Municipio_nacimiento",
    "Nacdif": "Nacionalidad",
    "Predif": "Pais_residencia",
    "Dredif": "Departamento_residencia",
    "Mredif": "Municipio_residencia",
    "Caudef": "Causa_defuncion",
    "Asist": "Asistencia_recibida",
    "Ocur": "Sitio_ocurrencia",
    "Cerdef": "Certificador_defuncion"
}

print(len(nombres_nuevos))