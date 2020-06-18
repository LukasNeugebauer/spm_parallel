# spm_parallel
Functions to parallelize running a matlabbatch using the Parallel Computing Toolbox

The core function is run_spm_parallel. It expects a matlabbatch, like you would give it to spm_jobman('run', matlabbatch). For reasons unbeknownst to me, the Parallel Computing Toolbox seems to have a problem with the matlabpath. If you run into problems like "undefined function spm_jobman [...]", try adding the path to spm explicitly in the parfor-loop. If you find a way around that, feel free to start a pull request.
