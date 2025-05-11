
knitr::opts_chunk$set(echo = TRUE)
library(dplyr)
library(caret)
library(ggplot2)
library(gridExtra)
library(class)
library(purrr)

# Cargar datos balanceados
data_balanceada <- read.csv("../defunciones_balanceadas.csv")


# Partición estratificada
set.seed(123)
train_index <- createDataPartition(data_balanceada$causa_macro, p = 0.7, list = FALSE)

train_set <- data_balanceada[train_index, ]
test_set  <- data_balanceada[-train_index, ]

prop.table(table(train_set$causa_macro))
prop.table(table(test_set$causa_macro))

#train_set

# Eliminar variables específicas
vars_to_remove <- c("Añoreg", "Depreg", "Mesreg", "Mredif", "Mnadif", "Perdif", "letra_inicial","Caudef")

train_set_clean <- train_set %>% 
  select(-all_of(vars_to_remove))

test_set_clean <- test_set %>% 
  select(-all_of(vars_to_remove))

# Verificación
names(train_set_clean)

#train_set_clean


edad_anomalas <- sum(train_set_clean$Edadif == 999, na.rm = TRUE)
total_registros <- nrow(train_set_clean)

cat("Registros con Edadif en train = 999:", edad_anomalas, 
    "\nPorcentaje del total:", round(edad_anomalas / total_registros * 100, 2), "%")

edad_anomalas <- sum(test_set_clean$Edadif == 999, na.rm = TRUE)
total_registros <- nrow(test_set_clean)

cat("Registros con Edadif en test = 999:", edad_anomalas, 
    "\nPorcentaje del total:", round(edad_anomalas / total_registros * 100, 2), "%")

train_set_clean <- train_set_clean %>% 
  filter(Edadif != 999)

test_set_clean <- test_set %>% 
  filter(Edadif != 999) %>% 
  select(-all_of(vars_to_remove))


colSums(is.na(train_set_clean))
colSums(is.na(test_set_clean))

# Imputar NA en Escodif con 9 ("Ignorado")
train_set_clean <- train_set_clean %>% 
  mutate(Escodif = ifelse(is.na(Escodif), 9, Escodif))

test_set_clean <- test_set_clean %>% 
  mutate(Escodif = ifelse(is.na(Escodif), 9, Escodif))

# ver que no queden NA
colSums(is.na(train_set_clean))
colSums(is.na(test_set_clean))

