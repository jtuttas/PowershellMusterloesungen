[xml] $xml = gc "Nebenkosten.xml"
[float]$sum=0;
foreach($node in $xml.GetElementsByTagName("Haus"))
{
   $max=$node.childnodes.count 
   $item=$node.FirstChild
   for ($i=0;$i -lt $max;$i++) {
        $sum+=[float]$item.InnerText
        $item=$item.NextSibling
   }
   
}
echo ("Die gesamten Nebenkosten betragen: "+$sum+" EUR")
