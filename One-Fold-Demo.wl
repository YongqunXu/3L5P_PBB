(* ::Package:: *)

Print["========================================================================================================"];
Print["Analytic Computation of Three-Loop Five-Point Feynman Integrals"];
Print["Yuanche Liu, Antonela Matija\[SHacek]i\[CAcute],  Julian Miczajka, Yingxuan Xu, Yongqun Xu, Yang Zhang"];
Print["ArXiv: 2411.xxxx"];
Print["yongqunxu@mail.ustc.edu.cn"];
Print["========================================================================================================"];


(*************************User Input Information*****************************************)
destination=Values[{s12->-(79/46),s23->-(129/29),s34->-(89/36),s45->-(87/55),s15->-(51/13)}];
NIntegrateOptions={WorkingPrecision->2^5,PrecisionGoal->2^5,AccuracyGoal->2^6,MaxRecursion->20};
(****************************************************************************************)


Print["\n This is a proof-of-concept demostration to evaluate the UT integrals via one-fold integration with auxiliary B-matrix at: \n \n "]
Print["  ",Thread[{s12,s23,s34,s45,s15}->destination]," \n \n "];
timer=AbsoluteTime[];
If[Not@TrueQ[$FrontEnd==Null],SetDirectory@NotebookDirectory[],SetDirectory@Directory[]];


Print["Loading Definitions..."];
ConstT=Get["./ConstT.m"];(*A similarity transformation, see our article.*)
Atilde=(ConstT . Get["Atilde.m"] . Inverse[ConstT])/.{Log[W[1]]->Log[-W[1]],Log[W[2]]->Log[-W[2]],
Log[W[3]]->Log[-W[3]],Log[W[4]]->Log[-W[4]],Log[W[5]]->Log[-W[5]],
Log[W[6]]->Log[-W[6]],Log[W[7]]->Log[-W[7]],Log[W[8]]->Log[-W[8]],
Log[W[9]]->Log[-W[9]],Log[W[10]]->Log[-W[10]],Log[W[11]]->Log[W[11]],
Log[W[12]]->Log[-W[12]],Log[W[13]]->Log[-W[13]],Log[W[14]]->Log[W[14]],
Log[W[15]]->Log[W[15]],Log[W[16]]->Log[-W[16]],Log[W[17]]->Log[-W[17]],
Log[W[18]]->Log[-W[18]],Log[W[19]]->Log[-W[19]],Log[W[20]]->Log[-W[20]],
Log[W[26]]->Log[-W[26]],Log[W[27]]->Log[-W[27]],Log[W[28]]->Log[-W[28]],
Log[W[29]]->Log[-W[29]],Log[W[30]]->Log[-W[30]]};
(*Since A tilde is not unique, can be defined up to a constant matrix, we flip some of the sign of the letters inside, 
to avoid unnecessary branch problem*)


basisdef=Get["basis-def.m"];(*The definition of the function F[i,j]*)
B=Get["Btilde.m"];(*This B kernel is defined by dB==dA.A, with A defined as the variable Atilde in the above line.*)


Get["Letter.m"];
RootDef=eps5->Sqrt[s12^2*s15^2-2*s12^2*s15*s23+s12^2*s23^2+2*s12*s15*s23*s34-2*s12*s23^2*s34+s23^2*s34^2-2*s12*s15^2*s45+2*s12*s15*s23*s45+2*s12*s15*s34*s45+2*s12*s23*s34*s45+2*s15*s23*s34*s45-2*s23*s34^2*s45+s15^2*s45^2-2*s15*s34*s45^2+s34^2*s45^2];
var={s12,s23,s34,s45,s15};
LetterRepm=LetterRep/.Thread[var->-Array[m,5]];
RootDefm=RootDef/.Thread[var->-Array[m,5]];


