function [pool] = start_pool_conditionally(n_workers)
%Check if a parallel pool with the specified number of workers already runs
%if not, start a new one
%return pool either way
    
    pool = gcp('nocreate');
    
    if isempty(pool)
        pool = parpool(n_workers);
    elseif pool.NumWorkers ~= n_workers
        fprintf('Wrong number of workers. Starting again.\n');
        delete(pool);
        pool = parpool(n_workers);
    else
        fprintf('Pool with %d workers already running.\n', n_workers);
    end

end