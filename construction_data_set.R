library(tidyverse)
library(haven)

data_dir <- "."

#Lista de variables a  conservar
vars_filtrar <- c("Asist", "Añoreg", "Caudef", "Depocu", "Depreg", "Diaocu", 
                  "Dnadif", "Dredif", "Ecidif", "Edadif", "Mesocu", "Mesreg", 
                  "Mredif", "Ocur", "Perdif", "Sexo", "Escodif", "Mnadif")

files_sav <- list.files(path = data_dir, pattern = "\\.sav$", full.names = TRUE)

#Función para leer, etiquetar año y seleccionar solo variables deseadas
read_and_filter <- function(path) {
  df <- read_sav(path)
  year_val <- str_extract(basename(path), "\\d{4}") %>% as.integer()
  
  vars_presentes <- intersect(vars_filtrar, names(df))
  
  df_filtrado <- df %>%
    select(all_of(vars_presentes)) %>%
    mutate(year = year_val)
  
  return(df_filtrado)
}

#Leer filtrar y combinar todo en un solo dataframe
combined_df <- map_dfr(files_sav, read_and_filter)

#Guardar como CSV
write_csv(combined_df, file = file.path(data_dir, "defunciones_filtradas.csv"))

#Confirmación
cat("Archivo CSV creado:", file.path(data_dir, "defun_data.csv"), "\n")
