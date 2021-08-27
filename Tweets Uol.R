#analise sobre os ultimos 3000 tweets do Uol capturados em 04 de Outubro de 2020

uol <- read.csv(file.choose())

library(tidyverse)
library(skimr)
library(ggplot2)
skim(uol)
view(uol)
 #Quais ferramentos (source) o Uol noticias esta utilizando e com qual frequencia
uol %>%
  group_by(source)%>%
  summarise(
    numero_tweets = n()
  )
# Verificando a frequencia realitiva (%)
uol %>%
  group_by(source)%>%
  summarise(
    numero_tweets = n()
  )%>%
  mutate(
    numero_tweets_pct = numero_tweets/sum(numero_tweets) *100
  )

#Qual a mediia de likes de todos os tweets (favorite_count)
uol %>%
  summarise(
    media_likes = mean(favorite_count),
    media_retweets = mean(retweet_count)
  )
#Quantos tweets possuem mais de 1000 likes
uol%>%
  filter(favorite_count>1000)%>%
  summarise(
    numero_tweets = n()
  )
#Quais foram os tres tweets com mias rts?
uol %>%
  arrange(desc(retweet_count))%>%#ordena em ordem decrescente
  slice_head(n = 3)%>%
  select(screen_name, text, retweet_count)
#Quais os 3 tweets com mais likes?
uol %>%
  arrange(desc(favorite_count))%>%#ordena em ordem decrescente
  slice_head(n = 3)%>%
  select(screen_name, text, retweet_count)

#Qual a distribuicao do comprimento dos tweets (display_text_width), sendo que o maximo de caracteres permitidos em um tweet ser de 280 caracteres
uol%>%
  mutate(
    intervalo = cut(display_text_width, seq(0,280,20)) #seq cria um vetor comecando em 0 ate 280 de 20 em 20 onde sera nosso intervalo de classe para frenquencia
  )%>%
  group_by(intervalo)%>%
  summarise(
    numero_tweets = n()
  )
  
