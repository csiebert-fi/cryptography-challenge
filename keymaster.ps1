# Prompt user for input
$cipherText = Read-Host "Enter the Base64-encoded ciphertext"
$keyString = Read-Host "Enter the secret key (16 characters)"

if ($keyString.Length -ne 16) {
    Write-Host "Key must be exactly 16 characters for AES-128."
    exit 1
}

# Convert inputs
$key = [System.Text.Encoding]::UTF8.GetBytes($keyString)
$cipherBytes = [Convert]::FromBase64String($cipherText)

# Create AES object
$aes = [System.Security.Cryptography.Aes]::Create()
$aes.Mode = [System.Security.Cryptography.CipherMode]::ECB
$aes.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7
$aes.Key = $key

# Create decryptor and decrypt
$decryptor = $aes.CreateDecryptor()
$plainBytes = $decryptor.TransformFinalBlock($cipherBytes, 0, $cipherBytes.Length)
$plainText = [System.Text.Encoding]::UTF8.GetString($plainBytes)

Write-Host "`nDecrypted plaintext:`n$plainText"
