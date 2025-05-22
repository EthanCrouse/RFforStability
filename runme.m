%% Param
run(['set_param.m']);


%% Learn feedback from original model.
fprintf(1, 'Learn feedback from original model.\n');
fprintf(1, '-----------------------------------\n');

rng(1.0);
run(['learnfeedback_dt.m']);

%% Test Simulation
fprintf(1, 'Test Feedback Control.\n');
fprintf(1, '-----------------------------------\n');

rng(1.0);
run(['testsimulation_dt.m']);

fprintf(1, '\n');

%% Finished script.
fprintf(1, 'FINISHED SCRIPT.\n');
fprintf(1, '================\n');
fprintf(1, '\n');
