(* ::Package:: *)

Print["======================================================================"]
Print["Analytic Computation of Three-Loop Five-Point Feynman Integrals"]
Print["Yuanche Liu, Antonela Matija\[SHacek]i\[CAcute],  Julian Miczajka, Yingxuan Xu, Yongqun Xu, Yang Zhang"]
Print["ArXiv: 2411.xxxx"]
Print["yongqunxu@mail.ustc.edu.cn"]
Print["====================================================================="]


Print["In this Script we would like tou show you how to load our UT integrals."]


If[Not@TrueQ[$FrontEnd==Null],SetDirectory@NotebookDirectory[],SetDirectory@Directory[]];
mis=Get["MI_all.txt"];
SectorIndex[int_]:=Table[If[int[[i]]>0,1,0],{i,Length[int]}]
SectorID[int_]:=FromDigits[Reverse[SectorIndex[int]],2](*Definition of the SectorID*)
allsectorid=Union[SectorID/@mis];
Do[ut[id]=Get["./UT/"<>ToString[id]<>".m"],{id,allsectorid}]


UT=Flatten[ut/@allsectorid];
