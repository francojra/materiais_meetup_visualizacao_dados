
# Gráficos com ggplot2 ---------------------------------------------------------------------------------------------------------------------

# Carregar dados ---------------------------------------------------------------------------------------------------------------------------

dados::pinguins
glimpse(pinguins)

# Uma variável categórica ------------------------------------------------------------------------------------------------------------------

ggplot(pinguins, aes(x = especie)) +
  geom_bar()

ggplot(pinguins, aes(x = fct_infreq(especie))) +
  geom_bar()

# Uma variável numérica --------------------------------------------------------------------------------------------------------------------

ggplot(pinguins, aes(x = massa_corporal)) +
  geom_histogram(binwidth = 200)

ggplot(pinguins, aes(x = massa_corporal)) +
  geom_histogram(binwidth = 20)

ggplot(pinguins, aes(x = massa_corporal)) +
  geom_histogram(binwidth = 2000)

ggplot(pinguins, aes(x = massa_corporal)) +
  geom_density()

# Uma variável numérica e uma categórica ---------------------------------------------------------------------------------------------------

ggplot(pinguins, aes(x = especie, y = massa_corporal)) +
  geom_boxplot()

## fill = "forestgreen", alpha = 0.5
## outlier.colour, outlier. size, outlier.shape = na

ggplot(pinguins, aes(x = massa_corporal, color = especie)) +
  geom_density(linewidth = 0.75)

ggplot(pinguins, aes(x = massa_corporal, color = especie, fill = especie)) +
  geom_density(alpha = 0.5)

ping_t <- pinguins |>
  drop_na() |> # Não é possível calcular com NAs
  group_by(especie) |>
  summarise(media = mean(massa_corporal))
view(ping_t)

ggplot(data = ping_t, mapping = aes(x = especie, y = media)) +
  geom_col() +
  geom_label(aes(label = round(media, 1)))
  
# Duas variáveis numéricas -------------------------------------------------------------------------------------------------------------

ggplot(data = pinguins)

ggplot(
  data = pinguins,
  mapping = aes(x = comprimento_nadadeira, y = massa_corporal)
)

ggplot(
  data = pinguins,
  mapping = aes(x = comprimento_nadadeira, y = massa_corporal)
) +
  geom_point()

# Duas variáveis categóricas e uma numérica ------------------------------------------------------------------------------------------------

ggplot(
  data = pinguins,
  mapping = aes(x = comprimento_nadadeira, y = massa_corporal, color = especie)
) +
  geom_point()

ggplot(
  data = pinguins,
  mapping = aes(x = comprimento_nadadeira, y = massa_corporal, color = especie)
) +
  geom_point() +
  geom_smooth(method = "lm")

ggplot(
  data = pinguins,
  mapping = aes(x = comprimento_nadadeira, y = massa_corporal)
) +
  geom_point(mapping = aes(color = especie)) +
  geom_smooth(method = "lm")

# Adição de cores e formas -----------------------------------------------------------------------------------------------------------------

ggplot(
  data = pinguins,
  mapping = aes(x = comprimento_nadadeira, y = massa_corporal)
) +
  geom_point(mapping = aes(color = especie, shape = especie)) +
  geom_smooth(method = "lm")

# Adição de títulos e subtítulos -----------------------------------------------------------------------------------------------------------

library(ggthemes)

ggplot(pinguins, aes(x = comprimento_nadadeira, y = massa_corporal)) +
  geom_point(aes(color = especie, shape = especie)) +
  geom_smooth(method = "lm") +
  labs(
    title = "Massa corporal e comprimento da nadadeira",
    subtitle = "Medidas para Pinguim-de-adélia, Pinguim-de-barbicha e Pinguim-gentoo",
    x = "Comprimento da nadadeira (mm)",
    y = "Massa corporal (g)",
    color = "Espécie",
    shape = "Espécie"
  ) +
  scale_color_colorblind()

# Três ou mais variáveis -------------------------------------------------------------------------------------------------------------------

ggplot(pinguins, aes(x = comprimento_nadadeira, y = massa_corporal)) +
  geom_point(aes(color = especie, shape = ilha))

ggplot(pinguins, aes(x = comprimento_nadadeira, y = massa_corporal)) +
  geom_point(aes(color = especie, shape = especie)) +
  facet_wrap(~ilha)

# Gráfico de linhas ------------------------------------------------------------------------------------------------------------------------

df2 <- data.frame(supp = rep(c("VC", "OJ"), each = 3),
                dose = rep(c("D0.5", "D1", "D2"),2),
                len = c(6.8, 15, 33, 4.2, 10, 29.5))

tibble(df2)

df2 %>% 
  ggplot(aes(x = dose, y = len, group = supp, color = supp)) +
  geom_line() +
  scale_color_colorblind()
