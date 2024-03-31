
# Carregar tidyverse -----------------------------------------------------------------------------------------------------------------------

#install.packages("tidyverse")
library(tidyverse)
#install.packages("dados")
library(dados)

# Estabelecer diretório --------------------------------------------------------------------------------------------------------------------

## Para saber qual seu diretório atual
getwd() 

## Para criar um novo diretório de trabalho
dir.create("evento_rladies_natal")  # Cria uma nova pasta na área de trabalho

## Para estabelecer o novo diretório criado
setwd("evento_rladies_natal")

## Estabelecer diretório manualmente:
### Session > Set Working Directory > Choose Directory

# Pacote readr -----------------------------------------------------------------------------------------------------------------------------

dados <- read_excel("caminho/do/seu/arquivo.xls")
dados <- read_excel("caminho/do/seu/arquivo.xlsx") # Excel de 2007 em diante
dados <- read_csv("caminho/do/arquivo.csv")
dados <- read_table("caminho/do/arquivo.txt")
dados <- read_tsv("caminho/do/arquivo.tsv")
dados <- read_delim("caminho/do/arquivo.txt", delim = ";")
dados <- read_delim("caminho/do/arquivo.txt", delim = ",")

dados <- read_csv("taxas_mortes_poluicao.csv", show_col_types = FALSE)

dados <- readxl::read_xlsx("taxas_mortes_poluicao.xlsx")

## Visualizar dados

view(dados)
tibble(dados)
glimpse(dados)

# Pacote tibble ----------------------------------------------------------------------------------------------------------------------------

data <- data.frame(a = 1:3, b = letters[1:3], c = Sys.Date() - 1:3)
data

tibble::tibble(data)
dplyr::glimpse(data)

str(data)

# Criando tibbles

tibble(x = letters)
tibble(x = -5:100, y = 123.456 * (3^x))

# To extract a single column use [[ or $:

class(data[[1]])
class(data$b)

# Pacote forcats ---------------------------------------------------------------------------------------------------------------------------

pinguins <- dados::pinguins

dados::pinguins
glimpse(pinguins)
view(pinguins)

pinguins |>
  select()

pinguins1 <- pinguins |>
  select(especie, massa_corporal, comprimento_bico) |>
  drop_na()

view(pinguins1)

ggplot(pinguins, aes(especie)) +
  geom_bar()

ggplot(pinguins, aes(x = fct_infreq(especie))) +
  geom_bar()

dados::dados_iris
glimpse(dados_iris)

ggplot(dados_iris, aes(x = Especies, y = Largura.Sepala)) +
  geom_col()

ggplot(dados_iris, aes(x = fct_reorder(Especies, Largura.Sepala), 
                     y = Largura.Sepala)) +
  geom_col()

# Pacote dplyr -----------------------------------------------------------------------------------------------------------------------------

## select
## rename
## mutate
## filter
## drop_na
## group_by
## summarise

# select, rename, mutate

ping <- pinguins |>
  select(ilha, especie, massa_corporal) |>
  rename(Especie = especie) |>
  mutate(massa_kg = massa_corporal/1000)

view(ping)

ping <- pinguins |>
  select(ilha, especie, massa_corporal) |>
  rename(c(Especie = especie, Ilha = ilha)) |>
  mutate(massa_kg = massa_corporal/1000) 

view(ping)

# filter

ping <- ping |>
  filter(ilha %in% c("Dream", "Biscoe"))

# group_by, summarise

ping1 <- ping |>
  drop_na() |>
  group_by(Especie) |>
  summarise(media = mean(massa_kg))

view(ping1)


ping1 <- ping |>
  drop_na() |>
  group_by(ilha) |>
  summarise(media = mean(massa_kg),
            n = n(),
            sd = sd(massa_kg),
            se = sd/sqrt(n))
view(ping1)

# Gráfico

ggplot(ping1, aes(x = ilha, y = media)) +
  geom_col(fill = "#562435", width = 0.8) +
  geom_errorbar(aes(ymin = media - sd, ymax = media + sd),
                width = 0.1, size = 0.9) +
  theme_bw()

## Salvar novas tabelas geradas

#write.csv(nova_tabela, "nova_tabela.csv", row.names = FALSE)
#write.xlsx(nova_tabela, "nova_tabela.xlsx", rowNames = FALSE)

# Pacote ggplot2 ---------------------------------------------------------------------------------------------------------------------------

## Gráfico comprimento nadadeira x massa corporal

pinguins <- dados::pinguins

grafico_pinguins <- ggplot(pinguins, aes(x = comprimento_nadadeira,
                     y = massa_corporal,
                     color = especie)) +
  geom_point() + # aes(color = especie)
  geom_smooth(method = "lm") +
  scale_color_manual(values = c("#246572", "#850982", "#121313"),
                     breaks = c("Pinguim-de-adélia", 
                                "Pinguim-de-barbicha",
                                "Pinguim-gentoo"),
                     labels = c("Pinguim de Adélia",
                                "Pinguim de barbicha",
                                "Pinguim Gentoo")) + # expression(paste(italic(
  geom_label(x = 225, y = 3000, label = "p < 0,05",
            color = "black") +
  geom_hline(yintercept = 4500) +
  geom_vline(xintercept = 200) +
  labs(x = "Comprimento da nadadeira (mm)",
       y = "Massa corporal (kg)",
       color = "Espécies") + #labels
  theme_classic() +
  theme(axis.text = element_text(color = "black", size = 12),
        axis.title = element_text(size = 15))

grafico_pinguins

# Salvando os gráficos ---------------------------------------------------------------------------------------------------------------------

ggsave("grafico_pinguins.pdf", dpi = 300,
       unit = "cm", width = 40, height = 30) #pdf 

ggsave()
