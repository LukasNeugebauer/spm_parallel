function [] = run_spm_parallel(matlabbatch, n_cores)
%function [] = run_spm_parallel(n_cores)
%
%Start pool if there is none, split matlabbatch and run parallel

    if ~exist('n_cores', 'var')
        n_cores = determine_number_of_procs;
    end
    
    start_pool_conditionally(n_cores);
    loop_procs = splitvect(matlabbatch, n_cores);
    
    parfor worker=1:n_cores
        
        warning('off', 'all');
        add_spm_path;
        warning('on', 'all');
        
        spm_jobman('run', loop_procs{worker});
        
    end
    
end