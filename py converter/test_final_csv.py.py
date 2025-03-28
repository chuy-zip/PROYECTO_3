import pandas as pd

def contar_valores_vacios(df):
    """
    Cuenta los valores vacíos/NA/NaN en cada columna de un DataFrame.
    
    Args:
        df (pd.DataFrame): DataFrame a analizar
        
    Returns:
        pd.DataFrame: DataFrame con columnas y conteo de valores vacíos
    """
    # Contar valores vacíos
    vacios = df.isna().sum()
    
    # Crear DataFrame de resultados
    resultado = pd.DataFrame({
        'Columna': vacios.index,
        'Valores_Vacios': vacios.values,
        'Porcentaje_Vacios': (vacios / len(df)) * 100
    })
    
    # Ordenar de mayor a menor
    resultado = resultado.sort_values('Valores_Vacios', ascending=False)
    
    return resultado.reset_index(drop=True)

#defunciones_filtradas_categorizadas.csv
#defunciones_no_na.csv
df = pd.read_csv("defunciones_filtradas_categorizadas.csv")
print(df.shape)

print(contar_valores_vacios(df))