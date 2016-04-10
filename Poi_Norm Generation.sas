libname poiunit 'G:\Disertation\SAS dataset\Poisson-Norm';
libname pearson 'G:\Disertation\SAS dataset\Poisson-Norm\Pearson_Chi';
data poiunit.lkeq;
 seed=20110608;
 rate0=6;
 rate1=6;
 alpha0=log(rate0);
 alpha1=log(rate1);
 /* set number of blockss  */
 N_Block=8;
 /* set variance for random effects */
 Block_variance=1;
 unit_Variance=0.5;

 /* generate data for 1000 experiments  */
do expt=1 to 500;
 do Block=1 to N_Block;
  B_j=sqrt(Block_variance)*rannor(seed);  /* B_j is random block effect                          */
  do treatment=1 to 2;
  u_ij=sqrt(unit_Variance)*rannor(seed);   
  eta=(treatment=1)*alpha0+(treatment=2)*alpha1+B_j+u_ij; 
  lamda_ij=exp(eta);                                
   count_ij=ranpoi(seed,lamda_ij);           
   output;
 end;
end;  
end;
drop seed alpha0 alpha1 N_Block ;
run;
proc sort data=poiunit.lkeq;
by expt treatment block;
run;
