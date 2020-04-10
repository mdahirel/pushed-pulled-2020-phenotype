
data$landscapeID=paste(data$Mix,data$Dynamics,data$Replicate)

data$after_evo=1*(data$Generation>0)
data$obsID=c(1:dim(data)[1])

data$group=data$landscapeID
for(i in 1:dim(data)[1]){if(data$Generation[i]==0){data$group[i]<-data$obsID[i]}}

prior_disp2=c(set_prior("normal(0,1.5)",class="b",nlpar=c("alpha","beta","alphaPOST","betaPOST")),  #think about intercept if you do not scalme generation (so the 0 keeps making sense)
             #set_prior("normal(-1,1.5)",class="b",coef="Intercept",nlpar="MAIN"),
              set_prior("exponential(1)",class="sd",nlpar=c("alphaPOST","betaPOST"))
)

bf_disp=bf(Disp_dens|trials(Disp_dens+Philo_dens)~ alpha + after_evo*alphaPOST + (beta+after_evo*betaPOST)*dens.high,
     alpha~Mix2+Mix3,
     beta~Mix2+Mix3,
     alphaPOST~0+is.pushed*is.front*(Mix2+Mix3)+(is.front|q|landscapeID),
     betaPOST~ 0+is.pushed*is.front*(Mix2+Mix3)+(is.front|q|landscapeID),
nl=TRUE)
###limited number of landscape and limited number of replicates per landscape (6 actual landscapes once g0 removed, 4 front and 4 core datapoint each). Asking both mean alpha and beta deviations and 
### front-core specific deviation looks too much
mod=brm(bf_disp,
        data=data,family=binomial,prior=prior_disp2,chains=2)




ggplot(data)+geom_boxplot(aes(x=Density,y=Disp_dens/(Disp_dens+Philo_dens),col=interaction(Dynamics,Location)))+facet_wrap(~landscapeID)

bf_test=bf(Disp_dens|trials(Disp_dens+Philo_dens)~ trt*dens.high+(1|landscapeID)+(1|patchID))


priortest=c(set_prior("normal(0,1.5)",class=c("b")),
            set_prior("exponential(1)",class="sd")
)

bf_test=bf(Disp_dens|trials(Disp_dens+Philo_dens)~ trt*dens.high+(Mix2+Mix3)+(1|group/is.front))
###limited number of landscape and limited number of replicates per landscape (6 actual landscapes once g0 removed, 4 front and 4 core datapoint each). Asking both mean alpha and beta deviations and 
### front-core specific deviation looks too much
mod=brm(bf_test,
        data=data,family=binomial,chains=2,prior=priortest)




prior_disp2=c(set_prior("normal(0,1)",class="b",nlpar=c("MAIN","POST")),  #think about intercept if you do not scalme generation (so the 0 keeps making sense)
              set_prior("exponential(1)",class="sd",nlpar=c("MAIN","POST"))
)
bf_disp=bf(Disp|trials(Disp+Philo)~ MAIN + after_evo*POST,
           MAIN~Generation+Mix2+Mix3+(1|patchID),
           POST~ 0+Generation:is.pushed+Generation:is.front+Generation:is.front:is.pushed+
             (0+is.front:Generation+Generation|landscapeID),
           nl=TRUE)
mod=brm(bf_disp,data=data,family=binomial,chains=2,iter=1000,prior=prior_disp2)


