if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect
    " Detect log files and various pascal files as the right file type
    au! BufRead,BufNewFile catalina.out,*.out,*.out.*,*.log,*.log.* setf log
    au! BufRead,BufNewFile *.pp,*.pas set filetype=pascal
    augroup END
" Pascal / Delphi
if (1==1) "change to "1==0" to use original syntax
    au! BufNewFile,BufRead *.pas,*.PAS   set ft=delphi
else
    au! BufNewFile,BufRead *.pas,*.PAS set ft=pascal
endif
" Delphi project file
au! BufNewFile,BufRead *.dpr,*.DPR,*.lpr,*.LPR set ft=delphi
" Delphi form file
au! BufNewFile,BufRead *.dfm,*.DFM,*.lfm,*.LFM set ft=delphi
au! BufNewFile,BufRead *.xfm,*.XFM set ft=delphi
" Delphi package file
au! BufNewFile,BufRead *.dpk,*.DPK set ft=delphi
" Delphi .DOF file = INI file for MSDOS
au! BufNewFile,BufRead *.dof,*.DOF set ft=dosini
au! BufNewFile,BufRead *.kof,*.KOF set ft=dosini
au! BufNewFile,BufRead *.dsk,*.DSK set ft=dosini
au! BufNewFile,BufRead *.desk,*.DESK   set ft=dosini
au! BufNewFile,BufRead *.dti,*.DTI set ft=dosini
" Delphi .BPG = Makefile
au! BufNewFile,BufRead *.bpg,*.BPG set ft=make|setlocal makeprg=make\ -f\
