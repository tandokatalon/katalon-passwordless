<#import "template.ftl" as layout>
<#import "user-profile-commons.ftl" as userProfileCommons>
<@layout.registrationLayout displayMessage=messagesPerField.exists('global') displayRequiredFields=true; section>
    <#if section = "title">
        ${msg("registerTitle")}
    </#if>
    <#if section = "header">
        ${msg("registerTitle")}
    </#if>
    <#if section = "form">
        <form id="kc-register-form" action="${url.registrationAction}" method="post">
            <div class="row">
                <@userProfileCommons.userProfileFormFields; callback, attribute>
                    <#if callback = "afterField">
                        <#-- Handle password fields after username or email -->
                        <#if passwordRequired?? && (attribute.name == 'username' || (attribute.name == 'email' && realm.registrationEmailAsUsername))>
                            <div class="col-md-6 mb-3">
                                <label for="password" class="form-label">
                                    ${msg("password")}
                                    <span class="text-danger">*</span>
                                </label>
                                <input type="password" id="password" class="form-control <#if messagesPerField.existsError('password','password-confirm')>is-invalid</#if>" 
                                       name="password" autocomplete="new-password"
                                       aria-invalid="<#if messagesPerField.existsError('password','password-confirm')>true</#if>"
                                />
                                <#if messagesPerField.existsError('password')>
                                    <div class="invalid-feedback d-block">
                                        ${kcSanitize(messagesPerField.get('password'))?no_esc}
                                    </div>
                                </#if>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label for="password-confirm" class="form-label">
                                    ${msg("passwordConfirm")}
                                    <span class="text-danger">*</span>
                                </label>
                                <input type="password" id="password-confirm" class="form-control <#if messagesPerField.existsError('password-confirm')>is-invalid</#if>" 
                                       name="password-confirm" autocomplete="new-password"
                                       aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>"
                                />
                                <#if messagesPerField.existsError('password-confirm')>
                                    <div class="invalid-feedback d-block">
                                        ${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}
                                    </div>
                                </#if>
                            </div>
                        </#if>
                    </#if>
                </@userProfileCommons.userProfileFormFields>

                <#-- Visible reCAPTCHA -->
                <#if recaptchaRequired?? && (recaptchaVisible!false)>
                    <div class="col-12 mb-3">
                        <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}" data-action="${recaptchaAction}"></div>
                    </div>
                </#if>
            </div>

            <#-- Form submission buttons -->
            <div class="d-grid">
                <#if recaptchaRequired?? && !(recaptchaVisible!false)>
                    <#-- Invisible reCAPTCHA with button -->
                    <button class="btn btn-primary btn-lg g-recaptcha" 
                            data-sitekey="${recaptchaSiteKey}" 
                            data-callback="onSubmitRecaptcha" 
                            data-action="${recaptchaAction}" 
                            type="submit">
                        ${msg("doRegister")}
                    </button>
                <#else>
                    <#-- Regular submit button -->
                    <input class="btn btn-primary btn-lg" type="submit" value="${msg("doRegister")}"/>
                </#if>
            </div>

            <#-- Back to login link -->
            <div class="mb-3 mt-4">
                <div id="kc-form-options" class="text-center">
                    <div class="form-options-wrapper">
                        <span><a href="${url.loginUrl}" class="text-decoration-none">${kcSanitize(msg("backToLogin"))?no_esc}</a></span>
                    </div>
                </div>
            </div>

        </form>
    </#if>

    <#if section = "script">
        <#if recaptchaRequired??>
            <script src="https://www.google.com/recaptcha/api.js" async defer></script>
            <#if !(recaptchaVisible!false)>
                <script>
                    function onSubmitRecaptcha(token) {
                        document.getElementById("kc-register-form").requestSubmit();
                    }
                </script>
            </#if>
        </#if>
    </#if>
</@layout.registrationLayout>