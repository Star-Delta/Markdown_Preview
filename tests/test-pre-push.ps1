#requires -Version 7.0
$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $false

$sourceRoot = Split-Path -Parent $PSScriptRoot
$sourceHook = Join-Path $sourceRoot 'hooks/pre-push'
$sourceHtml = [IO.File]::ReadAllText((Join-Path $sourceRoot 'Markdown_Preview.html'))
$testName = 'markdown-preview-pre-push-' + [guid]::NewGuid().ToString('N')
$testRoot = Join-Path ([IO.Path]::GetTempPath()) $testName
$work = Join-Path $testRoot 'working repo'
$remote = Join-Path $testRoot 'remote repo.git'
$savedGlobalConfig = $env:GIT_CONFIG_GLOBAL
$savedNoSystem = $env:GIT_CONFIG_NOSYSTEM
$passed = 0

function Invoke-TestGit {
    param([string]$Directory, [string[]]$GitArguments)
    $output = & git -C $Directory @GitArguments 2>&1
    [pscustomobject]@{ Code = $LASTEXITCODE; Output = ($output -join "`n") }
}

function Invoke-Git {
    param([string]$Directory, [string[]]$GitArguments)
    $result = Invoke-TestGit $Directory $GitArguments
    if ($result.Code -ne 0) {
        throw "git $($GitArguments -join ' ') failed:`n$($result.Output)"
    }
    $result.Output
}

function New-Preview {
    param([string]$Version)
    [regex]::Replace($sourceHtml, 'Markdown_Preview\(v[0-9]+\.[0-9]+\.[0-9]+\)', "Markdown_Preview($Version)")
}

function Save-Preview {
    param([string]$Html)
    [IO.File]::WriteAllText((Join-Path $work 'Markdown_Preview.html'), $Html, [Text.UTF8Encoding]::new($false))
}

function Commit-Preview {
    param([string]$Html)
    Save-Preview $Html
    Invoke-Git $work @('add', 'Markdown_Preview.html') | Out-Null
    Invoke-Git $work @('commit', '-m', 'test fixture') | Out-Null
}

function Assert-Push {
    param([string]$Name, [bool]$Success, [string[]]$Refs, [string]$Message = '')
    $before = Invoke-Git $remote @('for-each-ref', '--format=%(refname):%(objectname)')
    $result = Invoke-TestGit $work (@('push', 'origin') + $Refs)
    if (($result.Code -eq 0) -ne $Success) {
        throw "$Name : unexpected exit code $($result.Code)`n$($result.Output)"
    }
    if ($Message -and -not $result.Output.Contains($Message)) {
        throw "$Name : expected message missing: $Message`n$($result.Output)"
    }
    if (-not $Success) {
        $after = Invoke-Git $remote @('for-each-ref', '--format=%(refname):%(objectname)')
        if ($before -cne $after) { throw "$Name : rejected push changed remote refs" }
    }
    $script:passed++
    Write-Host "PASS: $Name"
}

