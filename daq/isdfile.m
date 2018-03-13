function tf = isdfile(fname)
% determine if file is a dld data file
%
% TODO
%   BUG: currently prone to errors mainly since we rely on 'dfile2id.m' which
%   parses filename only with dodgy assumptions
%

tf = ~isnan(dfile2id(fname,0));
    
end