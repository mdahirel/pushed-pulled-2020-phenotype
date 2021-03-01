# Saved models

If you run the `Rmd` scripts for the first time, models and some other time-consuming outputs will be saved as `RData` files here to be reused as needed, saving you some time later (you can bypass this behaviour to re-run models manually if you want; see code for details). Without models saved from running the `analysis.Rmd` code, re-running/re-knitting the Supplementary Material will *not* work. 

A copy of the `R_output` folder containing all the `RData` we personally generated and used in the manuscript is available as a `zip` file under the "release" section of this repo (GitHub only, starting with release v1: TO DO). Feel free to download it and unzip its content to your own `R_output` folder to save you some computing time. File structure should be as follow for files to be found by the scripts:

```
┗ 📂R_output  
  ┣ 📜model_dispersal1.Rdata 
  ┣ 📜model_dispersal1_alt.Rdata
  ┣ 📜model_dispersal2.Rdata
  ┣ 📜model_dispersal2_alt.Rdata
  ┣ 📜model_fecundity1.Rdata  
  ┣ 📜model_fecundity2.Rdata 
  ┣ 📜model_size.Rdata
  ┣ 📜model_suppl_CV.Rdata 
  ┣ 📜models_mvt.Rdata 
  ┗ 📜README.md  (a.k.a. the file you are reading right now)  
```
See the scripts in the `R` folder for more information about each object.
