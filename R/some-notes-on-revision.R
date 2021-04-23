data_size$is.reduced = as.numeric(data_size$Treatment=="reduced connectivity")
data_size$is.reference = as.numeric(data_size$Treatment=="reference")


mod_size <- brm(bf(scale(tibia) ~ baseline + is.reduced * afterreduced + is.reference * afterreference,
                   baseline ~ 1 + (1 | Mix / IDgroup / IDpop) + (1 | IDindiv),
                   afterreduced ~ Patch,
                   afterreference ~ Patch,
                   nl=TRUE),
                data = data_size,
                chains = 4, iter = 400, warmup = 200,
                prior = c(
                  set_prior("normal(0,1)", class="b",nlpar=c("baseline","afterreduced","afterreference")),
                  set_prior("normal(0,1)", class="sd",nlpar=c("baseline")),
                  set_prior("normal(0,1)", class = "sigma")
                ),
                seed = 42, control = list(adapt_delta = 0.99, max_treedepth = 15),
                backend = "cmdstanr"
)


###
###
### idea of figure to represent the design
### 0---0 for the landscapes ( + un 0 at the top for the mix)
#
## mix 1                 mix 2        mix 3
##
##  0 (stock)           same here     same here
##
## ref     res
## 0-0     0-0
## 0-0     0-0
## 0-0     0-0
## 0-0     0-0
##
##
## and for each experiment, a box where we fill in color what we have data from
## like the figure is a timeline, and on the side, 5 boxes, one per behaviour, with these


raw_dynamics <- read_csv(here("data", "expansion_data", "Trichogramma_dynamics.csv"))

data_front <- raw_dynamics %>%
  mutate(
    Mix = as.numeric(str_sub(Image, 1, 1)),
    Treatment = str_sub(Image, 2, 3),
    Replicate = as.character(str_sub(Image, 4, 4)),
    Patch = as.numeric(str_sub(Image, 6, 7))
  ) %>%
  mutate(Treatment = fct_recode(Treatment, `reference` = "PL", `reduced connectivity` = "PS")) %>%
  group_by(Mix, Treatment, Replicate) %>% 
  summarise(front=max(Patch)) %>% 
  ungroup() 

data_mvt %>% 
  left_join(data_front) %>% 
  mutate(Patch = front * (Location=="edge"))%>%
  ggplot()+
  geom_point(aes(Patch,mean_speed))+
  facet_wrap(~Treatment)

data_fec %>% 
  left_join(data_front) %>% 
  mutate(Patch = front * (Location=="edge"))%>%
  ggplot()+
  geom_point(aes(Patch,Fecundity))+
  geom_smooth(aes(Patch,Fecundity),method="lm")+
  facet_wrap(~Treatment)

data_fec_dens %>% 
  left_join(data_front) %>% 
  mutate(Patch = front * (Location=="edge"))%>%
  ggplot()+
  geom_point(aes(Patch,Fecundity))+
  geom_smooth(aes(Patch,Fecundity),method="lm")+
  facet_wrap(~Treatment+Density)


data_disp %>% 
  left_join(data_front) %>% 
  mutate(Patch = front * (Location=="edge"))%>%
  ggplot()+
  geom_point(aes(Patch,Neggs_arrival /Neggs_all))+
  geom_smooth(aes(Patch,Neggs_arrival /Neggs_all),method="lm")+
  facet_wrap(~Treatment)

data_disp_dens %>% 
  left_join(data_front) %>% 
  mutate(Patch = front * (Location=="edge"))%>%
  ggplot()+
  geom_point(aes(Patch,Neggs_arrival /Neggs_all))+
  geom_smooth(aes(Patch,Neggs_arrival /Neggs_all),method="lm")+
  facet_wrap(~Treatment+Density)
