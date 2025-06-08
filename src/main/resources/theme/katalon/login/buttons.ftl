<#macro actionGroup horizontal=false>
  <div class="mb-3">
    <div class="d-flex <#if horizontal>flex-nowrap<#else>flex-wrap</#if> gap-2">
      <#nested>
    </div>
  </div>
</#macro>

<#macro button label id="" name="" class=["btn-primary"] type="submit" extra...>
  <button class="btn <#list class as c>${c} </#list>" name="${name}" id="${id}"
          type="${type}" <#list extra as attrName, attrVal>${attrName}="${attrVal}"</#list>>
  ${kcSanitize(msg(label))?no_esc}
  </button>
</#macro>

<#macro buttonLink href label id="" class=["btn-secondary"]>
  <a id="${id}" href="${href}" class="btn <#list class as c>${c} </#list>">${kcSanitize(msg(label))?no_esc}</a>
</#macro>

<#macro loginButton>
  <@buttons.actionGroup>
    <@buttons.button id="kc-login" name="login" label="doLogIn" class=["btn-primary", "btn-lg", "w-100"] />
  </@buttons.actionGroup>
</#macro>