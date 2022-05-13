function [] = run_spm_parallel(matlabbatch, n_cores)
%function [] = run_spm_parallel(matlabbatch, n_cores)
%
%Start pool if there is none, split matlabbatch and run parallel

    if length(matlabbatch) == 1
        fprintf("Matlabbatch is of length 1, will just run it normally.\n");
        spm_jobman("run", matlabbatch);
    elseif n_cores < length(matlabbatch)
        fprintf("Length of batch is less than n_cores (%d < %d).\n...
                 Reducing number of cores accordingly!\n",...
                 length(matlabbatch), n_cores...
        );
        n_cores = length(matlabbatch)
    end

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
