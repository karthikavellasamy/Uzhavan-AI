# Uzhavan AI API Verification Test Script

$port = 5000
Write-Host "Testing Uzhavan AI API on port $port..."

# 1. Health check
try {
    $health = Invoke-RestMethod -Uri "http://localhost:$port/api/health" -Method Get
    Write-Host "✅ Health Check:" ($health | ConvertTo-Json -Compress)
} catch {
    Write-Host "❌ Health Check failed:" $_.Exception.Message
}

# 2. Districts list
try {
    $districts = Invoke-RestMethod -Uri "http://localhost:$port/api/weather/districts" -Method Get
    $virudhunagar = $districts.districts | Where-Object { $_.nameEn -eq "Virudhunagar" }
    Write-Host "✅ Weather Districts Count:" $districts.districts.Count
    if ($virudhunagar) {
        Write-Host "✅ Virudhunagar verified in districts list:" $virudhunagar.nameEn "($($virudhunagar.nameTa))"
    } else {
        Write-Host "❌ Virudhunagar missing in districts list!"
    }
} catch {
    Write-Host "❌ Districts failed:" $_.Exception.Message
}

# 3. Verified Market Prices
try {
    $market = Invoke-RestMethod -Uri "http://localhost:$port/api/market/prices" -Method Get
    Write-Host "✅ Market Prices Count:" $market.count "Notice:" $market.dataSourceNotice
} catch {
    Write-Host "❌ Market prices failed:" $_.Exception.Message
}

# 4. Government Schemes
try {
    $schemes = Invoke-RestMethod -Uri "http://localhost:$port/api/schemes" -Method Get
    Write-Host "✅ Government Schemes Count:" $schemes.count
} catch {
    Write-Host "❌ Schemes failed:" $_.Exception.Message
}

# 5. User Registration or Login
$testMobile = "9876543210"
$loginBody = @{
    identifier = $testMobile
    password = "password123"
} | ConvertTo-Json

try {
    $loginRes = Invoke-RestMethod -Uri "http://localhost:$port/api/auth/login" -Method Post -Body $loginBody -ContentType "application/json"
    $token = $loginRes.token
    Write-Host "✅ Farmer Login Successful! User:" $loginRes.user.fullName "Token length:" $token.Length
} catch {
    $regBody = @{
        fullName = "முருகன் / Murugan"
        mobile = $testMobile
        email = "murugan@farm.in"
        password = "password123"
        confirmPassword = "password123"
        preferredLanguage = "ta"
        state = "Tamil Nadu"
        district = "Virudhunagar"
        villageTown = "Aruppukkottai"
    } | ConvertTo-Json
    $reg = Invoke-RestMethod -Uri "http://localhost:$port/api/auth/register" -Method Post -Body $regBody -ContentType "application/json"
    $token = $reg.token
    Write-Host "✅ Farmer Registration Successful! User:" $reg.user.fullName
}

try {

    # 6. Farmer Onboarding
    $onboardBody = @{
        totalLandArea = 3.5
        landAreaUnit = "acres"
        soilType = "Red Soil"
        irrigationType = "Drip Irrigation"
        mainCrops = "Tomato, Paddy"
        farmingExperience = "5 to 10 years"
    } | ConvertTo-Json

    $headers = @{ Authorization = "Bearer $token" }
    $onboard = Invoke-RestMethod -Uri "http://localhost:$port/api/profile/onboarding" -Method Post -Body $onboardBody -ContentType "application/json" -Headers $headers
    Write-Host "✅ Farmer Onboarding Successful!"

    # 7. Add Calendar Activity
    $actBody = @{
        title = "முதல் உரம் இடுதல் (First Top Dressing)"
        cropName = "Tomato"
        activityType = "Fertilizer"
        startDate = "2026-10-30"
        notes = "Apply neem cake and organic compost"
    } | ConvertTo-Json

    $act = Invoke-RestMethod -Uri "http://localhost:$port/api/calendar/activities" -Method Post -Body $actBody -ContentType "application/json" -Headers $headers
    Write-Host "✅ Activity Created in Calendar! Title:" $act.activity.title

    # 8. List Activities
    $actList = Invoke-RestMethod -Uri "http://localhost:$port/api/calendar/activities" -Method Get -Headers $headers
    Write-Host "✅ Total Activities in Calendar:" $actList.activities.Count

    # 9. Add Field Plot
    $fieldBody = @{
        fieldName = "வடகாடு நிலம் (North Plot)"
        area = 2.0
        areaUnit = "acres"
        soilType = "Red Soil"
        irrigationType = "Drip"
        currentCrop = "Tomato"
    } | ConvertTo-Json

    $fRes = Invoke-RestMethod -Uri "http://localhost:$port/api/fields" -Method Post -Body $fieldBody -ContentType "application/json" -Headers $headers
    Write-Host "✅ Field Created! Field Name:" $fRes.field.field_name

    # 10. List Fields
    $fList = Invoke-RestMethod -Uri "http://localhost:$port/api/fields" -Method Get -Headers $headers
    Write-Host "✅ Total Fields Managed:" $fList.fields.Count

} catch {
    Write-Host "❌ Auth / Profile / Activity test note:" $_.Exception.Message
}
