# Connectivity and evolution during experimental range expansions

 This repo contains all data and code needed to re-do the analyses and figures in our manuscript

"Landscape connectivity alters the evolution of density-dependent dispersal during pushed range expansions" (by Maxime Dahirel, Aline Bertin, Vincent Calcagno, Camille Duraj, Simon Fellous, Géraldine Groussier, Eric Lombaert, Ludovic Mailleret, Anaël Marchand, Elodie Vercken)

(link to bioRxiv preprint to be added here)

- raw experimental data in `csv` format are in the `data` folder
- the R scripts (including detailed information about the analyses) are in the `R` folder. There are two Rmd files, one showing the main analysis, one used to produce the Supplementary Material file. It can be run just as the other script, or knitted to produce the Supplementary Material html file. It is in its own subfolder along with bibliography files used when knitting.
- The `R_output` folder is here to house saved `Rdata` objects (like models), to not have to re-run them everytime, and to be able to use them in the Supplementary Material (see README there for details)

This folder is a RStudio project folder, and the script uses the `here` package (see https://github.com/jennybc/here_here for more). This means all file paths are relative, and the analysis should work on your computer no questions asked, whether you use the R project or not, no code line to change as long as you download the entire repository (you just need to install all the needed packages first, of course).
