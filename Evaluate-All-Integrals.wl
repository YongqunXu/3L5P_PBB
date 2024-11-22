(* ::Package:: *)

Print["========================================================================================================"];
Print["Analytic Computation of Three-Loop Five-Point Feynman Integrals: Pentaon-box-box"];
Print["Yuanche Liu, Antonela Matija\[SHacek]i\[CAcute],  Julian Miczajka, Yingxuan Xu, Yongqun Xu, Yang Zhang"];
Print["ArXiv: 2411.xxxx"];
Print["yongqunxu@mail.ustc.edu.cn"];
Print["========================================================================================================"];


(*********************************** User Input *****************************************)

destination=Values[{s12->-(79/46),s23->-(129/29),s34->-(89/36),s45->-(87/55),s15->-(51/13)}];
NIntegrateOptions={WorkingPrecision->2^5,PrecisionGoal->2^5,AccuracyGoal->2^6,MaxRecursion->20};
howmanykernels=50;
outputfilename="UT-int-p1-num.m";

(****************************************************************************************)

If[
DirectoryQ["./b-line"],
Print[" B has been written line by line. Ready to evaluate all integrals. "],
	B = Get["Btilde.m"];    Print["Writing B tilde line by line..."];
	Do[Export["./b-line/B-" <> ToString[i] <> ".m", B[[i]]] , {i, 316}]
 ];
Clear[B];

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
letterpath=Simplify[LetterRepm/.patht/.roott,0<t<1];

Print["Evaluate basis functions on the path..."];
basisdefpath=(basisdef/.LetterRepm/.patht/.roott)/.{Log[a_]:>FullSimplify[Log[a],0<t<1],PolyLog[b_,a_]:>Simplify[PolyLog[b,a],0<t<1]};

Print["Loading Weight-3 functions..."];
W3odd=Get["mathcalP_W3.m"];
W3int=ReplacePart[Get["Weight-3-Integrals.m"],123->W3odd];
W3intt=W3int/.basisdefpath/.letterpath;

BC0=Get["./Boundary-Value-Analytic.m"][[1]];
BCW456=Get["./BC-W4W5W6-num180.m"];
bcw[4,i_]:=BCW456[[1,i]]
bcw[5,i_]:=BCW456[[2,i]]
bcw[6,i_]:=BCW456[[3,i]]

Print["Evaluating Atilde on the path.."];
At=Atilde/.letterpath;
DtA=Together[D[At,t]];


w5contrib[mis_]:=DtA[[mis]] . Array[bcw[5,#]&,316]
w4contrib[mis_]:=Module[{Atmis=At[[mis]]},((Atmis/.t->1)-Atmis) . DtA . Array[bcw[4,#]&,316]]
w3contrib[mis_]:=Module[{Atmis=At[[mis]]},(Atmis-(Atmis/.t->1)) . At . DtA . W3intt]

BkernelContrib[mis_]:=Module[{bp=Get["./b-line/B-"<>ToString[mis]<>".m"],bk},
bk=N[bp/.Dispatch[N[basisdefpath/.t->1,50]]/.letterpath/.t->1,50]-bp/.Dispatch[basisdefpath]/.letterpath;
bk . DtA . W3intt]


W4ut[mis_]:=Module[{sol},
Print["     Weight-4 UT[",mis ,"] ->> ",AbsoluteTiming[
sol=bcw[4,mis]+NIntegrate[DtA[[mis]] . W3intt,{t,0,1},Evaluate[Sequence@@NIntegrateOptions]]
][[1]]," s "];sol]


W5ut[mis_]:=Module[{Atmis=At[[mis]],sol},
Print["     Weight-5 UT[",mis ,"] ->> ",AbsoluteTiming[
sol=bcw[5,mis]
+NIntegrate[DtA[[mis]] . Array[bcw[4,#]&,316]+((Atmis/.t->1)-Atmis) . DtA . W3intt,{t,0,1},Evaluate[Sequence@@NIntegrateOptions]]
][[1]]," s "];sol]


W6utfromw5[mis_]:=Module[{sol},
	Print["     Weight-6 UT[",mis ,"] weight-5 contrib-->> ",AbsoluteTiming[
	sol=bcw[6,mis]+NIntegrate[w5contrib[mis],
	{t,0,1},Evaluate[Sequence@@NIntegrateOptions]]
	][[1]]," s "];sol]

W6utfromw4[mis_]:=Module[{sol},
	Print["     Weight-6 UT[",mis ,"] weight-4 contrib -->> ",AbsoluteTiming[
	sol=NIntegrate[
	w4contrib[mis],
	{t,0,1},Evaluate[Sequence@@NIntegrateOptions]]
	][[1]]," s "];sol]

W6utfromw3[mis_]:=Module[{sol},
	Print["     Weight-6 UT[",mis ,"] weight-3 contrib -->> ",AbsoluteTiming[
	sol=NIntegrate[
	w3contrib[mis],
	{t,0,1},Evaluate[Sequence@@NIntegrateOptions]]
	][[1]]," s "];sol]

W6utfromwB[mis_]:=Module[{sol},
	Print["     Weight-6 UT[",mis ,"] B kernel contrib -->> ",AbsoluteTiming[
	sol=NIntegrate[
	BkernelContrib[mis],
	{t,0,1},Evaluate[Sequence@@NIntegrateOptions]]
	][[1]]," s "];sol]


W1=Get["Weight-1-Integrals.m"];
W2=Get["Weight-2-Integrals.m"];
W3=W3int;


Print["Evaluating weight-0 to weight-3 UT integral. "];
w0123=N[{BC0,W1,W2,W3}/.basisdef/.LetterRep/.RootDef/.{s12->-(79/46),s23->-(129/29),s34->-(89/36),s45->-(87/55),s15->-(51/13)},32];

Print["Distributing Definitions...",AbsoluteTiming[DistributeDefinitions[W4ut]]];
Print["Distributing Definitions...",AbsoluteTiming[DistributeDefinitions[W5ut]]];
Print["Distributing Definitions...",AbsoluteTiming[DistributeDefinitions[W6utfromw5]]];
Print["Distributing Definitions...",AbsoluteTiming[DistributeDefinitions[W6utfromw4]]];
Print["Distributing Definitions...",AbsoluteTiming[DistributeDefinitions[W6utfromw3]]];
Print["Distributing Definitions...",AbsoluteTiming[DistributeDefinitions[W6utfromwB]]];

Print["LaunchKernels...",AbsoluteTiming[LaunchKernels[howmanykernels];]];

alltask={
Table[ParallelSubmit[{i},W6utfromwB[i]],{i,316}],
Table[ParallelSubmit[{i},W6utfromw3[i]],{i,316}],
Table[ParallelSubmit[{i},W6utfromw4[i]],{i,316}],
Table[ParallelSubmit[{i},W6utfromw5[i]],{i,316}],
Table[ParallelSubmit[{i},W5ut[i]],{i,316}],
Table[ParallelSubmit[{i},W4ut[i]],{i,316}]
};


Print["Entering Parallel..."];
Print["Finished Parallel NIntegrate: ",AbsoluteTiming[out1=WaitAll[alltask];]];


w4num=out1[[6]];
w5num=out1[[5]];
w6num=Total[out1[[;;4]]];

Export[outputfilename,Join[w0123,{w4num,w5num,w6num}]];

Print["\n Evaluation Finished.. Time Used: ",ToString[Ceiling[AbsoluteTime[]-timer],InputForm]," s. Exit."]
