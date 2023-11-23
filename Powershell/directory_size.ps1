dir D:\iphone_temp -Directory | 
foreach -begin { $h=@{} ; $results=@() } -process { 
$stat = dir $_.FullName -file -Recurse | Measure-Object -Property length -sum
$h.Path = $_.fullname
$h.Files = $stat.count
$h.TotalSize = $stat.sum/1MB
$results+=[pscustomobject]$h
} -end { 
$results 
}
