function get-product {
    $prod = Get-WmiObject win32_product
    foreach ($p in $prod) {

        $product = 'product' | Select-Object -Property Name, Date
        $product.Name = $p.Name
        $product.Date = $p.InstallDate
        $product

    }
}

get-product | Sort-Object -Property Name | Out-GridView