try {
    New-Item -ItemType Directory -Path $testRoot | Out-Null
    # 個人のGit設定やフックをテスト用リポジトリへ持ち込まない。
    $env:GIT_CONFIG_GLOBAL = Join-Path $testRoot 'empty.gitconfig'
    $env:GIT_CONFIG_NOSYSTEM = '1'
    [IO.File]::WriteAllText($env:GIT_CONFIG_GLOBAL, '')
    Invoke-Git $testRoot @('-c', 'init.templateDir=', 'init', '--bare', $remote) | Out-Null
    Invoke-Git $testRoot @('-c', 'init.templateDir=', 'init', '-b', 'main', $work) | Out-Null
    Invoke-Git $work @('config', 'user.name', 'Hook Test') | Out-Null
    Invoke-Git $work @('config', 'user.email', 'hook-test@example.invalid') | Out-Null
    Invoke-Git $work @('config', 'core.autocrlf', 'false') | Out-Null
    Invoke-Git $work @('config', 'core.hooksPath', '.git/hooks') | Out-Null
    Invoke-Git $work @('config', 'commit.gpgSign', 'false') | Out-Null
    Invoke-Git $work @('config', 'tag.gpgSign', 'false') | Out-Null
    Invoke-Git $work @('remote', 'add', 'origin', $remote) | Out-Null
    New-Item -ItemType Directory -Path (Join-Path $work '.git/hooks') -Force | Out-Null
    Copy-Item -LiteralPath $sourceHook -Destination (Join-Path $work '.git/hooks/pre-push')

    Commit-Preview (New-Preview 'v1.2.2')
    Assert-Push 'branch push' $true @('main')
    Invoke-Git $work @('tag', 'v1.2.2') | Out-Null
    Assert-Push 'matching lightweight tag' $true @('v1.2.2')

    Invoke-Git $work @('tag', '-a', 'v1.2.3', '-m', 'annotated tag') | Out-Null
    Assert-Push 'mismatching annotated tag' $false @('v1.2.3') 'バージョンが一致しません'
    Save-Preview (New-Preview 'v1.2.3')
    Assert-Push 'uncommitted correction does not fix tag' $false @('v1.2.3') 'HTML内の表記: v1.2.2'
    Commit-Preview (New-Preview 'v1.2.3')
    Assert-Push 'committed correction does not move tag' $false @('v1.2.3') 'HTML内の表記: v1.2.2'
    Invoke-Git $work @('tag', '-f', '-a', 'v1.2.3', '-m', 'corrected tag') | Out-Null
    Assert-Push 'matching annotated tag' $true @('v1.2.3')

    Commit-Preview (New-Preview 'v1.2.4')
    Invoke-Git $work @('tag', 'v1.2.4') | Out-Null
    Invoke-Git $work @('tag', 'v1.2.5') | Out-Null
    Assert-Push 'bad tag stops branch and all tags in same push' $false @('main', 'v1.2.4', 'v1.2.5') 'タグ: v1.2.5'
    Assert-Push 'correct branch and tag batch' $true @('main', 'v1.2.4')
    Invoke-Git $work @('tag', 'checkpoint') | Out-Null
    Assert-Push 'non-version tag' $true @('checkpoint')
    Assert-Push 'destination tag name is checked' $false @('refs/tags/checkpoint:refs/tags/v1.2.6') 'タグ: v1.2.6'
    Invoke-Git $work @('tag', 'v1.2.4-beta.1') | Out-Null
    Assert-Push 'unsupported version tag format' $false @('v1.2.4-beta.1') 'タグの形式が不正'

    Commit-Preview (New-Preview 'v1.2.6')
    Invoke-Git $work @('tag', 'source-v6') | Out-Null
    Invoke-Git $work @('rm', 'Markdown_Preview.html') | Out-Null
    Invoke-Git $work @('commit', '-m', 'missing HTML') | Out-Null
    Invoke-Git $work @('tag', 'v2.0.0') | Out-Null
    Assert-Push 'missing HTML' $false @('v2.0.0') 'HTMLを読み取れません'

    Commit-Preview ((New-Preview 'v2.0.1').Replace('id="info-modal"', 'id="other-modal"'))
    Invoke-Git $work @('tag', 'v2.0.1') | Out-Null
    Assert-Push 'version outside info modal is not accepted' $false @('v2.0.1') '一意に取得できません'

    Commit-Preview ((New-Preview 'v2.0.2').Replace('Markdown_Preview(v2.0.2)', 'Markdown_Preview'))
    Invoke-Git $work @('tag', 'v2.0.2') | Out-Null
    Assert-Push 'missing version' $false @('v2.0.2') '一意に取得できません'

    $duplicateLink = '<a href="#">Markdown_Preview(v2.0.3)</a>'
    Commit-Preview ((New-Preview 'v2.0.3').Replace('<span id="info-close">', "$duplicateLink<span id=`"info-close`">"))
    Invoke-Git $work @('tag', 'v2.0.3') | Out-Null
    Assert-Push 'duplicate version links' $false @('v2.0.3') '一意に取得できません'

    $extraModal = '<div id="info-modal"><a href="#">Markdown_Preview(v2.0.4)</a></div>'
    Commit-Preview ((New-Preview 'v2.0.4').Replace('</body>', "$extraModal</body>"))
    Invoke-Git $work @('tag', 'v2.0.4') | Out-Null
    Assert-Push 'duplicate info modals' $false @('v2.0.4') '一意に取得できません'

    $outsideLink = '<a href="#">Markdown_Preview(v2.0.5)</a>'
    Commit-Preview ((New-Preview 'v2.0.4').Replace('</body>', "$outsideLink</body>"))
    Invoke-Git $work @('tag', 'v2.0.5') | Out-Null
    Assert-Push 'matching text outside modal cannot hide mismatch' $false @('v2.0.5') 'HTML内の表記: v2.0.4'

    # あえてチェックを省略して作ったタグも、削除時には照合しない。
    Invoke-Git $work @('push', '--no-verify', 'origin', 'v2.0.3') | Out-Null
    Assert-Push 'tag deletion' $true @(':refs/tags/v2.0.3')
    Assert-Push 'ordinary branch push with invalid info' $true @('main')

    Invoke-Git $work @('checkout', '--orphan', 'Pages') | Out-Null
    Invoke-Git $work @('rm', '-f', 'Markdown_Preview.html') | Out-Null
    [IO.File]::WriteAllText((Join-Path $work 'index.html'), '<p>Pages fixture</p>')
    Invoke-Git $work @('add', 'index.html') | Out-Null
    Invoke-Git $work @('commit', '-m', 'Pages branch') | Out-Null
    Assert-Push 'standalone hook rejects mismatch on Pages branch' $false @('refs/tags/checkpoint:refs/tags/v9.0.0') 'HTML内の表記: v1.2.4'
    Assert-Push 'matching destination tag on Pages branch' $true @('refs/tags/source-v6:refs/tags/v1.2.6')
    Assert-Push 'Pages branch push without source HTML' $true @('Pages')

    Write-Host "$passed integration checks passed."
}
finally {
    $env:GIT_CONFIG_GLOBAL = $savedGlobalConfig
    $env:GIT_CONFIG_NOSYSTEM = $savedNoSystem
    if (Test-Path -LiteralPath $testRoot) {
        # 削除対象が今回作成した一時ディレクトリに限られることを確認する。
        $resolvedRoot = [IO.Path]::GetFullPath($testRoot)
        $tempPrefix = [IO.Path]::GetFullPath([IO.Path]::GetTempPath()).TrimEnd('\', '/') + [IO.Path]::DirectorySeparatorChar
        if (-not $resolvedRoot.StartsWith($tempPrefix, [StringComparison]::OrdinalIgnoreCase) -or
            [IO.Path]::GetFileName($resolvedRoot) -ne $testName) {
            throw "Unsafe cleanup path: $resolvedRoot"
        }
        Remove-Item -LiteralPath $resolvedRoot -Recurse -Force
    }
}
