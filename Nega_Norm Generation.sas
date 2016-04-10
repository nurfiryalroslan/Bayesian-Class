libname negbin 'G:\Disertation\SAS dataset\Nega-Norm';
libname pearson2 'G:\Disertation\SAS dataset\Nega-Norm\Pearson_Chi';
data nega.lkeq;
seed=42850190;
 rate0=6;
 rate1=6;
 alpha0=log(rate0);
 alpha1=log(rate1);
 phi=0.5;
 alpha=1/phi;
 beta=phi;
 /* set number of blocks  */
 N_Block=8;
 /* set variance for random effects */
 blk_var=1;

 /* generate data for 1000 experiments  */
do expt=1 to 1000;
 do Block=1 to N_Block;
  B_j=sqrt(blk_var)*rannor(seed);  
  do treatment=1 to 2;
   eta=(treatment=1)*alpha0+(treatment=2)*alpha1+B_j; 
   lamda_ij=exp(eta);                               
   unit_ij=beta*rangam(seed,Alpha);
    count_ij=ranpoi(seed,lamda_ij*unit_ij);                
   output;
 end;
end;  
end;
run;

proc sort data=nega.lkeq;
by expt treatment block;
run;
