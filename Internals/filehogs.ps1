$hogs= {
    cd $HOME
    $f=Get-ChildItem -Recurse -File | Sort-Object -Property Length -Descending | Select-Object -First 3 
    $f
}