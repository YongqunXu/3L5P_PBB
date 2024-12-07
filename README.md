# Three-Loop-Five-Point Feynman Integral: Pentagon-box-box
This is the analytic result of a Three-Loop-Five-Point Feynman integral: Pentagon-box-box, the auxilary files of [An Analytic Computation of Three-Loop Five-Point Feynman Integrals[2411.18697]](https://arxiv.org/abs/2411.18697)

This is the Pentagon-box-box:

	         |	
	 	 |
	        / \
	       /   \ 
	      /	    \
	_____/       \_____
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
*   **Canonical_Basis.m** 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&rarr; The Uniform Transcendental basis that leads to canonical differential equation. 
*   **Transcendental_Const/** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &rarr; The definition of transcendental constants in the boundary values. 
*   **Letter.m**  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&rarr; Definition of the 31 pentagon alphabet letters. 
*   **MI_all.txt** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&rarr; All 316 master integrals provided by NeatIBP. 
*   **Weight-1-Integrals.m** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&rarr; Weight-1 integrals in terms of penatgon functions.
*   **Weight-2-Integrals.m** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&rarr; Weight-2 integrals in terms of penatgon functions.
*   **Weight-3-Integrals.m** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&rarr; the postion 123 is just a palce holder for the only one parity odd function. see mathcalP_W3.m
*   **basis-def.m** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		&rarr; Explicit definition for `F[i,j]` in terms of `Log`, `PolyLog[2,_]` and  `PolyLog[3,_]`. 
*   **mathcalP_W3.m** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		&rarr; The only one parity odd function at Weight-3, written in `Log`, `PolyLog[2,_]` and  `PolyLog[3,_]`. 
*   **Boundary-Values-Analytics.m** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		&rarr; The analytic boundary values from weight-1 to weight-6.
*   **BC-W4W5W6-num180.m** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   &rarr; The numeric boundary values from Weight-4 to Weight-6, with 180 digits.
*   **BC-W4W5W6-num280.m** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   &rarr; The numeric boundary values from Weight-4 to Weight-6. with 280 digits.
*   **Evaluate-Single-Integral.wl** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   &rarr; A proof-of-concept demostration to evaluate the UT integrals defined via one-fold integration with auxiliary B-matrix at a generic point.
*   **Atilde.m** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   &rarr; The Canonical differential equation matrix.
*   **ConstT.m** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   &rarr; A Q-constant non-degenerate similarity transformation matrix one should apply to the Atilde-matrix according to `ConstT. Atilde. Inverse[ConstT]`. In other words we provide the analytic function for `ConstT.CanonicalBasis`. It is simply used for the purpose to elimitnate the parity-odd component at weight-3. 
*   **Weight-1234-Symbol.m**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   &rarr; The symbol of the UT integral from weight-1 to weight-4. 
*   **Weight-5-Symbol.tar.xz** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   &rarr; A compress file for the weight-5 symbol. 

## Transcendental Constant In Boundary Values: 
*   **Weight-0**: Only rational numbers.
*   **Weight-1**: All of them are `0`.
*   **Weight-2**: Some `Pi^2`. 
*   **Weight-3**: Some `Pi^3`, `Zeta[3]`, and some `PolyLog` functions about `GoldenRatio`. 
*   **Weight-4**: Some `Pi^4`, and some `PolyLog` function about `GoldenRatio` and `2`, and one extra constant `Tcr[4,123]`.
*   **Weight-5**: Some `Zeta[3]Pi^2`, `Zeta[5]`, and 12 other weight-5 transcendental constnts `bcw5[i]`. 
*   **Weight-6**: Some `Zeta[3]^2`, `Pi^6`, and 63 Weight-6 transcendental constant `Tcr6[i]`. 

These `Tcr[4,123]`, `bcw5[i]` and `Tcr6[i]`, are written in special values of MPL functions.

## More about Boundary Values: 
*   The `GoldenRatio` is a Mathematica Readable command, it is just `1/2 (1 + Sqrt[5])`. 
*   We used the `HPLs6` which stands for the harmonic sum `S(-5,-1;Infinity)`. It can be evaluate through `PolyLogTools.m`. Its numerical value is 0.9874414264032997137...


## Contact
`yonqgunxu@mail.ustc.edu.cn`