region = And @@ Join[Thread[Values[LetterRep[[;; 5]]] < 0],  Thread[Values[LetterRep[[16 ;; 20]]] < 0]];
(*Currently let's focus on this smaller region inside Euclidean region.*)
If[Not[region/.Thread[var->destination]],
Print["The destination point is out of the current availarble region. Abort"];Quit[]];


(* ::Subsubsection:: *)
(*Begin*)


Print["Preparing Integrand..."];
$Assumptions=0<t<1;
SetAttributes[F,NHoldAll];
patht=Thread[Array[m,5]->-destination(t)+ConstantArray[1,5](1-t)];
roott=Simplify[RootDefm/.patht];
t0p=(patht/.t->0);
t1p=(patht/.t->1);


BcOfB=N[B/.N[basisdef/.LetterRepm/.roott/.t1p/.t->1,50]/.LetterRepm/.roott/.t1p/.t->1,50];
W3odd=Get["mathcalP_W3.m"];
W3int=ReplacePart[Get["Weight-3-Integrals.m"],123->W3odd];
W3intt=W3int/.basisdef/.LetterRepm/.patht/.roott;


BC0=Get["./Boundary-Value-Analytic.m"][[1]];
BCW456=Get["./BC-W4W5W6-num180.m"];
bcw[4,i_]:=BCW456[[1,i]]
bcw[5,i_]:=BCW456[[2,i]]
bcw[6,i_]:=BCW456[[3,i]]


At=Atilde/.LetterRepm/.patht/.roott;
DtA=D[At,t];
At1=Atilde/.(LetterRepm/.patht/.roott/.t->1);


Variables[Atilde]


(* ::Section:: *)
(*W4*)


W4ut[mis_]:=Module[{sol},
Print["     Weight-4 UT[",mis ,"] ->> ",AbsoluteTiming[
sol=bcw[4,mis]+NIntegrate[DtA[[mis]] . W3intt,{t,0,1},Evaluate[Sequence@@NIntegrateOptions]]
][[1]]," s "];
sol
]


(* ::Section:: *)
(*W5 -W6*)


Bkernel=BcOfB-B/.(basisdef/.LetterRepm/.patht/.roott)/.(LetterRepm/.patht/.roott);


w5contrib[mis_]:=DtA[[mis]] . Array[bcw[5,#]&,316]
w4contrib[mis_]:=(At1-At)[[mis]] . DtA . Array[bcw[4,#]&,316]
w3contribpart1[mis_]:=(At-At1)[[mis]] . At . DtA . W3intt
BkernelContrib[mis_]:=Bkernel[[mis]] . DtA . W3intt


W5ut[mis_]:=Module[{sol},
Print["     Weight-5 UT[",mis ,"] ->> ",AbsoluteTiming[
sol=bcw[5,mis]
+NIntegrate[DtA[[mis]] . Array[bcw[4,#]&,316]+(At1-At)[[mis]] . DtA . W3intt,{t,0,1},Evaluate[Sequence@@NIntegrateOptions]]
][[1]]," s "];
sol
]


W6ut[mis_]:=Module[{sol},
Print["     Weight-6 UT[",mis ,"] -->> ",AbsoluteTiming[
sol=bcw[6,mis]
+NIntegrate[
w5contrib[mis]+w4contrib[mis]+w3contribpart1[mis]+BkernelContrib[mis],
{t,0,1},Evaluate[Sequence@@NIntegrateOptions]]
][[1]]," s "];
sol]


W1=Get["Weight-1-Integrals.m"];
W2=Get["Weight-2-Integrals.m"];
W3=W3int;


Print["Evaluating The Numer.312 UT integral. "];
w0123={BC0[[312]],W1[[312]],W2[[312]],W3[[312]]}/.basisdef/.LetterRep/.RootDef/.{s12->-(79/46),s23->-(129/29),s34->-(89/36),s45->-(87/55),s15->-(51/13)};


w4num=W4ut[312];


w5num=W5ut[312];


w6num=W6ut[312];


Print["==================================================================="]
	Print["\t\t Weight-0: ", N[w0123[[1]],32]];
	Print["\t\t Weight-1: ", N[w0123[[2]],32]];
	Print["\t\t Weight-2: ", N[w0123[[3]],32]];
	Print["\t\t Weight-3: ", N[w0123[[4]],32]];
	Print["\t\t Weight-4: ", w4num];
	Print["\t\t Weight-5: ", w5num];
	Print["\t\t Weight-6: ", w6num];
Print["==================================================================="]


Print["\n Evaluation Finished.. Time Used: ",ToString[Ceiling[AbsoluteTime[]-timer],InputForm]," s. Exit."]
