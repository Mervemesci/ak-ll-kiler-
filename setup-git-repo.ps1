# setup-git-repo.ps1
# Project in: c:\Users\Mesci\OneDrive\akıllı kiler
# Kullanım:
# 1) Bu dosyayı açıp $GitHubRepoUrl değişkenini kendi reposuna göre güncelle.
#    Örnek: https://github.com/<kullaniciadi>/akilli-kiler.git
# 2) PowerShell'de çalıştır: .\setup-git-repo.ps1

param(
    [string]$GitHubRepoUrl = ''
)

if (-not $GitHubRepoUrl) {
    Write-Host 'Lütfen GitHub repo URL giriniz (ör: https://github.com/kullanici/akilli-kiler.git)';
    return
}

Set-Location -Path "c:\Users\Mesci\OneDrive\akıllı kiler"

if (-not (Test-Path -Path ".git")) {
    git init
    Write-Host 'Git deposu başlatıldı.' -ForegroundColor Green
} else {
    Write-Host '.git zaten var, init atlanıyor.' -ForegroundColor Yellow
}

# README varsa atlama, yoksa oluştur.
if (-not (Test-Path -Path 'README.md')) {
    @"
# Akıllı Kiler / FreshGuard

Son kullanma tarihi hatırlatıcı uygulaması.

## Kullanım
1. index.html aç
2. ürün ekle
3. filtrele

## Özellikler
- Ürün ekleme
- Son kullanma tarihi hesaplama
- LocalStorage
- Emoji etiketleri
"@| Out-File -FilePath README.md -Encoding UTF8
    Write-Host 'README.md oluşturuldu.' -ForegroundColor Green
} else {
    Write-Host 'README.md zaten var.' -ForegroundColor Yellow
}

# .gitignore ekle
if (-not (Test-Path -Path '.gitignore')) {
    @"# Node ve sistem dosyaları
.DS_Store
Thumbs.db
$RECYCLE.BIN/
# IDE dosyaları
.vscode/
# OneDrive cache
*.lnk
"@ | Out-File -FilePath .gitignore -Encoding UTF8
    Write-Host '.gitignore oluşturuldu.' -ForegroundColor Green
} else {
    Write-Host '.gitignore zaten var.' -ForegroundColor Yellow
}

# Commit
git add .
git commit -m 'İlk commit: FreshGuard projesi' ; if ($LASTEXITCODE -ne 0) { Write-Host 'Commit atlanabilir (değişiklik yok veya hata).' -ForegroundColor Yellow }

# Remote setup
$remote = git remote get-url origin 2>$null
if ($LASTEXITCODE -ne 0) {
    git remote add origin $GitHubRepoUrl
    Write-Host "origin remote eklendi: $GitHubRepoUrl" -ForegroundColor Green
} else {
    Write-Host "origin zaten var: $remote" -ForegroundColor Yellow
}

git branch -M main

git push -u origin main

Write-Host 'İşlem tamamlandı. Depoyu GitHub’da kontrol et.' -ForegroundColor Green
