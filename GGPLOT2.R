library(ggplot2)
library(tidyverse)
  
starwars #Base de dados do starWars

#Especificando o eixo x

starwars %>%
  ggplot(aes(x = height))

#especificando o eixo y
starwars %>%
  ggplot(aes(x = height, y = mass))

#construindo o histograma apenas xom o eixo x

starwars %>%
  ggplot(aes(x=height)) +
  geom_histogram()

#Construindo grafico de densidade
starwars %>%
  ggplot(aes(x = height))+
  geom_density()
#Construindo grafico de densidade em multiplos niveis
starwars %>%
  ggplot(aes(x = height, color = sex))+
  geom_density()
#Adicionar titulos, sub-titulos e mais labs()
starwars %>%
  ggplot(aes(x = height, color = sex))+
  geom_density()+
  labs(
    title = "Distribuicao de alturas por sexo",
    subtitle = 'Conjunto de dados starwars',
    x = 'Altura (em cm)',
    y = "Densidade",
    caption = "Nota de Rodape"
  )
#Criacao do grafico de dispersao simples
starwars%>%
  ggplot(aes(x = height, y = mass))+
  geom_point()

#Usando o filter para remover os outliers
starwars%>%
  filter(mass < 1000) %>%
  ggplot(aes(x = height, y = mass))+
  geom_point()
#Ajustando a linha de tendencia 
starwars%>%
  filter(mass < 1000) %>%
  ggplot(aes(x = height, y = mass))+
  geom_point() +
  geom_smooth(method = 'loess')


#Diferenciando as cores por sexo

starwars %>%
  filter(mass<1000)%>%
  ggplot(aes(x = height, y =mass, color = sex))+
  geom_point()+
  geom_smooth(method = 'loess')


#Criando linhas verticais e horizontais no grafico

starwars %>%
  filter(mass<1000)%>%
  ggplot(aes(x = height, y = mass, color = sex))+
  geom_point()+
  geom_hline(yintercept = 40, linetype = 'dashed')+
  geom_vline(xintercept = 120, linetype = 'dotted', color = "purple")

  
  