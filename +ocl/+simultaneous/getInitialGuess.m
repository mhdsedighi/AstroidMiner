function ig_stage = getInitialGuess(stage)
% creates an initial guess from the information that we have about
% bounds in the stage

[nv_stage,N] = ocl.simultaneous.nvars(stage.H_norm, stage.nx, stage.integrator.num_i, stage.nu, stage.np);

[X_indizes, I_indizes, U_indizes, P_indizes, H_indizes] = ocl.simultaneous.getStageIndizes(stage);

ig_stage = 0 * ones(nv_stage,1);

igx0 = ocl.simultaneous.igFromBounds(stage.stateBounds0);
igxF = ocl.simultaneous.igFromBounds(stage.stateBoundsF);

ig_stage(X_indizes(:,1)) = igx0;
ig_stage(X_indizes(:,end)) = igxF;

algVarsGuess = ocl.simultaneous.igFromBounds(stage.integrator.algvarBounds);
for m=1:N
  xGuessInterp = igx0 + (m-1)/N.*(igxF-igx0);
  % integrator variables
  ig_stage(I_indizes(:,m)) = stage.integrator.getInitialGuess(xGuessInterp, algVarsGuess);
  
  % states
  ig_stage(X_indizes(:,m)) = xGuessInterp;
end

% controls
for m=1:size(U_indizes,2)
  ig_stage(U_indizes(:,m)) = ocl.simultaneous.igFromBounds(stage.controlBounds);
end

% parameters
for m=1:size(P_indizes,2)
  ig_stage(P_indizes(:,m)) = ocl.simultaneous.igFromBounds(stage.parameterBounds);
end

% timesteps
if isempty(stage.T)
  ig_stage(H_indizes) = stage.H_norm;
else
  ig_stage(H_indizes) = stage.H_norm * stage.T;
end