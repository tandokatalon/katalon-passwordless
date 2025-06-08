<#macro logoutOtherSessions>
    <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
        <div class="${properties.kcFormOptionsWrapperClass!} form-check">
            <input class="${properties.kcCheckboxInputClass!} form-check-input" type="checkbox" id="logout-sessions" name="logout-sessions" value="on" checked>
            <label class="${properties.kcLabelClass!} form-check-label" for="logout-sessions">
                ${msg("logoutOtherSessions")}
            </label>
        </div>
    </div>
</#macro>