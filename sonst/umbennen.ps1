cls
$pfad = 'm:\2013'
Get-ChildItem $pfad -Recurse | 
  ForEach-Object {
    $n=$_.Name.TrimEnd(".jpg")
    #$n
    if( $n.Contains(" ") -or $n.Contains(".")) {
      
      $newName = $n.Replace(" ","_")
      $newName = $newName.Replace(".","_")
      $newName = $newName +".jpg"
      $newName 
      Rename-Item $_.FullName $newName
    }
  }