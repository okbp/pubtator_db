log_enable(2,1);
ld_dir_all ('/database/load_files/', '*.ttl', 'https://pubmed.ncbi.nlm.nih.gov/pubtator');
rdf_loader_run();
checkpoint;