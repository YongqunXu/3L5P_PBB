# 3L5P_Liner
The analytic result for Three-Loop-Five-Point Feynman integral: The Liner.  The auxilary files of 2411.xxxx

This is the Liner:

	         |	
	 	 |
	        / \
	       /   \ 
	      /	    \
	  ___/       \___
	     \       /
	      \_____/
	      |     |
	      |     |
	      |_____|
	      |     |
	      |     |
	      |_____|
	     /	     \
	    /         \


## Description for all of these.  
*   Canonical_Basis.m 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&rarr; The Uniform Transcendental basis that leads to canonical differential equation. 
*   Transcendental_Const/ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &rarr; The definition of transcendental constant in the boundary values. Provided up to weight-5.
*   Letter.m		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&rarr; Some basic definition of the alphabet letters and the square root. 
*   MI_all.txt		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&rarr; All 316 master integrals provided by NeatIBP. 
*   Weight-1-Integrals.m &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&rarr; Weight-1-Integrals in terms of penatgon functions.
*   Weight-2-Integrals.m &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&rarr; these function are simply Log and PolyLog in Mathematica, most of them are labeled as F[i,j].
*   Weight-3-Integrals.m &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&rarr; the postion 123 is just a palce holder for the only one parity odd function. see mathcalP_W3.m
*   basis-def.m	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		&rarr; explicit definition for F[i,j] in terms of Log and PolyLog.
*   mathcalP_W3.m &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		&rarr; The only one parity odd function at Weight-3. 
*   BC-W0W1W2W3.m &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		&rarr; The analytic boundary values from Weight-1 to Weight-3.
*   BC-W4W5W6-num180.m &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   &rarr; The numeric boundary values from Weight-4 to Weight-6, with 180 digits.
*   BC-W4W5W6-num280.m &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   &rarr; The numeric boundary values from Weight-4 to Weight-6. with 280 digits.


## Boundary Values: 
*   Weight-0: Only Q numbers.
*   Weight-1: All of them are 0.
*   Weight-2: some Pi^2. 
*   Weight-3: some Pi^3, Zeta[3], and some PolyLog function about GoldenRatio. 
*   Weight-4: some Pi^4, and some PolyLog function about GoldenRatio and 2, and one extra constant Tcr[4,123] in ./Transcendental-Constant/Tc4-logli2.m
*   Weight-5: some Zeta[3]Pi^2, Zeta[5], and some constants: {bcw5[16], bcw5[43], bcw5[102], bcw5[103], bcw5[111], bcw5[113], bcw5[131], bcw5[132], bcw5[136], bcw5[149], bcw5[324], bcw5[325]}.
*   Weight-6: some Zeta[3]^3, Pi^6, and a lot of Tcr[6,i]...(under construction)


