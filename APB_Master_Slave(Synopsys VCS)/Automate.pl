#system("vcs -full64 APB_MS.v APB_MAS.v APB_SLA.v APB_Testbench.v -kdb -debug_access+all -cm line+cond+branch+fsm+tgl");
#system("./simv -cm tgl+fsm+branch+cond+line");
#system("verdi -cov -covdir simv.vdb/");
system("vcs -full64 APB_MS.v APB_MAS.v APB_SLA.v APB_Testbench.v  -kdb -debug_access+all");
#system("dc_shell -f cmd");
system("./simv -verdi");



