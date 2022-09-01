set batdir=%~dp0
set home=%batdir%home
echo source directory : %home%
mklink %home%\_gvimrc %home%\.vimrc
echo create directory C:%HOMEPATH%\home
mkdir C:%HOMEPATH%\home
cd C:%HOMEPATH%\home
for %%f in (.bashrc .vimrc _gvimrc .gitconfig .git_commit_msg) do (
    mklink %%f %home%\%%f
)
for %%d in (.emacs.d) do (
    mklink /D %%d %home%\%%d
)
:: Set home environment variable
setx home C:%HOMEPATH%\home
 