<#import "template.ftl" as layout>
<#import "password-commons.ftl" as passwordCommons>

<@layout.registrationLayout displayMessage=!messagesPerField.existsError('global'); section>
    <#if section = "title">
        ${msg("webauthn-registration-title")}
    </#if>
    
    <#if section = "header">
        <div class="d-flex align-items-center justify-content-center mb-1">
            <i class="${properties.kcWebAuthnKeyIcon!} fs-1 text-primary me-3" aria-hidden="true"></i>
            <h1 class="h4 mb-0">${kcSanitize(msg("webauthn-registration-title"))?no_esc}</h1>
        </div>
    </#if>
    
    <#if section = "form">
        <div class="mb-4">
            <p class="text-muted text-center">${msg("webauthn-registration-init-prompt-text")}</p>
        </div>

        <form id="register" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
            <div class="${properties.kcFormGroupClass!}">
                <input type="hidden" id="clientDataJSON" name="clientDataJSON"/>
                <input type="hidden" id="attestationObject" name="attestationObject"/>
                <input type="hidden" id="publicKeyCredentialId" name="publicKeyCredentialId"/>
                <input type="hidden" id="authenticatorLabel" name="authenticatorLabel"/>
                <input type="hidden" id="transports" name="transports"/>
                <input type="hidden" id="error" name="error"/>
                <@passwordCommons.logoutOtherSessions/>
            </div>

            <div class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcFormButtonsClass!} d-grid gap-2">
                    <input type="button" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} btn btn-primary btn-lg" id="registerWebAuthn" value="${msg("webauthn-doRegister")}"/>
                </div>
                <#if isAppInitiatedAction??>
                    <div class="${properties.kcFormOptionsClass!} mt-3 text-center">
                        <div class="${properties.kcFormOptionsWrapperClass!}">
                            <a href="${url.loginAction}?${auth.attemptedAction}" class="btn btn-outline-secondary">
                                ${msg("doCancel")}
                            </a>
                        </div>
                    </div>
                </#if>
            </div>
        </form>

        <div class="mt-4">
            <div id="authenticator-attachment" class="d-none">
                <div class="alert alert-info d-flex align-items-center" role="alert">
                    <i class="bi bi-info-circle me-2" aria-hidden="true"></i>
                    <div>
                        <strong>${msg("webauthn-registration-init-label")}</strong>
                        <br>
                        <span id="kc-register-authenticator"></span>
                    </div>
                </div>
            </div>
        </div>
    </#if>

    <#if section = "script">
        <script type="module">
            import { registerByWebAuthn } from "${url.resourcesPath}/js/webauthnRegister.js";
            const registerButton = document.getElementById('registerWebAuthn');
            registerButton.addEventListener("click", function() {
                const input = {
                    challenge : '${challenge!""}',
                    userid : '${userid!""}',
                    username : '${username!""}',
                    signatureAlgorithms : [<#if signatureAlgorithms??><#list signatureAlgorithms as sigAlg>${sigAlg?c}<#sep>,</#sep></#list></#if>],
                    rpEntityName : '${rpEntityName!""}',
                    rpId : '${rpId!""}',
                    attestationConveyancePreference : '${attestationConveyancePreference!"none"}',
                    authenticatorAttachment : '${authenticatorAttachment!""}',
                    requireResidentKey : '${requireResidentKey!"false"}',
                    userVerificationRequirement : '${userVerificationRequirement!"preferred"}',
                    createTimeout : ${createTimeout!60000},
                    excludeCredentialIds : '${excludeCredentialIds!""}',
                    initLabel : "${msg('webauthn-registration-init-label')?no_esc}",
                    initLabelPrompt : "${msg('webauthn-registration-init-label-prompt')?no_esc}",
                    errmsg : "${msg('webauthn-unsupported-browser-text')?no_esc}"
                };
                registerByWebAuthn(input);
            });
        </script>
    </#if>
</@layout.registrationLayout>