library(tidyverse)
data(starwars)
?starwars
starwars

#Uso do Pipe %>%

starwars %>%
  select(name)


#Seleção das colunas uma a uma 
starwars %>%
  select(name, height,mass)
#Seleção de sequencia de colunas
starwars %>%
  select(name : hair_color)

#Exclusao de colunas
starwars %>%
  select(-films, -vehicles, -starships)
#Seleciona colunas que começam com determinada letra
starwars %>%
  select(starts_with("h"))
#Seleciona colunas que terminam com determinada letra
starwars %>%
  select(ends_with("color"))

#Contem um determinado texto ou termo
starwars %>%
  select(contains("color"))



#Filtro de linhas
starwars[starwars$homeworld == 'Tatooine',]

#filtrando com tidyverse
starwars %>%
  filter(homeworld == "Tatooine")

#Multiplos filtros(Operador And)
starwars %>%
  filter(homeworld == 'Tatooine', species == 'Droid')
#Multiplos filtros (Operador Or)
starwars %>%
  filter(homeworld == 'Tatooine' | homeworld == 'Naboo')

#Filtrando valores faltantes NA
starwars %>%
  filter(is.na(homeworld))

#Filtro para multiplos valores com uma mesma coluna 
starwars %>%
  filter(species %in% c("Humon", 'Droid'))

#Inverso da condicao in (!)
starwars %>%
  filter(!species %in% c('Humon', 'Droid'))



#Criando colunas de dados com tidyverse

data("starwars")
starwars %>%
  mutate(
    height = height / 100 #converte a altura de metros para centimetros
  )

#Criando uma coluna com Sim ou Nao de acordo com uma codicao de valor para a coluna
starwars %>%
  mutate(
    peso_100 = ifelse(mass > 100, 'S', 'N')
  ) %>%
  select(name, mass, peso_100)

#Substituir valores nos campos da tabela
starwars %>%
  mutate(
    hair_color = ifelse(is.na(hair_color), 'desconhecido', hair_color)
  ) %>%
  select(name,hair_color)

#Parametros especiais keep all, used, unused, none
starwars %>%
  mutate(
    hair_color = ifelse(is.na(hair_color), 'desconhecido', hair_color), .keep = 'used'
  ) #Used mostra apenas as colunas utilizadas
starwars %>%
  mutate(
    hair_color = ifelse(is.na(hair_color), 'desconhecido', hair_color), .keep = 'unused'
  ) #Unused mostra apenas as colunas nao utilizas + a coluna criada
starwars %>%
  mutate(
    hair_color = ifelse(is.na(hair_color), 'desconhecido', hair_color), .keep = 'none'
  ) #None traz apenas a coluna transformada


#Parametros Before ou After (Permite voce poscionar a coluna transformada antes ou depois de uma determinada coluna)
starwars %>%
  mutate(
    peso_100 = ifelse(mass > 100, 'S', 'N'), .before = 'name'
  ) 
starwars %>%
  mutate(
    peso_100 = ifelse(mass > 100, 'S', 'N'), .after = 'name'
  ) 

#Ordenacao de colunas em ordem ascendente
starwars%>%
  arrange(height)
#Ordenacao de colunas em ordem descendente
starwars%>%
  arrange(desc(height))

#ordenando multiplas colunas
starwars %>%
  arrange(hair_color, height) #ordenou de forma ascendente as colunas hair_color e height

#Comando slice_head()
starwars %>%
  arrange(height) %>%
  slice_head(n = 3) #ira pegar os 3 personagens mais baixos
#Comando slice_tail()
starwars %>%
  filter(!is.na(height))%>% #filtra os valores que contem NA para que o arange possa selecionar em ordem ascendente
  arrange(height)%>%
  slice_tail(n = 3)#selesciona os 3 maiores personagens


#Selecionar linhas de forma aleatoria slice_sample()
starwars %>%
  slice_sample(n = 10)


#Agrupamento de Dados
starwars %>%
  summarise(
    personagens = n(), 
    alturaMedia = mean(height, na.rm = T), #na.rm remove as informacoes na
    menor_massa = min(mass, na.rm = T)
  )


# Group_by() + summarise() para agragar por grupos
starwars %>%
  group_by(eye_color)%>%
  summarise(
    personagens = n() #n() soma a quantidade de linhas
    
  )

#Qual a media de altura por espcie
starwars %>%
  group_by(species) %>%
  summarise(
    alturaMedia = mean(height, na.rm = T)
  )
#Quantos personagens ha com cada cor de cabelo
starwars%>%
  group_by(hair_color)%>%
  summarise(
    personagens = n()
  )
#Ha mais persosngen robos ou humanos
starwars %>%
  group_by(species) %>%
  summarise(
    personagens = n()
  ) %>%
  filter(species %in% c("Human", "Droid"))
