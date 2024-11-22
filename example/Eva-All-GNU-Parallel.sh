(time parallel --jobs 50 --ungroup ./Evaluate-Single-Integral.wl ::: {1..316}) |& (tee log-parallel.log)
