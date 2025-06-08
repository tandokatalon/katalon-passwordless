<#macro group name label error="" required=false>

<div class="mb-3">
    <div class="form-label-wrapper">
        <label for="${name}" class="form-label">
        <span class="form-label-text">
            ${label}
        </span>
            <#if required>
                <span class="text-danger" aria-hidden="true">&#42;</span>
            </#if>
        </label>
    </div>

    <#nested>

    <div id="input-error-container-${name}">
        <#if error?has_content>
            <div class="form-text text-danger" aria-live="polite">
                <div class="input-helper-text">
                    <div class="input-helper-text-item" id="input-error-${name}">
                        <span class="input-error-message">
                            ${error}
                        </span>
                    </div>
                </div>
            </div>
        </#if>
    </div>
</div>

</#macro>

<#macro errorIcon error="">
  <#if error?has_content>
    <span class="form-control-util">
        <span class="input-error-icon-status">
          <i class="bi bi-exclamation-circle text-danger" aria-hidden="true"></i>
        </span>
    </span>
  </#if>
</#macro>

<#macro input name label value="" required=false autocomplete="off" fieldName=name error=kcSanitize(messagesPerField.get(fieldName))?no_esc autofocus=false>
  <@group name=name label=label error=error required=required>
    <span class="input-wrapper <#if error?has_content>is-invalid</#if>">
        <input id="${name}" name="${name}" value="${value}" type="text" autocomplete="${autocomplete}" 
               class="form-control <#if error?has_content>is-invalid</#if>" <#if autofocus>autofocus</#if>
                aria-invalid="<#if error?has_content>true</#if>"/>
        <@errorIcon error=error/>
    </span>
    <#if error?has_content>
        <div class="invalid-feedback">
            ${error}
        </div>
    </#if>
  </@group>
</#macro>

<#macro password name label value="" required=false forgotPassword=false fieldName=name error=kcSanitize(messagesPerField.get(fieldName))?no_esc autocomplete="off" autofocus=false>
  <@group name=name label=label error=error required=required>
    <div class="input-group">
      <div class="input-group-item flex-fill">
        <span class="input-wrapper <#if error?has_content>is-invalid</#if>">
          <input id="${name}" name="${name}" value="${value}" type="password" autocomplete="${autocomplete}" 
                 class="form-control <#if error?has_content>is-invalid</#if>" <#if autofocus>autofocus</#if>
                  aria-invalid="<#if error?has_content>true</#if>"/>
          <@errorIcon error=error/>
        </span>
      </div>
      <div class="input-group-append">
        <button class="btn btn-outline-secondary password-visibility-btn" type="button" aria-label="${msg('showPassword')}"
                aria-controls="${name}" data-password-toggle
                data-icon-show="bi-eye" data-icon-hide="bi-eye-slash"
                data-label-show="${msg('showPassword')}" data-label-hide="${msg('hidePassword')}" id="${name}-show-password">
            <i class="bi bi-eye" aria-hidden="true"></i>
        </button>
      </div>
    </div>
    <div class="form-text" aria-live="polite">
        <div class="input-helper-text">
            <#-- Additional helper items -->
            <#nested>
            <#if forgotPassword>
                <div class="input-helper-text-item">
                  <span class="input-helper-text-item-text">
                      <a href="${url.loginResetCredentialsUrl}" class="text-decoration-none">${msg("doForgotPassword")}</a>
                  </span>
                </div>
            </#if>
        </div>
    </div>
    <#if error?has_content>
        <div class="invalid-feedback">
            ${error}
        </div>
    </#if>

  </@group>
</#macro>

<#macro checkbox name label value=false required=false>
  <div class="form-check">
    <label for="${name}" class="form-check-label">
      <input
        class="form-check-input"
        type="checkbox"
        id="${name}"
        name="${name}"
        <#if value>checked</#if>
      />
      <span class="form-check-label-text">${label}</span>
      <#if required>
        <span class="text-danger" aria-hidden="true">&#42;</span>
      </#if>
    </label>
  </div>
</#macro>