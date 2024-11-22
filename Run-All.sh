math -script - <<EOF
If[
DirectoryQ["./b-line"],
B = Get["Btilde.m"];
Do[
    Print[
           "Writing B tilde line by line:",
              Export["./b-line/B-" <> ToString[i] <> ".m", B]
          ]
   , {i, 316}
],Print[" B has been written line by line. Ready to evaluate all integrals. "]]
EOF

math -script Evaluate-All-Integrals-mma-para.wl | (tee Evaluate-All-Integrals-mma-para.log)
