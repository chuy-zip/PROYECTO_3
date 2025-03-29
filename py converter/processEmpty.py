import pandas as pd
def reemplazar_valores_vacios(df):

    # Crear copia para no modificar el original
    df_clean = df.copy()
    
    # Reemplazar NA en Mnadif con '9999' (como string)
    df_clean['Mnadif'] = df_clean['Mnadif'].fillna('9999')
    
    # Reemplazar NA en Escodif con '9' (como string)
    df_clean['Escodif'] = df_clean['Escodif'].fillna(9).astype(int)
    
    return df_clean

print("Cargando datos...")
df = pd.read_csv("defunciones_filtradas.csv")
print(f"Dimensiones originales: {df.shape}")

df_clean = reemplazar_valores_vacios(df)

# Guardar resultado
output_file = "defunciones_no_na.csv"
df_clean.to_csv(output_file, index=False)
print(f"\nDatos guardados en: {output_file}")