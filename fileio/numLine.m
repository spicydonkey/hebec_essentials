function nlines = numLine(fname)
fh = fopen(fname, 'rt');
assert(fh ~= -1, 'Could not read: %s', fname);
x = onCleanup(@() fclose(fh));
nlines = 0;
while ~feof(fh)
    nlines = nlines + sum( fread( fh, 16384, 'char' ) == char(10) );
end
end