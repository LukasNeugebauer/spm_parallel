function [] = run_spm_parallel(matlabbatch, n_cores)
%function [] = run_spm_parallel(n_cores)
%
%Start pool if there is none, split matlabbatch and run parallel

    start_pool_conditionally(n_cores);
    loop_procs = splitvect(matlabbatch, n_cores);

    spm_path = fileparts(which('spm'));
    if isempty(spm_path)
	fprintf('Couldn''t find spm path. If it throws an error, you''ll probably have to add that yourself WITHIN the parfor loop.');
    end
    
    parfor worker=1:n_cores
        
        warning('off', 'all');
	addpath(genpath(spm_path));
        warning('on', 'all');
        
        spm_jobman('run', loop_procs{worker});
        
    end
    
end
