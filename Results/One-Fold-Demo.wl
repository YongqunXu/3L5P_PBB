(* ::Package:: *)

(*************************User Input Information*****************************************)
destination=Values[{s12->-(79/46),s23->-(129/29),s34->-(89/36),s45->-(87/55),s15->-(51/13)}];
(*destination={-11,-37,-13,-31,-41};*)
(*Nthread=20;*)
NIntegrateOptions={WorkingPrecision->2^5,PrecisionGoal->2^5,AccuracyGoal->2^6,MaxRecursion->20};
(****************************************************************************************)


Print["This is a script to evaluate the UT integrals at: \n \n "]
Print["  ",Thread[{s12,s23,s34,s45,s15}->destination]," \n \n "];
timer=AbsoluteTime[];
If[Not@TrueQ[$FrontEnd==Null],SetDirectory@NotebookDirectory[],SetDirectory@Directory[]];
(*Print["Starting ",Nthread," Kernels..."];
LaunchKernels[Nthread];*)


Print["Loading Definitions..."];
Atilde=Normal[Get["Atilde-2047-new.m"]]/.{Log[W[1]]->Log[-W[1]],Log[W[2]]->Log[-W[2]],
Log[W[3]]->Log[-W[3]],Log[W[4]]->Log[-W[4]],Log[W[5]]->Log[-W[5]],
Log[W[6]]->Log[-W[6]],Log[W[7]]->Log[-W[7]],Log[W[8]]->Log[-W[8]],
Log[W[9]]->Log[-W[9]],Log[W[10]]->Log[-W[10]],Log[W[11]]->Log[W[11]],
Log[W[12]]->Log[-W[12]],Log[W[13]]->Log[-W[13]],Log[W[14]]->Log[W[14]],
Log[W[15]]->Log[W[15]],Log[W[16]]->Log[-W[16]],Log[W[17]]->Log[-W[17]],
Log[W[18]]->Log[-W[18]],Log[W[19]]->Log[-W[19]],Log[W[20]]->Log[-W[20]],
Log[W[26]]->Log[-W[26]],Log[W[27]]->Log[-W[27]],Log[W[28]]->Log[-W[28]],
Log[W[29]]->Log[-W[29]],Log[W[30]]->Log[-W[30]]};


Get["Letter.m"];
RootDef=eps5->Sqrt[s12^2*s15^2-2*s12^2*s15*s23+s12^2*s23^2+2*s12*s15*s23*s34-2*s12*s23^2*s34+s23^2*s34^2-2*s12*s15^2*s45+2*s12*s15*s23*s45+2*s12*s15*s34*s45+2*s12*s23*s34*s45+2*s15*s23*s34*s45-2*s23*s34^2*s45+s15^2*s45^2-2*s15*s34*s45^2+s34^2*s45^2];
var={s12,s23,s34,s45,s15};
LetterRepm=LetterRep/.Thread[var->-Array[m,5]];
RootDefm=RootDef/.Thread[var->-Array[m,5]];


basisdef=Get["BASIS_DEF.m"];SetAttributes[F,NHoldAll];
B=Get["B-Kernel.m"];


(* ::Subsubsection:: *)
(*Begin*)


Print["Preparing Integrand..."];
$Assumptions=0<t<1;
patht=Thread[Array[m,5]->-destination(t)+ConstantArray[1,5](1-t)];
roott=Simplify[RootDefm/.patht];
t0p=(patht/.t->0);
t1p=(patht/.t->1);


BcOfB=N[B/.N[basisdef/.LetterRepm/.roott/.t1p/.t->1,50]/.LetterRepm/.roott/.t1p/.t->1,50];
W3odd=Get["Int41-Final.m"];
W3int=ReplacePart[Get["W3-integrals.m"],132->W3odd];
W3intt=W3int/.basisdef/.LetterRepm/.patht/.roott;


