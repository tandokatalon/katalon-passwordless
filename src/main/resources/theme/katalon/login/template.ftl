<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false showAnotherWayIfPresent=true>
<!DOCTYPE html>
<html<#if realm.internationalizationEnabled> lang="${locale.currentLanguageTag}"</#if>>
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <title><#nested "title"></title>
    
    <#if properties.favIcon?has_content>
        <link rel="icon" href="${url.resourcesPath}/${properties.favIcon}" />
    </#if>
    
    <link href="${url.resourcesPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${url.resourcesPath}/css/styles.css" rel="stylesheet">
    
    <#-- Import map for WebAuthn dependencies -->
    <script type="importmap">
        {
            "imports": {
                "rfc4648": "${url.resourcesCommonPath}/vendor/rfc4648/rfc4648.js"
            }
        }
    </script>
    
    <#nested "head">
</head>

<body class="bg-light d-flex align-items-center min-vh-100 ${bodyClass}">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">
                <div class="card shadow-sm">
                    <div class="card-body p-4">
                        <#-- Header -->
                        <div class="text-center mb-4">
                            <#if properties.logoUrl?has_content>
                                <div class="logo-container mb-3">
                                    <img src="${url.resourcesPath}/${properties.logoUrl}" alt="Logo" class="logo" style="height: 60px;">
                                </div>
                            </#if>
                            <div class="header-title">
                                <#nested "header">
                            </div>
                        </div>

                        <#-- Messages -->
                        <#if displayMessage && message?has_content>
                            <#assign alertType = "info">
                            <#if message.type == "error">
                                <#assign alertType = "danger">
                            <#elseif message.type == "warning">
                                <#assign alertType = "warning">
                            <#elseif message.type == "success">
                                <#assign alertType = "success">
                            </#if>
                            <div class="alert alert-${alertType} alert-dismissible fade show" role="alert">
                                ${kcSanitize(message.summary)?no_esc}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </#if>

                        <#-- Form -->
                        <#nested "form">
                        
                        <#-- Info -->
                        <#if displayInfo>
                            <#nested "info">
                        </#if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="${url.resourcesPath}/js/bootstrap.bundle.min.js"></script>
    <script src="${url.resourcesPath}/js/script.js"></script>
    <#nested "script">
</body>
</html>
</#macro>