
%%% lambert compiler for faster function call
example_input = {...
        [0.0, 0.0, 0.0], ...% r1vec
        [0.0, 0.0, 0.0], ...% r2vec
         0.0, ...           % tf
         0.0, ...           % m
         0.0};              % muC
   codegen lambert_pro.m -args example_input