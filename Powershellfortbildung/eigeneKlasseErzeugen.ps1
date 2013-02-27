Add-Type -TypeDefinition @'
public class MeinKleinesObjekt
{
    public int MyField = 5;    
    public int xTimesMyField(int x) {
        return x * MyField;
    }
}
'@ -Language CSharp

$objekt = New-Object -TypeName MeinKleinesObjekt

$objekt.MyField = 12

$objekt.xTimesMyField
