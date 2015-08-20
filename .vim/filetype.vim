if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect
    " Detect log files and various pascal files as the right file type
    au! BufRead,BufNewFile catalina.out,*.out,*.out.*,*.log,*.log.* setf log
    au! BufRead,BufNewFile *.pp,*.pas set filetype=pascal
    augroup END