BC0={-1,-1,-1,2,-1,-1,0,3/2,-1,-1,0,3/2,0,0,0,0,1,0,0,0,-1,-1,-1,2,-1,-1,-1,2,1/4,1/4,1/4,-(1/2),-1,-1,0,4/3,-(1/3),-(4/3),0,0,0,0,0,5/6,0,0,0,0,-1,-1,0,4/3,0,-(4/3),0,0,0,5/6,0,-(1/3),0,0,0,0,0,0,0,-(1/3),0,2/3,0,0,0,-(1/3),0,0,0,0,1/6,0,0,0,0,2/3,0,0,0,0,0,1/6,0,2/3,-1,-1,0,4/3,1/9,0,4/9,4/9,4/3,0,2,0,0,1/6,0,5/12,1/6,0,0,0,0,1/6,0,0,0,5/12,1/6,0,0,0,0,1/2,-(1/4),1/2,-(1/4),0,0,0,0,0,-(1/4),-(1/2),2/3,0,0,0,0,-(7/36),0,-(7/36),0,-(1/2),2/3,0,0,1,0,0,0,0,2/3,0,0,0,0,5/6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-(2/3),-(3/4),-(10/9),0,0,0,0,1/6,0,-(1/3),0,-(7/18),0,0,0,0,0,0,0,0,2/3,0,0,0,0,0,5/6,0,1/6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-(7/18),0,0,0,-(1/3),0,0,0,-(2/3),-(3/4),-(10/9),0,0,0,0,0,4/3,4/3,0,0,0,-(4/3),16/9,0,0,-(5/9),0,-(5/9),0,-(4/3),16/9,0,8/3,0,0,0,0,0,0,0,-(1/6),-(1/3),-(1/2),0,-(7/9),0,0,0,0,0,0,0,0,0,0,-(7/9),0,-(1/6),-(1/3),-(1/2),0,0,0,0,0,0,0,0,0,0,0,-(7/12),1/4,-(7/12),1/4,0,0,0,0,0,0,0,0,1/2,7/9,7/12,1/3,0,0,0,0,0,0,-(7/36),0,0,-(7/36),0,0,7/9,7/12,1/3,0,0,0,7/6,0,0,0,0};


BCW456=Get["W4-W5-W6-BC-Numericl-200.m"];
bcw[4,i_]:=BCW456[[1,i]]
bcw[5,i_]:=BCW456[[2,i]]
bcw[6,i_]:=BCW456[[3,i]]


At=Atilde/.LetterRepm/.patht/.roott;
DtA=D[At,t];
At1=Atilde/.(LetterRepm/.patht/.roott/.t->1);


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


w5contrib[mis_]:=DtA[[mis]] . Array[bcw[5,#]&,326]
w4contrib[mis_]:=(At1-At)[[mis]] . DtA . Array[bcw[4,#]&,326]
w3contribpart1[mis_]:=(At-At1)[[mis]] . At . DtA . W3intt
BkernelContrib[mis_]:=Bkernel[[mis]] . DtA . W3intt


W5ut[mis_]:=Module[{sol},
Print["     Weight-5 UT[",mis ,"] ->> ",AbsoluteTiming[
sol=bcw[5,mis]
+NIntegrate[DtA[[mis]] . Array[bcw[4,#]&,326]+(At1-At)[[mis]] . DtA . W3intt,{t,0,1},Evaluate[Sequence@@NIntegrateOptions]]
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


W1=Get["W1-integrals.m"];
W2=Get["W2-integrals.m"];
W3=Get["W3-integrals.m"];


Print["Evaluating The Liner 322.."]
w0123={BC0[[322]],W1[[322]],W2[[322]],W3[[322]]}/.basisdef/.LetterRep/.RootDef/.{s12->-(79/46),s23->-(129/29),s34->-(89/36),s45->-(87/55),s15->-(51/13)};


w4num=W4ut[322];


w5num=W5ut[322];


w6num=W6ut[322];


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
