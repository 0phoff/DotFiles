if exists("g:RelativeFileCompletion_autoload")
    finish
endif
let g:RelativeFileCompletion_autoload = 1


function! s:findStart()
  let line = getline('.')
  let start = col('.') - 1

  " Decrease start pointer until we reach whitespace or (){}[]<>'"
  while start > 0 && line[start - 1] =~ '\S' && line[start - 1] !~ '[(){}\[\]<>"' . "'" . ']'
    let start -= 1
  endwhile

  return start
endfunction


function! s:addSlashToDirectories(val)
    if isdirectory(a:val) && a:val !~ '/$'
      return a:val . '/'
    else
      return a:val
    endif
endfunction


function! RelativeFileCompletion#complete(base)
  " Get correct path
  let cwd = expand('%:h')
  if a:base =~ "^[/~]"
    let path = a:base
    let path_mode = 0
  elseif a:base =~ "^\./"
    let path = cwd . a:base[1:]
    let path_mode = 1
  else
    let path = cwd . '/' . a:base
    let path_mode = 2
  endif

  let filter = 0
  if path !~ "/$"
    let filter = 1
    let fixedpath = split(path, '/')
    let removedpart = path[-1]
    let fixedpath = join(fixedpath[:len(fixedpath)-2], '/')

    if path[0] == '/'
      let fixedpath = '/' . fixedpath
    endif

    let path = fixedpath
  endif

  " Get find command
  if executable('fd')
    let cmd = "fd --hidden --follow --color never -d 1 . " . path
  else
    let cmd = "find -L -d 1 " . path
  endif

  " Execute find command
  let files = systemlist(cmd)
  if empty(files)
    return []
  endif
  let files = map(files, {key, val -> s:addSlashToDirectories(val)})

  " Modify output to start with `a:base`
  if path_mode == 1
    let files = map(files, {key, val -> '.' . val[len(cwd):]})
  elseif path_mode == 2
    let files = map(files, {key, val -> val[len(cwd)+1:]})
  endif

  " Filter output with last part of `a:base`
  if filter == 1
    let files = filter(files, {idx, val -> val =~ '^' . a:base})
    let files = map(files, {key, val -> a:base . val[len(a:base) + len(removedpart):]})
  endif

  return files
endfunction


function! RelativeFileCompletion#completefunc(findstart, base) abort
  return a:findstart ? s:findStart() : RelativeFileCompletion#complete(a:base)
endfunction
